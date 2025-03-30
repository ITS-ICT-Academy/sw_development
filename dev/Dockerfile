FROM python:3.11.11

ARG REQUIREMENTS
ARG USER_BASE_FOLDER

ENV REQUIREMENTS ${REQUIREMENTS}
ENV USER_BASE_FOLDER ${USER_BASE_FOLDER}
RUN echo "export REQUIREMENTS_FILE=$(realpath -s --relative-to=${USER_BASE_FOLDER} ${REQUIREMENTS})" >> /environment

COPY --from=basefolder "${REQUIREMENTS_FILE}" /
COPY install_python_packages.sh /
WORKDIR /
RUN bash /install_python_packages.sh
WORKDIR /home/


