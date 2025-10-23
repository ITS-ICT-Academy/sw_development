FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG CONFIG_PATH

COPY --from=basefolder "${CONFIG_PATH}"/dev /first-time-config
WORKDIR /first-time-config
RUN bash /first-time-config/main.sh && rm -rf /first-time-config/
WORKDIR /home
