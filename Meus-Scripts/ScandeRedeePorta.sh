#!/bin/bash
banner() {
        echo "Modo de Uso"
        echo "Escreva o nome do script mais a opcao desejada"
        echo "./script.sh opcao"
        echo "Exemplo: ./script.sh 1"
        echo ""
        echo " a - Portscan Utilizando Hping3"
        echo " b - PingSweep Utilizando Hbping3"
        echo " c - Portscan Utilizando NetCAt"
        echo " d - PingSweep Utilizando NetCat"
        echo " e - PingSweep Utilizando /dev/tcp"
        echo " f - PortScan Utilizando /dev/tcp"

}

banner2() {

echo ""
echo "              _____                     ____          ____             __                        ____           __          v0.01 by: Bugm4n "
echo "             / ___/_________ _____     / __ \\___     / __ \\____  _____/ /_____ ______   ___     / __ \\___  ____/ /__ "
echo "             \\__ \\/ ___/ __ \`/ __ \\   / / / / _ \\   / /_/ / __ \\/ ___/ __/ __ \`/ ___/  / _ \\   / /_/ / _ \\/ __  / _ \\"
echo "            ___/ / /__/ /_/ / / / /  / /_/ /  __/  / ____/ /_/ / /  / /_/ /_/ (__  )  /  __/  / _, _/  __/ /_/ /  __/"
echo "           /____/\\___/\\__,_/_/ /_/  /_____/\\___/  /_/    \\____/_/   \\__/\\__,_/____/   \\___/  /_/ |_|\\___/\\__,_/\\___/ "
echo ""
echo ""
echo "                                      -------------------------------------------------"
echo ""
echo "                                               Ferramenta criada para realizar"
echo "                                           varreduras eficientes de redes e portas!"
echo ""
echo "                                      -------------------------------------------------"
echo""

}

# Exibe ambos os banners ao começar o script
        banner2
        banner

# Exibe o menu apenas se nenhum parâmetro for passado
        if [ -z "${1}" ]; then
        exit 1
        fi

if [ "${1}" = "a" ]; then

        echo "Opcao escolhida: 1"
        echo ""
        echo "PortScan Utilizando Hping3"
        echo ""
        echo "Digite IP. Ex: 192.168.0.1"
        read ip
        echo "Digite a porta inicial. Ex: 22"
        read portai
        echo "Digite a porta final Ex: 1000"
        read portaf
        echo ""
        sudo hping3 $ip -S --scan $portai-$portaf


elif [ "${1}" = "b" ]; then
        echo "Opcao escolhida: 2"
        echo "Digite IP da Rede - Ex: 192.168.0"
        read ip
        for i in $(seq 1 254);do
                if [ -n "$(sudo hping3 -1 -c 1 $ip.$i 2>/dev/null | grep 'ttl')" ]; then echo “$ip.$i”; fi
        done
elif [ "${1}" = "c" ]; then
        echo "Opcao escolhida: 3"
        echo "Digite o IP - Ex: 192.168.0.1"
        read ip
        echo "Digite a porta inicial - Ex: 1"
        read portai
        echo "Digite a porta final - Ex: 6500"
        read portaf
        nc -v -n -z $ip $portai-$portaf

elif [ "${1}" = "d" ]; then
        echo "Opcao escolhida: 4"
        echo "Digite o IP que deseja escanear (ex: 192.168.1.10)"
        read ip
        echo "Digite a porta que deseja verificar (ex: 80)"
        read porta
        echo ""

        echo "Realizando análise do host $ip na porta $porta..."
        sleep 1  # opcional: pequena pausa para efeito visual

        nc -zvw 1 $ip $porta &> /dev/null
        if [ $? -eq 0 ]; then
                echo "Host $ip com porta $porta ABERTA"
        else
                echo "Host $ip com porta $porta FECHADA"
        fi


elif [ "${1}" = "e" ]; then


        trap "echo -e '\nInterrompido pelo usuário.'; exit" SIGINT

        # Solicitar o IP da rede e a porta
        echo "Digite o IP da Rede - Ex: 192.168.0"
        read ip
        echo "Digite a porta de pesquisa - Ex: 80"
        read porta

        # Loop para escanear os IPs da rede e verificar se a porta está aberta
        for i in $(seq 1 254); do
        if timeout 0.5 bash -c "echo > /dev/tcp/$ip.$i/$porta" 2>/dev/null; then
                echo "Host: $ip.$i ativo, porta $porta aberta"
        fi
        done


elif [ "${1}" = "f" ]; then

        echo "Digite o IP - Ex: 192.168.0.1"
        read ip
        echo "Digite a porta inicial - Ex: 1"
        read portai
        echo "Digite a porta final - Ex: 6500"
        read portaf

         # Interrompe o script ao pressionar Ctrl + C
        trap "echo -e '\nScan cancelado pelo usuário.'; exit" SIGINT

        for i in $(seq $portai $portaf); do timeout 0.5 bash -c "</dev/tcp/$ip/$i" 2>/dev/null && echo "Porta $i aberta no host $ip"
    done

fi
