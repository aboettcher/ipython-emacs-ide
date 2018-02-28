FROM bethgelab/deeplearning:cuda9.0-cudnn7

MAINTAINER Alexander Boettcher

RUN sudo pip3 install virtualenv && \
  sudo mkdir /virtualenvs && \
  cd /virtualenvs && \
  sudo virtualenv -p /usr/bin/python2.7 --system-site-packages py27 && \
  sudo virtualenv -p /usr/bin/python3.6 --system-site-packages py36 && \
  sudo chmod 777 -R ./

### install latex extension jupyterlab ###
RUN sudo apt update && \
  sudo apt install -y texlive-xetex && \
  sudo pip3 install jupyterlab_latex && \
  curl -sL https://deb.nodesource.com/setup_6.x > /tmp/in.sh && \
  sudo bash /tmp/in.sh && \
  sudo apt-get install -y nodejs && \
  sudo pip3 install jupyterlab_latex && \
  sudo jupyter serverextension enable --sys-prefix jupyterlab_latex && \
  sudo jupyter labextension install @jupyterlab/latex

### upgrade and install ubuntu packages ###
RUN sudo apt update && \
  sudo apt-get upgrade -y && \
  sudo apt install -y tzdata ispell less locales

### setup locales ###
RUN sudo locale-gen "en_US.UTF-8"

### install emacs ###
RUN sudo add-apt-repository -y ppa:kelleyk/emacs && \
  sudo apt update && \
  sudo apt install -y emacs25

### configure emacs ###
RUN sudo mkdir /usr/share/emacs/site-lisp/elpa
COPY installEmacsPackages.el /usr/share/emacs/site-lisp/
RUN sudo emacs --script /usr/share/emacs/site-lisp/installEmacsPackages.el && \
  sudo chmod 777 -R /usr/share/emacs/site-lisp/elpa
COPY default.el /usr/share/emacs/site-lisp/

RUN sudo pip2 install flake8 pytest && \
  sudo pip3 install flake8 pytest && \
  sudo pip2 install --upgrade /usr/share/emacs/site-lisp/elpa/jedi-core-*/ && \
  sudo pip3 install --upgrade /usr/share/emacs/site-lisp/elpa/jedi-core-*/

### configure tmux ###
COPY tmux.conf /etc/
