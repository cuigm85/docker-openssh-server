FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y openssh-server vim git sudo

RUN mkdir /var/run/sshd
# RUN echo 'root:screencast' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN addgroup --gid 1000 ubuntu \
  && adduser --uid 1000 --gid 1000 --disabled-password --gecos "" ubuntu \
  && echo 'ubuntu:ubuntu' | chpasswd \
  && usermod -aG sudo ubuntu \
  && passwd -e ubuntu

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
