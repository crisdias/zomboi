FROM python:3-slim

RUN useradd -u 1000 -m zomboi
USER zomboi
WORKDIR /home/zomboi

# Install gcc and zlib development files
USER root
RUN apt-get update
RUN apt-get install -y gcc
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libjpeg-dev

USER zomboi

COPY --chown=zomboi:zomboi requirements.txt ./
RUN pip install --upgrade pip
RUN pip install --user --no-cache-dir -r requirements.txt

COPY --chown=zomboi:zomboi . .

CMD [ "python", "zomboi.py" ]
