FROM ubuntu:16.04

RUN apt-get update
RUN apt-get --assume-yes upgrade
RUN apt-get --assume-yes install tmux build-essential gcc g++ make binutils
RUN apt-get --assume-yes install software-properties-common wget
# install Anaconda for current user
RUN mkdir downloads
RUN cd downloads
RUN wget "https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh" -O "Anaconda2-4.2.0-Linux-x86_64.sh"
RUN bash "Anaconda2-4.2.0-Linux-x86_64.sh" -b
ENV PATH="/root/anaconda2/bin:${PATH}"
RUN conda install -y bcolz
RUN conda upgrade -y --all
# install and configure theano
RUN pip install theano

# install and configure keras
RUN pip install keras==1.2.2
RUN mkdir ~/.keras
RUN echo '{ \
     "image_dim_ordering": "th", \
     "epsilon": 1e-07, \
     "floatx": "float32", \
     "backend": "theano" \
 }' > ~/.keras/keras.json
# configure jupyter and prompt for password

RUN echo "[global]\
device = gpu\
floatX = float32\
\
[cuda]\
root = /usr/local/cuda" > ~/.theanorc

# Install neon
RUN apt-get install -y git
WORKDIR /
RUN git clone https://github.com/NervanaSystems/neon
RUN pip install virtualenv
RUN cd neon && make sysinstall

WORKDIR /
RUN git clone https://github.com/NervanaSystems/ngraph.git
RUN cd ngraph && make install

COPY jupyter.sh /jupyter.sh
RUN chmod +x /jupyter.sh

ENTRYPOINT ["bash", "/jupyter.sh"]
