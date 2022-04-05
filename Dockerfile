FROM openjdk:latest

####
# dependencies for building things from source
##
RUN microdnf update -y \ 
 && microdnf install gcc gzip tar ca-certificates perl make gnupg \ 
 && microdnf install wget 


#####
# build OpenSSL v3 from source, with FIPS module enabled
# https://wiki.openssl.org/index.php/OpenSSL_3.0#Installation_and_Compilation_of_OpenSSL_3.0
###
RUN cd /usr/src \
 && wget https://www.openssl.org/source/openssl-3.0.2.tar.gz \
 && tar -zxf openssl-3.0.2.tar.gz \
 && rm openssl-3.0.2.tar.gz \
 && cd openssl-3.0.2 \
 && ./config && make -j8  && make -j8 install 

RUN ln -s /usr/local/lib/libcrypto.so.3 /usr/lib64/libcrypto.so.3 \
 && ln -s /usr/local/lib/libssl.so.3 /usr/lib64/libssl.so.3

#####
# Setup Tomcat Native / API binaries
# https://tomcat.apache.org/native-doc/
##

RUN microdnf install apr-devel openssl-devel \
 && mkdir /usr/lib/tcnative

RUN cd /usr/src \
 && wget https://dlcdn.apache.org/tomcat/tomcat-connectors/native/1.2.32/source/tomcat-native-1.2.32-src.tar.gz \
 && tar -xvf tomcat-native-1.2.32-src.tar.gz \
 && rm tomcat-native-1.2.32-src.tar.gz \
 && cd tomcat-native-1.2.32-src/native \
 && ./configure --with-api=/usr/bin/apr-1-config --with-java-home=/usr/java/latest --with-ssl=yes --prefix=/usr/lib/tcnative \
 && make \
 && make install
 
RUN openssl req -x509 -newkey rsa:4096 -passout pass:test -keyout testkey.pem -out testcert.pem -sha256 -days 90 -subj '/CN=test.lehmansoftware.com' 

COPY app.jar app.jar


#ENTRYPOINT java \
# -Dserver.port=8080 \
# -jar app.jar
 
ENTRYPOINT java \
 -Dserver.port=8443 \
 -Dserver.ssl.enabled=true \
 -Djava.library.path="/usr/lib/tcnative/lib" \
 -Dserver.ssl.certificate-key-file="/testkey.pem" \
 -Dserver.ssl.certificate-file="/testcert.pem" \ 
 -jar app.jar
 
#RUN FROM CMD LINE: docker run -it -p8443:8443 tcnative-test /bin/bash