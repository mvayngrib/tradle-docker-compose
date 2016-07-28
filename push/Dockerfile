FROM mhart/alpine-node:4

ARG db
ARG pushd_port
ARG port

RUN apk add --update git
RUN mkdir /opt/app
RUN git clone https://github.com/tradle/push-server /opt/app/push-server
WORKDIR /opt/app/push-server
RUN npm install --production

CMD ["node", "./cmd.js", "--db", "$db", "--port", "$port", "--pushd", "$pushd_port"]
