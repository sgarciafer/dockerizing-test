FROM mhart/alpine-node:5

RUN apk add --update bash openssl git perl python build-base \
&& apk add gosu --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
&& apk add dockerize --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community \
&& addgroup dashboard && adduser -s /bin/bash -D -G dashboard dashboard

ADD src/ /src
ENV HOME=/src
WORKDIR $HOME

RUN npm install \
&& chown -R dashboard:dashboard $HOME/* \
&& gosu dashboard npm install \
EXPOSE 80

CMD ["gosu", "dashboard", "node", "hello.js"]
