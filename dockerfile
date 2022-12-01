FROM ubuntu:20.04
WORKDIR /
RUN apt-get update && apt-get upgrade
RUN apt-get update &&apt-get install -y curl
RUN apt-get update &&apt-get install xz-utils 
RUN ARM_TOOLCHAIN_VERSION=$(curl -s https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads | grep -Po '<h4>Version \K.+(?=</h4>)') &&\
    curl -Lo gcc-arm-none-eabi.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz"
RUN mkdir /opt/gcc-arm-none-eabi
RUN tar Jxfv gcc-arm-none-eabi.tar.xz --strip-components=1 -C /opt/gcc-arm-none-eabi/
RUN echo 'export PATH=$PATH:/opt/gcc-arm-none-eabi/bin' | tee -a /etc/profile.d/gcc-arm-none-eabi.sh                     
RUN . /etc/profile
RUN apt-get update &&apt install -y libncursesw5
RUN apt-get update &&apt install make
RUN apt-get update &&apt-get install build-essential -y
RUN apt-get update && apt-get install -y telnet
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y ssh
ARG USERNAME=saitenntaisei
ARG GROUPNAME=saitenntaisei
ARG UID=1000
ARG GID=1000
ARG PASSWORD=k20021204
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


WORKDIR /home/$USERNAME/