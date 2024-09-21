#!/bin/bash

# Variáveis
LOG_FILE="/var/log/clamav/clamav-$(date +'%Y-%m-%d').log"
QUARANTINE_FILE="/var/log/clamav/quarentena.txt"
DIR_TO_SCAN="/home /var /etc"

# Início do processo de verificação
echo "Iniciando a verificação do ClamAV em $(date)" >> $LOG_FILE

# Executa a verificação e captura os arquivos infectados ou suspeitos
clamscan -r -i $DIR_TO_SCAN --log=$LOG_FILE --move=/var/log/clamav/quarentena/ --no-summary

# Verifica se algum arquivo foi movido para a quarentena
grep "Infected" $LOG_FILE | awk '{print $2}' >> $QUARANTINE_FILE

echo "Verificação concluída em $(date)" >> $LOG_FILE

# Se houver arquivos infectados, notifica no terminal e gera o log de quarentena
if [ -s $QUARANTINE_FILE ]; then
  echo "Arquivos infectados encontrados e listados em $QUARANTINE_FILE"
  echo "Arquivos movidos para a quarentena."
else
  echo "Nenhum arquivo infectado foi encontrado."
fi
