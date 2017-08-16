FROM rocker/verse:latest

MAINTAINER "mramos-stellar" 

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y wget bsdtar perl ca-certificates \
    && wget --progress=dot:giga \
            http://mirror.ctan.org/systems/texlive/Images/texlive.iso \
    && mkdir /install \
    && bsdtar -xpC /install -f /texlive.iso \
    && rm /texlive.iso \
    && wget --directory-prefix=/install \
            https://raw.githubusercontent.com/mramos-stellar/rstudio-latex/master/installation.profile \
    && ./install/install-tl --profile /install/installation.profile \
    && rm -R /install && apt-get clean    
RUN tlmgr update --self --all
RUN apt-get install -y equivs
RUN wget http://www.tug.org/texlive/files/debian-equivs-2016-ex.txt
RUN equivs-build debian-equivs-2016-ex.txt
RUN apt-get remove -y texlive-base
RUN apt-get install -y freeglut3 fonts-ipaexfont fonts-ipafont
RUN dpkg -i texlive-local_2016-2_all.deb \
    && apt-get clean


# Install packages
RUN Rscript -e "install.packages(c('bookdown', 'formatR'))"
RUN Rscript -e "install.packages(c('Cairo', 'extrafont', 'tikzDevice'))"

USER rstudio

ADD dot.latexmkrc /home/rstudio/.latexmkrc
RUN Rscript -e "extrafont::font_import(prompt = FALSE)"

USER root
CMD ["/init"]  
