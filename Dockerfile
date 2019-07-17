FROM ojbc/java8-server-base

MAINTAINER Open Justice Broker Consortium "http://www.ojbc.org"

RUN apk add --update unzip zip tar curl

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JAVA_MAXMEMORY 256

ENV TOMCAT_MAXTHREADS 250
ENV TOMCAT_MINSPARETHREADS 4
ENV TOMCAT_HTTPTIMEOUT 20000
ENV TOMCAT_JVM_ROUTE tomcat80

RUN mkdir -p "$CATALINA_HOME"
WORKDIR /tmp

RUN curl -O https://www.apache.org/dist/tomcat/tomcat-8/v8.5.43/bin/apache-tomcat-8.5.43.tar.gz && \
	tar -xvf /tmp/apache-tomcat-8.5.43.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm $CATALINA_HOME/bin/*.bat && rm /tmp/apache-tomcat-8.5.31.tar.gz

WORKDIR $CATALINA_HOME

COPY files/tomcat-keystore conf/
COPY files/server.xml conf/
COPY files/catalina.sh bin/
COPY files/tomcat.sh /
COPY target/petclinic.war /
RUN chmod 777 /tomcat.sh
RUN chmod 777 bin/catalina.sh
#RUN /tomcat.sh

EXPOSE 8080
ENTRYPOINT ["/tomcat.sh"]
#CMD ["catalina.sh", "run"]
