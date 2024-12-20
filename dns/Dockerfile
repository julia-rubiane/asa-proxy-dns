FROM ubuntu:latest

#executar o comando na imagem
RUN apt update -y

#atualiza os pacotes da imagem
RUN apt install bind9 dnsutils -y 

#copia o arquivo para dentro da imagem
COPY named.conf.local /etc/bind

COPY db.asa.br /etc/bind

EXPOSE 53/TCP
EXPOSE 53/UDP

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]

