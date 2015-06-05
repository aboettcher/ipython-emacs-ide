FROM ipython/scipystack

RUN apt-get update \
  && apt-get install -y build-essential python-virtualenv wget tmux \
  && apt-get build-dep -y emacs24
RUN cd /tmp/ \
  && wget http://mirror.netcologne.de/gnu/emacs/emacs-24.5.tar.xz \
  && tar -xf emacs-24.5.tar.xz \
  && cd /tmp/emacs-24.5 \
  && ./configure \
  && make \
  && make install \
  && cd /tmp/ \
  && rm -rf emacs-*

RUN curl -fsSkL https://raw.github.com/cask/cask/master/go | python
RUN export PATH="/root/.cask/bin:$PATH" \
  && cd /root/.emacs.d && cask init \
  && echo "(depends-on \"jedi\")" >> Cask \
  && echo "(depends-on \"virtualenvwrapper\")" >> Cask \
  && echo "(depends-on \"magit\")" >> Cask \
  && cask install

RUN pip3 install flake8
RUN pip2 install flake8
RUN pip2 install --upgrade /root/.emacs.d/.cask/24.5.1/elpa/jedi-core-20150422.209/
RUN pip3 install --upgrade /root/.emacs.d/.cask/24.5.1/elpa/jedi-core-20150422.209/
RUN pip2 install theano
RUN pip3 install theano

RUN mkdir /root/.virtualenvs \
  && cd /root/.virtualenvs \
  && virtualenv -p /usr/bin/python2.7 --system-site-packages py27 \
  && virtualenv -p /usr/bin/python3.4 --system-site-packages py34

COPY .emacs /root/.emacs
COPY .tmux.conf /root/.tmux.conf
