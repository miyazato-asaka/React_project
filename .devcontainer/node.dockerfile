FROM node:16.17.0-alpine3.15

ENV USER strapi
ENV USER_ID 1001
ENV HOME /home/strapi
ENV LANG C.UTF-8

RUN apk update && apk add --no-cache shadow sudo tzdata \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && apk del tzdata \
  && useradd -m ${USER} -u ${USER_ID} \
  && echo "strapi:strapi" | chpasswd && echo "strapi ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && echo "Set disable_coredump false" >> /etc/sudo.conf \
  && echo "root:root" | chpasswd
RUN mv /usr/local/lib/node_modules /usr/local/lib/node_modules.tmp \
  && mv /usr/local/lib/node_modules.tmp /usr/local/lib/node_modules \
  && npm i -g npm@^8.6.0
#DEV
RUN apk add --no-cache bash curl git vim
WORKDIR /home/sample
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

USER ${USER}
WORKDIR ${HOME}/app
CMD [ "bash" ]