FROM centos:7.9.2009

RUN yum -y upgrade \
 && yum -y install openssh-server vim git sudo

RUN groupadd -g 1000 centos \
 && useradd --uid 1000 --gid 1000 centos \
 && echo "centos:centos" | chpasswd \
 && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key \
 && echo "centos    ALL=(ALL)   ALL" >> /etc/sudoers

RUN localedef -c -f EUC-KR -i ko_KR ko_KR.euckr \
 && localedef -c -f UTF-8 -i ko_KR ko_KR.utf8

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
