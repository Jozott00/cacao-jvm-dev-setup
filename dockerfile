FROM --platform=linux/amd64 ubuntu:23.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update \ 
    && apt-get install -y \
        git \
        wget \
        unzip \
        libtool \
        autoconf \
        automake \
        build-essential \
        gettext \
        binutils-dev \
        libiberty-dev \
        fastjar \
        zlib1g-dev \
        software-properties-common \
        apt-transport-https \
        locales \
        vim \
        gdb \
        doxygen


# gcc 9
RUN add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get update \
    && apt-get -y install gcc-9 g++-9 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9 \
    && update-alternatives --config gcc

# zulu7-jdk
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ARG ZULU_REPO_VER=1.0.0-2
RUN locale-gen en_US.UTF-8 \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
    && wget https://cdn.azul.com/zulu/bin/zulu-repo_${ZULU_REPO_VER}_all.deb \
    && apt-get -y install ./zulu-repo_${ZULU_REPO_VER}_all.deb \
    && apt-get update \
    && apt-get -y install zulu7-jdk zulu7-src
ENV JAVA_HOME=/usr/lib/jvm/zulu7-ca-amd64

ENV PATH=$JAVA_HOME/bin:$PATH


WORKDIR /usr/share/java

RUN wget -O junit4.jar https://repo1.maven.org/maven2/junit/junit/4.12/junit-4.12.jar
RUN wget -O hamcrest.jar https://repo1.maven.org/maven2/org/hamcrest/hamcrest-all/1.3/hamcrest-all-1.3.jar
RUN wget http://ufpr.dl.sourceforge.net/project/jasmin/jasmin/jasmin-2.4/jasmin-2.4.zip \
    && unzip jasmin-2.4.zip jasmin-2.4/jasmin.jar \
    && mv jasmin-2.4/jasmin.jar jasmin-sable.jar \
    && rm -rf jasmin-2.4 jasmin-2.4.zip

WORKDIR /dependencies

RUN wget -O - https://sourceforge.net/projects/boost/files/boost/1.81.0/boost_1_81_0.tar.gz | tar -xz
ENV CPATH=/dependencies/boost_1_81_0/
RUN cd boost_1_81_0/ && ./bootstrap.sh && ./b2 install

RUN wget -O - ftp://ftp.gnu.org/gnu/classpath/classpath-0.99.tar.gz | tar -xz
RUN cd classpath-0.99 \
    && sh autogen.sh \
    && ./configure --disable-plugin --disable-gtk-peer --disable-gconf-peer --disable-gjdoc CFLAGS="-Wno-error=stringop-truncation" \
    && make install

RUN git clone https://github.com/openjdk/jdk7.git

# By default apt is typed with /usr/lib/jvm/zulu7-ca-amd64/bin/apt
RUN alias apt='/usr/bin/apt'

ARG CACAO_GIT_REPO=https://bitbucket.org/cacaovm/cacao.git
ENV CACAO_REPO=${CACAO_GIT_REPO}

ENV DOCK_BUILD_DIR=/code/build
ENV DOCK_SRC_DIR=/code/cacao
ENV DOCK_TOOL_DIR=/tools
ENV LD_LIBRARY_PATH=${DOCK_BUILD_DIR}/src/cacao/.libs:$LD_LIBRARY_PATH
ENV CACAO_EXEC=${DOCK_BUILD_DIR}/src/cacao/cacao

RUN mkdir ${DOCK_TOOL_DIR}
