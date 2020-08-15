#!/bin/bash
###################################################################
#                                                                 #
#  mediafire-dl.sh - Download de arquivos do mediafire            #
#                                                                 #
#  Informações:                                                   #
#   Criador           : Dheisom Gomes                             #
#   Contato           : https://t.me/TSA9a                        #
#   Canal no Telegram : https://t.me/shellatarcevo                #
#   Canal no Youtube  : T.S A.9                                   #
#   Grupo no Telegram : https://t.me/shell_at                     #
#                                                                 #
#  Verções:                                                       #
#   1.2 - 21/08/2019 Dheisom Gomes                                #
#     Menos logs na tela                                          #
#     O script pega o nome original do arquivo                    #
#                                                                 #
#   1.1 - 18/09/2019 Dheisom Gomes                                #
#     Agora o script verifica se tem algum erro no link antes de  #
#     baixar o arquivo                                            #
#                                                                 #
#   1.0 - 17/09/2019 Dheisom Gomes                                #
#     Projeto iniciado                                            #
#     Adicionado suporte a download por https                     #
#                                                                 #
###################################################################

baixar_pagina(){
echo -e "\033[32mLink da pagina: ${LINK}"
echo -en "\033[32m[_]Baixando pagina...\033[0m"
w="$(wget "${LINK}" -O ${HOME}/pagina 2>/dev/null)"
if [ "$?" -gt 0 ];then
	rm ${HOME}/pagina
	echo -e "\033[31m\r\033[2K[X]Erro ao baixar pagina\033[0m"
	exit 1
fi
unset w
echo -e "\033[32m\r\033[2K[*]Pagina baixada\033[0m"
}

link_http(){
echo -en "\033[32m[_]Pegando link...\033[0m"
LINK="$(awk -F 'http://download' '{print $2}' ${HOME}/pagina)"
echo "${LINK}" > ${HOME}/pagina
LINK="$(tail -1 ${HOME}/pagina)"
VERIFICAR="${LINK}"
LINK="http://download$(echo -e "${LINK%'">'}")"
rm ${HOME}/pagina
verificar_link
echo -e "\033[32m\r\033[2K[*]Link obtido"
}

link_https(){
echo -en "\033[32m[_]Pegando link...\033[0m"
LINK="$(awk -F 'https://download' '{print $2}' ${HOME}/pagina)"
echo "${LINK}" > ${HOME}/link
LINK="$(tail -1 ${HOME}/link)"
VERIFICAR="${LINK}"
LINK="https://download$(echo -e "${LINK%'">'}")"
rm ${HOME}/link
verificar_link
echo -e "\033[32m\r\033[2K[*]Link obtido"
}

verificar_link(){
echo "${VERIFICAR}" > ${HOME}/verificar
VERIFICAR="$(grep '^[0-9]' ${HOME}/verificar)"
rm ${HOME}/verificar
if [ "${VERIFICAR}" = "" ];then
	echo -e "\033[31m\r\033[2K[X]Erro ao obter link\033[0m"
	rm ${HOME}/pagina
	exit 1
else
	unset VERIFICAR
	echo -n ''
fi
pegar_nome
}

pegar_nome(){
	nome="$(awk -F '<span class="title">' '{print $2}' ${HOME}/pagina)"
	nome="$(echo -e "${nome%<*}")"
	echo "${nome}" > ${HOME}/nome
	nome="$(tail -1 ${HOME}/nome)"
	rm ${HOME}/nome
	rm ${HOME}/pagina
}

baixar_arquivo(){
echo -e "Baixando arquivo...\033[0m"
wget -q --show-progress -c "${LINK}" -O "${ARQUIVO}/${nome}"
if [ "$?" -gt 0 ];then
	echo -e "\033[31mErro ao baixar o arquivo\033[0m"
	exit 1
fi
echo -e "\033[32mArquivo baixado\033[0m"
}

case "$1" in
	'')
		echo "use: $0 <link> <pasta>"
		echo -e "\nEsse script só tem suporte a download pelo MediaFire"
		echo "Atenção: Esse script ainda está em fase beta e pode apresentar falhas"
		exit 1
		;;
	*)
		ARQUIVO="$2"
		LINK="$1"
		if [ "${ARQUIVO}" = "" ];then
			echo "A pasta onde o arquivo deve ser salvo não pode ficar em branco"
			exit 1
		fi
		URL="$(echo -e "${LINK%:*}")"
		if [ "${URL}" = "http" ];then
			baixar_pagina
			link_${URL}
			baixar_arquivo
		else
			if [ "${URL}" = "https" ];then
				baixar_pagina
				link_${URL}
				baixar_arquivo
			else
				echo "O link que você colocou não é http ou https!"
				exit 1
			fi
		fi
		;;
esac
