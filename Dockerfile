FROM            ubuntu:14.04
MAINTAINER      Allan Lei "allanlei@helveticode.com"


# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV             DEBIAN_FRONTEND noninteractive
ENV             INITRD No


# Install updates
RUN             echo "deb http://ppa.launchpad.net/w-rouesnel/openssh-hpn/ubuntu trusty main" > /etc/apt/sources.list.d/w-rouesnel-openssh-hpn.list
RUN             echo "deb-src http://ppa.launchpad.net/w-rouesnel/openssh-hpn/ubuntu trusty main" >> /etc/apt/sources.list.d/w-rouesnel-openssh-hpn.list
RUN             apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0762518E
RUN             apt-get update && apt-get -y upgrade
RUN             apt-get install -y openssh-server

# Setup openssh
RUN             mkdir /var/run/sshd
RUN             echo "HPNDisabled no" >> /etc/ssh/sshd_config
RUN             echo "TcpRcvBufPoll yes" >> /etc/ssh/sshd_config
RUN             echo "HPNBufferSize 8192" >> /etc/ssh/sshd_config
RUN             echo "NoneEnabled yes" >> /etc/ssh/sshd_config

# Cleanup
RUN             apt-get -y autoremove && apt-get -y autoclean

EXPOSE          22

# Default command
CMD             ["/usr/sbin/sshd", "-D"]
