FROM hsiemelink/yay:0.11

COPY data /data

# XL client
COPY xlw xlw
COPY xl-cli xl
COPY data/config-xl-cli.yaml /root/.xebialabs/config.yaml
RUN ./xlw version

# Yay
RUN mkdir /root/.yay
COPY data/yay/default-variables.yaml /root/.yay/
RUN yay /data/yay/Hello.yay