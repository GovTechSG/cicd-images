ARG ROBOTFRAMEWORK
ARG SELENIUM2LIBRARY
ARG ROBOT_FAKER
ARG DATABASELIBRARY
ARG PABOT
ARG PDFMERGE
ARG FAKER
ARG CHROMEDRIVER_VERSION
FROM debian:jessie-slim

RUN apt-get update
RUN apt-get install -y python python-pip gcc wget curl unzip libfreetype6 libfontconfig1 libxrender1 libXext6 libXdamage1 libXfixes-dev libXcomposite-dev libasound-dev libdbus-glib-1-dev libgtk2.0-0 libxt6

ENV TZ="Asia/Singapore"
ENV CHROMEDRIVER_VERSION ${CHROMEDRIVER_VERSION:-2.40}
ENV ROBOTFRAMEWORK ${ROBOTFRAMEWORK:-3.0}
ENV SELENIUM2LIBRARY  ${SELENIUM2LIBRARY:-1.7.4}
ENV ROBOT_FAKER  ${ROBOT_FAKER:-3.0.0}
ENV DATABASELIBRARY  ${DATABASELIBRARY:-0.8.1}
ENV PABOT  ${PABOT:-0.44}
ENV PDFMERGE  ${PDFMERGE:-0.0.7}
ENV FAKER  ${FAKER:-0.8.11}
ENV PYMYSQL ${PYMYSQL:-0.7.11}
ENV ROBOT_REQUESTS ${ROBOT_REQUESTS:-0.4.6}
ENV LXML ${LXML:-4.2.1}

WORKDIR /robot

ADD utils/headless-chrome /usr/bin/headless-chrome
RUN chmod a+x /usr/bin/headless-chrome

COPY ./version-info /usr/bin

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && apt-get update \
  && apt-get -y install libxi6 libgconf-2-4 \
  && apt-get -y install google-chrome-stable

RUN mv /opt/google/chrome/google-chrome /opt/google/chrome/google-chrome-browser \
   && rm /usr/bin/google-chrome-stable \
   && rm /usr/bin/google-chrome \
   && ln -s /opt/google/chrome/google-chrome-browser /usr/bin/chrome \
   && ln -s /usr/bin/headless-chrome /usr/bin/google-chrome

RUN curl -SLO "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" \
  && unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"

RUN pip install robotframework==$ROBOTFRAMEWORK
RUN pip install robotframework-selenium2library==$SELENIUM2LIBRARY
RUN pip install robotframework-faker==$ROBOT_FAKER
RUN pip install robotframework-pabot==$PABOT
RUN pip install robotframework-databaselibrary==$DATABASELIBRARY
RUN pip install setuptools --upgrade
RUN pip install pdfmerge==$PDFMERGE
RUN pip install faker==$FAKER
RUN pip install pymysql==$PYMYSQL
RUN pip install robotframework-sudslibrary
RUN pip install robotframework-requests==$ROBOT_REQUESTS
RUN pip install lxml==$LXML

ENV ORACLE_HOME /opt/oracle/instantclient_12_1
ENV LD_RUN_PATH=$ORACLE_HOME

COPY instantclient/* /tmp/

RUN \
    apt-get update && apt-get install -y unzip build-essential libssl-dev libffi-dev python-dev lib32ncurses5-dev libaio1 && rm -rf /var/lib/apt/lists/* && \
	mkdir -p /opt/oracle && \
	unzip "/tmp/instantclient*.zip" -d /opt/oracle && \
	ln -s $ORACLE_HOME/libclntsh.so.12.1 $ORACLE_HOME/libclntsh.so && \
    pip install cx_Oracle==5.3

RUN pip list
RUN chrome --version
