#!/bin/bash


# Função para exibir o banner principal
banner() {

  echo "Modo de Uso"
  echo "Escreva o nome do script mais a opcao desejada e o nome do arquivo ou log."
  echo "Exemplo: ./script.sh 1 access.log"
  echo "Exemplo: ./script.sh 10 /caminho/Onde/EstaoArquivo/Nomerquivo.log"
  echo ""

  echo "Opção 1:  1- Detectar possíveis ataques de XSS (Cross-Site Scripting)"
  echo "Opção 2:  2- Detectar tentativas de SQL Injection"
  echo "Opção 3:  3- Detectar varredura de diretórios (Directory Traversal)"
  echo "Opção 4:  4- Detectar possíveis ataques por scanners (User-Agent suspeito)"
  echo "Opção 5:  5- Identificar tentativas de acesso a arquivos sensíveis (.env, .git, etc.)"
  echo "Opção 6:  6- Detectar possíveis ataques de força bruta a arquivos/pastas"
  echo "Opção 7:  7- Primeiro e ultimo acesso de um IP suspeito. "
  echo "Opção 8:  8- Localizar user-agent utilizado por um IP suspeito"
  echo "Opção 9:  9- Listar os ips e verificar o numero de requisições"
  echo "Opção 10: 10- Localizar acesso a um determinado arquivo sensível"


}

# Segunda função de banner (pode personalizar mais)
banner2() {


echo ""
echo ""
echo "                            db    88b 88    db    88     88 8888P    db    8888b.   dP\"Yb  88\"\"Yb   8888b.  888888   88      dP\"Yb   dP\"\"b8 .dP\"Y8     v0.01 by: Bugm4n"
echo "                           dPYb   88Yb88   dPYb   88     88   dP    dPYb    8I  Yb dP   Yb 88__dP    8I  Yb 88__     88     dP   Yb dP   \`\" \`Ybo.\""
echo "                          dP__Yb  88 Y88  dP__Yb  88  .o 88  dP    dP__Yb   8I  dY Yb   dP 88\"Yb     8I  dY 88\"\"     88  .o Yb   dP Yb  \"88 o.\`Y8b"
echo "                         dP\"\"\"\"Yb 88  Y8 dP\"\"\"\"Yb 88ood8 88 d8888 dP\"\"\"\"Yb 8888Y\"   YbodP  88  Yb   8888Y\"  888888   88ood8  YbodP   YboodP 8bodP'"
echo ""
echo ""
echo "                                                             -------------------------------------------------"
echo ""
echo "                                                                      Esta ferramenta foi criada para"
echo "                                                                      ajudar a analisar logs de forma"
echo "                                                                                    eficiente e rápida!"
echo ""
echo "                                                              -------------------------------------------------"


}


# Verifica se o parâmetro foi passado
if [ -z "${1}" ]; then
  banner2
  banner
  exit 1

# Opção 1
elif [ "${1}" == "1" ]; then
        banner2
        echo "Opcao 1"
        grep -iE "<script|%3Cscript" ${2}

# Opção 2
elif [ "${1}" == "2" ]; then
        banner2
        echo "Você escolheu a Opção 2"
        grep -iE "union|select|insert|drop|%27|%22" ${2}

# Opção 3
elif [ "${1}" == "3" ]; then
        banner2
        echo "Você escolheu a Opção 3"
        grep -E "\.\./|\.\.%2f" ${2}

# Opção 4
elif [ "${1}" == "4" ]; then
        banner2
        echo "Você escolheu a Opção 3"
        grep -iE "nikto|nmap|sqlmap|acunetix|curl|masscan|python" ${2}

# Opção 5
elif [ "${1}" == "5" ]; then
        banner2
        echo "Você escolheu a Opção 5"
        grep -iE "\.env|\.git|\.htaccess|\.bak" ${2}

# Opção 6
elif [ "${1}" == "6" ]; then
        banner2
        echo "Você escolheu a Opção 6"
        grep " 404 " ${2} | cut -d " " -f 1 | sort | uniq -c | sort -nr | head
# Opção 7
elif [ "${1}" == "7" ]; then
        banner2
        echo "Você escolheu a Opção 7"
        grep "IP" ${2} | head -n1
        grep "IP" ${2} | tail -n1

# Opção 8
elif [ "${1}" == "8" ]; then
        banner2
        echo "Você escolheu a Opção 8"
        grep "IP_SUSPEITO" ${2} | cut -d '"' -f 6 | sort | uniq

# Opção 9
elif [ "${1}" == "9" ]; then
        banner2
        echo "Você escolheu a Opção 9"
        cat ${2} | cut -d " " -f 1 | sort | uniq -c

# Opção 10
elif [ "${1}" == "10" ]; then
        banner2
        echo "Você escolheu a Opção 10"
        echo "Qual palavra voce quer buscar"
        read palavra
        echo "Buscando por '${palavra}' no arquivo ${2}"
        grep -i "${palavra}" "${2}"

# Qualquer outra opção
else
  banner
  banner2
  echo "Opção inválida."
  exit 1
fi
