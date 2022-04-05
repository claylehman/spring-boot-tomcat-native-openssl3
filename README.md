# spring-boot-tomcat-native-openssl3

THIS PROJECT DOES NOT WORK!

If you edit the Dockerfile and remove the SSL configuration it works fine, however if you start it as is, you get the following error on startup:

```
2022-04-05 16:33:15.855  WARN 1 --- [           main] o.a.catalina.core.AprLifecycleListener   : The Apache Tomcat Native library failed to load. The error reported was [/usr/lib/tcnative/lib/libtcnative-1.so.0.2.32: /usr/lib/tcnative/lib/libtcnative-1.so.0.2.32: undefined symbol: EVP_PKEY_get_bits]

java.lang.UnsatisfiedLinkError: /usr/lib/tcnative/lib/libtcnative-1.so.0.2.32: /usr/lib/tcnative/lib/libtcnative-1.so.0.2.32: undefined symbol: EVP_PKEY_get_bits
	at java.base/jdk.internal.loader.NativeLibraries.load(Native Method) ~[na:na]
	at java.base/jdk.internal.loader.NativeLibraries$NativeLibraryImpl.open(NativeLibraries.java:388) ~[na:na]
```

See the Dockerfile for installation and configuration steps for OpenSSL 3.0.2 and Tomcat Native 1.2.32

To run this project locally (need java, and docker installed):

1) build gradle:
./gradlew clean build

2) Copy jar into current dir
cp build/libs/TCNativeExample-0.0.1-SNAPSHOT.jar app.jar

3) Build Docker image:
docker build -t tcnative-test .

4) Run docker image
docker run -it -p8443:8443 tcnative-test /bin/bash


