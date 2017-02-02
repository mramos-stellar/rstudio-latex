FROM rocker/hadleyverse

MAINTAINER "kenjimyzk" 

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install -y --no-install-recommends texlive-full\
    && apt-get clean
ADD dot.latexmkrc /home/rstudio/.latexmkrc
ADD article.Rmd /home/rstudio/

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

CMD ["/init"]  
