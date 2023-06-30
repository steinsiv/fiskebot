FROM python:3.9.4-slim

ENV NAME bot
ENV APP_HOME /home/bot

RUN apt update && apt install -y gcc && rm -rf /var/lib/apt/lists/*
RUN groupadd -g 1000 -r ${NAME} && useradd -r -g ${NAME} -u 1000 ${NAME}

COPY requirements/base.txt requirements.txt
COPY --chown=${NAME}:${NAME} ./bot/* ${APP_HOME}/

RUN mkdir ${APP_HOME}/backups && chown ${NAME}:${NAME} ${APP_HOME}
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR ${APP_HOME}
USER ${NAME}

CMD ["python", "-u", "bot.py"]
