FROM python:3.11.11

ENV DEBIAN_FRONTEND=noninteractive

ARG CONFIG_PATH

COPY --from=basefolder "${CONFIG_PATH}"/ /first-time-config
WORKDIR /first-time-config
RUN bash /first-time-config/dev.sh && rm -rf /first-time-config/
WORKDIR /home

