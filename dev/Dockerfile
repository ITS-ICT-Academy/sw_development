FROM python:3.11.11

ENV PYTHON_REQUIREMENTS python_requirements.txt

COPY ${PYTHON_REQUIREMENTS} /
RUN pip install -r ${PYTHON_REQUIREMENTS}
WORKDIR /home/code/


