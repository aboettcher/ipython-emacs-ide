FROM bethgelab/deeplearning:cuda9.0-cudnn7

MAINTAINER Alexander Boettcher

RUN sudo pip3 install virtualenv && \
  sudo mkdir /virtualenvs && \
  cd /virtualenvs && \
  sudo virtualenv -p /usr/bin/python2.7 --system-site-packages py27 && \
  sudo virtualenv -p /usr/bin/python3.6 --system-site-packages py36 && \
  sudo chmod 777 -R ./

RUN sudo apt-get update && sudo apt-get upgrade -y

### install ubuntu packages ###
RUN sudo apt update && \
  sudo apt install -y tzdata ispell less

### install emacs ###
RUN sudo add-apt-repository -y ppa:kelleyk/emacs && \
  sudo apt update && \
  sudo apt install -y emacs25

### configure emacs ###
RUN sudo mkdir /usr/share/emacs/site-lisp/elpa
COPY installEmacsPackages.el /usr/share/emacs/site-lisp/
RUN sudo emacs --script /usr/share/emacs/site-lisp/installEmacsPackages.el
RUN sudo chmod 777 -R /usr/share/emacs/site-lisp/elpa
COPY default.el /usr/share/emacs/site-lisp/

RUN sudo pip2 install flake8 pytest && \
  sudo pip3 install flake8 pytest && \
  sudo pip2 install --upgrade /usr/share/emacs/site-lisp/elpa/jedi-core-*/ && \
  sudo pip3 install --upgrade /usr/share/emacs/site-lisp/elpa/jedi-core-*/

### configure tmux ###
COPY tmux.conf /etc/
