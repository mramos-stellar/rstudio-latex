FROM rocker/hadleyverse

MAINTAINER "kenjimyzk" 

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y wget bsdtar perl ca-certificates \
    && wget --progress=dot:giga \
            http://mirror.ctan.org/systems/texlive/Images/texlive.iso \
    && mkdir /install \
    && bsdtar -xpC /install -f /texlive.iso \
    && rm /texlive.iso \
    && wget --directory-prefix=/install \
            https://raw.githubusercontent.com/rchurchley/docker-texlive/latest/installation.profile \
    && ./install/install-tl --profile /install/installation.profile \
    && rm -R /install && apt-get clean    
RUN tlmgr update --self --all
RUN apt-get install -y equivs
RUN wget http://www.tug.org/texlive/files/debian-equivs-2016-ex.txt
RUN equivs-build debian-equivs-2016-ex.txt
RUN apt-get remove -y texlive-base
RUN apt-get install -y freeglut3
RUN dpkg -i texlive-local_2016-2_all.deb \
    && apt-get clean

# Change environment to Japanese(Character and DateTime)
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen ja_JP.UTF-8 \
	&& /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install packages
RUN Rscript -e "install.packages(c('bookdown', 'formatR'))"
RUN Rscript -e "install.packages(c('Cairo', 'extrafont', 'tikzDevice'))"

CMD ["/init"]  
