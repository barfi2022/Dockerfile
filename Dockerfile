FROM alpine:latest
RUN apk add --no-cache curl unzip openssl
RUN curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip" && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray.zip

CMD UUID="b831381d-6324-4d53-ad4f-8cda48b30811" && \
    printf '{"log":{"loglevel":"warning"},"inbounds":[{"port":10000,"protocol":"vless","settings":{"clients":[{"id":"%s"}],"decryption":"none"},"streamSettings":{"network":"ws","wsSettings":{"path":"/api/v1/sync"}}}],"outbounds":[{"protocol":"freedom"}]}' "$UUID" > /etc/xray.json && \
    /usr/local/bin/xray run -c /etc/xray.json
