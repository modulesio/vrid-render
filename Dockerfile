FROM debian:latest

RUN apt-get update && apt-get install -y curl && apt-get clean
RUN apt-get update && apt-get install -y \
  build-essential python curl \
  ffmpeg \
  libx11-xcb-dev libxcomposite-dev libxcursor-dev libxdamage1 libxi6 libxtst6 libnss3 libcups2 libfontconfig1 libxss1 libxrandr2 libgconf-2-4 libasound2 libpangocairo-1.0-0 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 && \
  apt-get clean
RUN curl -sSL https://get.docker.com/ | sh
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash && \
  bash -c 'NVM_DIR="/root/.nvm"; . "$NVM_DIR/nvm.sh"; nvm install 8.9.3;'
ENV PATH $PATH:/root/.nvm/versions/node/v8.9.3/bin/
ADD . /root/render
RUN bash -c 'cd /root/render && npm install --unsafe-perm'

WORKDIR /root/render/
CMD ["npm", "start"]
