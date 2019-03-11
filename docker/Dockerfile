FROM ubuntu:16.04
COPY ./sources.list /etc/apt/
RUN useradd --create-home -s /bin/bash user
RUN apt-get update && apt-get -y install git python gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm libssl-dev libffi-dev python3-dev cpio

# Fix error "Please use a locale setting which supports utf-8."
# See https://wiki.yoctoproject.org/wiki/TipsAndTricks/ResolvingLocaleIssues
RUN apt -y install locales && \
  dpkg-reconfigure locales && \
  locale-gen en_US.UTF-8 && \
  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8


WORKDIR /home/user
USER user
CMD ["/bin/bash"]


