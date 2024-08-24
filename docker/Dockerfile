FROM python:3.12
WORKDIR /app

RUN 
RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      openssl \
      gnupg \
      software-properties-common \
      && wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
      && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list \
      &&  apt-get update \
      && apt-get install terraform \
      && if [ "$(uname -m)" = "aarch64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"; \
      elif [ "$(uname -m)" = "x86_64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
      fi \
      && unzip awscliv2.zip \
      && ./aws/install \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN pip install poetry \
  && poetry config virtualenvs.create false

COPY ./pyproject.toml ./poetry.lock* ./

RUN poetry install

CMD sleep infinity
