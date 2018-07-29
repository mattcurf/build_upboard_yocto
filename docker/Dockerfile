FROM ubuntu:16.04

# COPY ./sources.list /etc/apt/
RUN apt-get update && apt-get -y install git python gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm libssl-dev libffi-dev python3-dev cpio netcat-openbsd vim python-lxml python-pip locales
RUN pip install pycrypto

# Fix error "Please use a locale setting which supports utf-8."
# See https://wiki.yoctoproject.org/wiki/TipsAndTricks/ResolvingLocaleIssues
RUN dpkg-reconfigure locales && \
  locale-gen en_US.UTF-8 && \
  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN useradd --create-home -s /bin/bash user
WORKDIR /home/user
USER user
RUN mkdir /home/user/.ssh && mkdir /home/user/bin
#COPY --chown=user config /home/user/.ssh/config
#COPY --chown=user id_rsa /home/user/.ssh/id_rsa
#COPY --chown=user id_rsa.pub /home/user/.ssh/id_rsa.pub
#COPY --chown=user proxy_wrapper.sh /home/user/bin/proxy_wrapper.sh
#COPY --chown=user repo /home/user/bin
COPY --chown=user bashrc /home/user/.bashrc
#COPY --chown=user gitconfig /home/user/.gitconfig
#RUN ssh-keyscan github.intel.com >> /home/user/.ssh/known_hosts
#RUN ssh-keyscan git-ger-5.devtools.intel.com >> /home/user/.ssh/known_hosts
#RUN ssh-keyscan git-amr-4.devtools.intel.com >> /home/user/.ssh/known_hosts

CMD ["/bin/bash"]
