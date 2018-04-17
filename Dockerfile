#
# Dockerfile for ddns
#

FROM cuteribs/alpine
MAINTAINER cuteribs <ericfine1981@live.com>

COPY ./*.sh /app/

WORKDIR /app/

#ENV Time="* * * * *"
#ENV ApiId="123456789"
#ENV ApiKey="aaabbbcc"
#ENV Domain="example.com"

ENV Script="aliyun"
ENV SubDomain="www"

RUN	apk add --no-cache wget ca-certificates openssl && \
	chmod +x /app/*.sh && \
	touch /app/cron.log

CMD "/app/$Script.sh" && echo "$Time /app/$Script.sh" > /etc/crontabs/root && crond -f
