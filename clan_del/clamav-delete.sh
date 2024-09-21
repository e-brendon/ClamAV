#!/bin/bash

# Variáveis
QUARANTINE_FILE="/var/log/clamav/quarentena.txt"

# Verifica se o arquivo de quarentena existe e tem conteúdo
if [ -s $QUARANTINE_FILE ]; then
  echo "Iniciando a remoção dos arquivos listados em $QUARANTINE_FILE"
  
  # Loop para remover cada arquivo listado no quarentena.txt
  while IFS= read -r arquivo; do
    if [ -f "$arquivo" ]; then
      rm -f "$arquivo"
      echo "Arquivo $arquivo removido com sucesso."
    else
      echo "Arquivo $arquivo não encontrado, pode ter sido removido manualmente."
    fi
  done < "$QUARANTINE_FILE"
  
  # Limpa o arquivo de quarentena após a remoção
  echo "" > $QUARANTINE_FILE
  echo "Todos os arquivos da quarentena foram removidos."
else
  echo "Nenhum arquivo para remover. O arquivo $QUARANTINE_FILE está vazio ou não existe."
fi
