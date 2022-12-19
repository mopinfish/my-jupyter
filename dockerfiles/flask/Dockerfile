#FROM python:3.9.7-slim-buster
FROM jupyter/datascience-notebook:python-3.9.6

WORKDIR /usr/src/app
ENV FLASK_APP=application

COPY /src/flask/requirements.txt ./

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
