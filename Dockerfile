
FROM fabric8/s2i-java:3.0-java8 

ENV IGNITE_VERSION=2.7.0

##RUN curl https://dist.apache.org/repos/dist/release/ignite/${IGNITE_VERSION}/apache-ignite-${IGNITE_VERSION}-bin.zip -o ignite.zip \
##    && unzip ignite.zip \
##    && rm ignite.zip


RUN curl http://daems.org/ignite/apache-ignite-2.7.0.zip -o ignite.zip \
    && unzip ignite.zip \
    && rm ignite.zip

COPY config /config

# https://hub.docker.com/r/fabric8/s2i-java
# provides documentation

ENV JAVA_APP_DIR=/opt/jboss

#ENV JAVA_LIB_DIR

ENV JAVA_OPTIONS="-XX:+AggressiveOpts -Xms1g -Xmx1g -server -XX:MaxMetaspaceSize=256m -DIGNITE_QUIET=false -Djava.net.preferIPv4Stack=true"

ENV JAVA_MAJOR_VERSION=8

#ENV JAVA_MAX_MEM_RATIO
#ENV JAVA_INIT_MEM_RATIO
#ENV JAVA_MAX_CORE
#ENV JAVA_DIAGNOSTICS
ENV JAVA_MAIN_CLASS="org.apache.ignite.startup.cmdline.CommandLineStartup"

#ENV JAVA_APP_JAR

ENV JAVA_APP_NAME=ignite-node

ENV IGNITE_HOME="${JAVA_APP_DIR}/apache-ignite-2.7.0-bin"

ENV JAVA_CLASSPATH="${IGNITE_HOME}/libs/*:${IGNITE_HOME}/libs/ignite-indexing/*:${IGNITE_HOME}/libs/ignite-spring/*:${IGNITE_HOME}/libs/licenses/*:${IGNITE_HOME}/libs/optional/ignite-rest-http/*:${IGNITE_HOME}/libs/optional/ignite-kubernetes/*"


#ENV JAVA_DEBUG
#ENV JAVA_DEBUG_SUSPEND
#ENV JAVA_DEBUG_PORT=5005

#ENV HTTP_PROXY
#ENV HTTPS_PROXY
#ENV no_proxy, NO_PROXY



##ENV IGNITE_HOME=${JAVA_APP_DIR}

ENV IGNITE_LIBS="${IGNITE_HOME}/libs/*"

#ENV CONFIG=config/default-config.xml
ENV CONFIG=/config/example-kube-rbac.xml


# "0" search jmx port, "1" disable jmx
# is done in bash file
ENV NOJMX="1"

# "0" no interactive, "1" yes interactive
ENV INTERACTIVE="0"

# 
ENV QUIET="-DIGNITE_QUIET=false"

#ENV IGNITE_PROG_NAME=ignite-node


RUN mkdir /opt/jboss/apache-ignite-2.7.0-bin/work && chmod 777 /opt/jboss/apache-ignite-2.7.0-bin/work


CMD /usr/local/s2i/run ${CONFIG}


# echo on Darwin
##java \
##-XX:+AggressiveOpts -Xms1g -Xmx1g -server -XX:MaxMetaspaceSize=256m \
##-Dcom.sun.management.jmxremote \
##-Dcom.sun.management.jmxremote.port=49113 \
##-Dcom.sun.management.jmxremote.authenticate=false \
##-Dcom.sun.management.jmxremote.ssl=false \
##'-Xdock:name=Ignite Node' \
##-DIGNITE_QUIET=false \
##-DIGNITE_SUCCESS_FILE=/Users/hdaems/Downloads/apache-ignite-2.7.0-bin/work/ignite_success_459e10d4-6b0f-4a9b-a430-e17cc82bc12c \
##-DIGNITE_HOME=/Users/hdaems/Downloads/apache-ignite-2.7.0-bin \
##-DIGNITE_PROG_NAME=./ignite.sh \
##-cp '/Users/hdaems/Downloads/apache-ignite-2.7.0-bin/libs/*:/Users/hdaems/Downloads/apache-ignite-2.7.0-bin/libs/ignite-indexing/*:/Users/hdaems/Downloads/apache-ignite-2.7.0-bin/libs/ignite-spring/*:/Users/hdaems/Downloads/apache-ignite-2.7.0-bin/libs/licenses/*' \
##org.apache.ignite.startup.cmdline.CommandLineStartup \
##config/default-config.xml


# echo on Darwin
#export IGNITE_HOME=/Users/hdaems/Downloads/apache-ignite-2.7.0-bin java \
#-XX:+AggressiveOpts -Xms1g -Xmx1g -server -XX:MaxMetaspaceSize=256m \
#-DIGNITE_QUIET=false \
#-DIGNITE_HOME="${IGNITE_HOME}" \
#-cp "'${IGNITE_HOME}/libs/*:${IGNITE_HOME}/libs/ignite-indexing/*:${IGNITE_HOME}/libs/ignite-spring/*:${IGNITE_HOME}/libs/licenses/*'" \
#org.apache.ignite.startup.cmdline.CommandLineStartup \
#config/default-config.xml

