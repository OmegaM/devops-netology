# 5.4. Практические навыки работы с Docker

#### 1.
[Удобная таблица соотношений](https://wiki.archlinux.org/title/Pacman/Rosetta)

```Dockerfile
FROM archlinux:latest
RUN yes | pacman -Syu && \
    yes | pacman -S community/ponysay
ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology"]
```
![ponysay](../imgs/ponysay.png)

miost/netology_ponysay
#### 2.

```Dockerfile
FROM amazoncorretto

RUN yum update -y && \
    yum install wget -y && \
    yum install git -y && \
    yum group install -y "Development Tools"

RUN wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo && \
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && \
    yum upgrade -y
RUN amazon-linux-extras install epel -y && \
    yum update -y

RUN yum install -y jenkins java-1.8.0-openjdk-devel

WORKDIR /usr/lib/jenkins

CMD ["java", "-jar", "jenkins.war"]
```
```bash
vagrant@vagrant:~/info$ sudo docker run --name aws -p 8080:8080 -d ver1
87dc4fec2a5b586c685c31d37e61e7cd318c92162111decd1650669d9e6c1e11
vagrant@vagrant:~/info$ sudo docker logs aws
Running from: /usr/lib/jenkins/jenkins.war
webroot: $user.home/.jenkins
2021-09-05 09:10:14.872+0000 [id=1]     INFO    org.eclipse.jetty.util.log.Log#initialized: Logging initialized @883ms to org.eclipse.jetty.util.log.JavaUtilLog
2021-09-05 09:10:15.105+0000 [id=1]     INFO    winstone.Logger#logInternal: Beginning extraction from war file
2021-09-05 09:10:17.076+0000 [id=1]     WARNING o.e.j.s.handler.ContextHandler#setContextPath: Empty contextPath
2021-09-05 09:10:17.184+0000 [id=1]     INFO    org.eclipse.jetty.server.Server#doStart: jetty-9.4.42.v20210604; built: 2021-06-04T17:33:38.939Z; git: 5cd5e6d2375eeab146813b0de9f19eda6ab6e6cb; jvm 1.8.0_302-b082021-09-05 09:10:17.663+0000 [id=1]     INFO    o.e.j.w.StandardDescriptorProcessor#visitServlet: NO JSP Support for /, did not find org.eclipse.jetty.jsp.JettyJspServlet
2021-09-05 09:10:17.763+0000 [id=1]     INFO    o.e.j.s.s.DefaultSessionIdManager#doStart: DefaultSessionIdManager workerName=node0
2021-09-05 09:10:17.778+0000 [id=1]     INFO    o.e.j.s.s.DefaultSessionIdManager#doStart: No SessionScavenger set, using defaults
2021-09-05 09:10:17.780+0000 [id=1]     INFO    o.e.j.server.session.HouseKeeper#startScavenging: node0 Scavenging every 600000ms
2021-09-05 09:10:18.657+0000 [id=1]     INFO    hudson.WebAppMain#contextInitialized: Jenkins home directory: /root/.jenkins found at: $user.home/.jenkins
2021-09-05 09:10:18.987+0000 [id=1]     INFO    o.e.j.s.handler.ContextHandler#doStart: Started w.@b93aad{Jenkins v2.303.1,/,file:///root/.jenkins/war/,AVAILABLE}{/root/.jenkins/war}
2021-09-05 09:10:19.047+0000 [id=1]     INFO    o.e.j.server.AbstractConnector#doStart: Started ServerConnector@5a5a729f{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
2021-09-05 09:10:19.054+0000 [id=1]     INFO    org.eclipse.jetty.server.Server#doStart: Started @5066ms
2021-09-05 09:10:19.062+0000 [id=21]    INFO    winstone.Logger#logInternal: Winstone Servlet Engine running: controlPort=disabled
2021-09-05 09:10:20.856+0000 [id=27]    INFO    jenkins.InitReactorRunner$1#onAttained: Started initialization
2021-09-05 09:10:20.942+0000 [id=27]    INFO    jenkins.InitReactorRunner$1#onAttained: Listed all plugins
2021-09-05 09:10:23.925+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: Prepared all plugins
2021-09-05 09:10:23.932+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: Started all plugins
2021-09-05 09:10:23.969+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: Augmented all extensions
2021-09-05 09:10:25.913+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: System config loaded
2021-09-05 09:10:25.914+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: System config adapted
2021-09-05 09:10:25.915+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: Loaded all jobs
2021-09-05 09:10:25.916+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: Configuration for all jobs updated
2021-09-05 09:10:26.013+0000 [id=40]    INFO    hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Download metadata
2021-09-05 09:10:26.063+0000 [id=40]    INFO    hudson.util.Retrier#start: Attempt #1 to do the action check updates server
2021-09-05 09:10:27.274+0000 [id=27]    INFO    jenkins.install.SetupWizard#init:

*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

5478d18d2d9a4884ae2321574d50c696

This may also be found at: /root/.jenkins/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************

2021-09-05 09:11:03.642+0000 [id=26]    INFO    jenkins.InitReactorRunner$1#onAttained: Completed initialization
2021-09-05 09:11:03.671+0000 [id=20]    INFO    hudson.WebAppMain$3#run: Jenkins is fully up and running
2021-09-05 09:11:05.085+0000 [id=40]    INFO    h.m.DownloadService$Downloadable#load: Obtained the updated data file for hudson.tasks.Maven.MavenInstaller
2021-09-05 09:11:05.087+0000 [id=40]    INFO    hudson.util.Retrier#start: Performed the action check updates server successfully at the attempt #1
2021-09-05 09:11:05.096+0000 [id=40]    INFO    hudson.model.AsyncPeriodicWork#lambda$doRun$0: Finished Download metadata. 39,073 ms
2021-09-05 09:11:26.649+0000 [id=64]    INFO    hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Periodic background build discarder
2021-09-05 09:11:26.659+0000 [id=64]    INFO    hudson.model.AsyncPeriodicWork#lambda$doRun$0: Finished Periodic background build discarder. 0 ms
```

```Dockerfile
FROM ubuntu:latest

RUN apt-get update -y && \
    apt-get upgrade -y

RUN apt-get install wget -y && \
    apt-get install gnupg -y && \
    #apt-get install gnupg1 -y && \
    #apt-get install gnupg2 -y && \
    apt-get install openjdk-11-jdk -y
RUN wget -O key https://pkg.jenkins.io/debian/jenkins.io.key
RUN apt-key add key && \
    echo 'deb https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update -y && \
    apt-get install jenkins -y
WORKDIR /usr/share/jenkins
CMD ["java", "-jar", "jenkins.war"]
```
```bash
vagrant@vagrant:~/info$ sudo docker run -p 8080:8080 --name jenkins_ubuntu --rm -d ver2
acabe775e242d0cb4fc0f33985fd3de2395fc79c4d044ed708991dd42e034c03

vagrant@vagrant:~/info$ sudo docker logs jenkins_ubuntu
Running from: /usr/share/jenkins/jenkins.war
webroot: $user.home/.jenkins
2021-09-05 10:10:40.605+0000 [id=1]     INFO    org.eclipse.jetty.util.log.Log#initialized: Logging initialized @1600ms to org.eclipse.jetty.util.log.JavaUtilLog
2021-09-05 10:10:40.896+0000 [id=1]     INFO    winstone.Logger#logInternal: Beginning extraction from war file
2021-09-05 10:10:43.308+0000 [id=1]     WARNING o.e.j.s.handler.ContextHandler#setContextPath: Empty contextPath
2021-09-05 10:10:43.455+0000 [id=1]     INFO    org.eclipse.jetty.server.Server#doStart: jetty-9.4.43.v20210629; built: 2021-06-30T11:07:22.254Z; git: 526006ecfa3af7f1a27ef3a288e2bef7ea9dd7e8; jvm 11.0.11+9-Ubuntu-0ubuntu2.20.04
2021-09-05 10:10:44.199+0000 [id=1]     INFO    o.e.j.w.StandardDescriptorProcessor#visitServlet: NO JSP Support for /, did not find org.eclipse.jetty.jsp.JettyJspServlet
2021-09-05 10:10:44.321+0000 [id=1]     INFO    o.e.j.s.s.DefaultSessionIdManager#doStart: DefaultSessionIdManager workerName=node0
2021-09-05 10:10:44.330+0000 [id=1]     INFO    o.e.j.s.s.DefaultSessionIdManager#doStart: No SessionScavenger set, using defaults
2021-09-05 10:10:44.336+0000 [id=1]     INFO    o.e.j.server.session.HouseKeeper#startScavenging: node0 Scavenging every 600000ms
2021-09-05 10:10:45.592+0000 [id=1]     INFO    hudson.WebAppMain#contextInitialized: Jenkins home directory: /root/.jenkins found at: $user.home/.jenkins
2021-09-05 10:10:46.051+0000 [id=1]     INFO    o.e.j.s.handler.ContextHandler#doStart: Started w.@e3994ef{Jenkins v2.309,/,file:///root/.jenkins/war/,AVAILABLE}{/root/.jenkins/war}
2021-09-05 10:10:46.121+0000 [id=1]     INFO    o.e.j.server.AbstractConnector#doStart: Started ServerConnector@33308786{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
2021-09-05 10:10:46.124+0000 [id=1]     INFO    org.eclipse.jetty.server.Server#doStart: Started @7120ms
2021-09-05 10:10:46.145+0000 [id=23]    INFO    winstone.Logger#logInternal: Winstone Servlet Engine running: controlPort=disabled
2021-09-05 10:10:46.856+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: Started initialization
2021-09-05 10:10:46.946+0000 [id=28]    INFO    jenkins.InitReactorRunner$1#onAttained: Listed all plugins
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.inject.internal.cglib.core.$ReflectUtils$2 (file:/root/.jenkins/war/WEB-INF/lib/guice-4.0.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
WARNING: Please consider reporting this to the maintainers of com.google.inject.internal.cglib.core.$ReflectUtils$2
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
2021-09-05 10:10:50.441+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: Prepared all plugins
2021-09-05 10:10:50.464+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: Started all plugins
2021-09-05 10:10:50.526+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: Augmented all extensions
2021-09-05 10:10:50.722+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: System config loaded
2021-09-05 10:10:50.728+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: System config adapted
2021-09-05 10:10:50.742+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: Loaded all jobs
2021-09-05 10:10:50.751+0000 [id=29]    INFO    jenkins.InitReactorRunner$1#onAttained: Configuration for all jobs updated
2021-09-05 10:10:54.066+0000 [id=43]    INFO    hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Download metadata
2021-09-05 10:10:54.200+0000 [id=43]    INFO    hudson.util.Retrier#start: Attempt #1 to do the action check updates server
2021-09-05 10:10:54.336+0000 [id=28]    INFO    jenkins.install.SetupWizard#init:

*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

ff6834523feb4eb692686c55f6740956

This may also be found at: /root/.jenkins/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************
```

![jenkis_aws](../imgs/jenkins_aws.png)

[Ссылка на образы](https://hub.docker.com/repository/docker/miost/jenkins_netology/general)

#### 3.
