# Use a imagem oficial do Python 3.11 na versão Alpine como imagem base
FROM python:3.11-alpine

# Define o diretório de trabalho no contêiner como /app
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala as dependências listadas no requirements.txt
# --no-cache-dir: Desativa o cache do pip para manter o tamanho da imagem menor
# --upgrade pip: Garante que estamos usando a versão mais recente do pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para permitir a comunicação com o contêiner
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar
# --host 0.0.0.0 torna a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]