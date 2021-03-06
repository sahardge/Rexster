FROM jamesdbloom/docker-java7-maven

ENV DEBIAN_FRONTEND noninteractive

#Install Rexster
RUN git clone https://github.com/sahardge/Rexster.git
RUN cd Rexster && bash install-etcd.sh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential curl git
RUN curl -s https://storage.googleapis.com/golang/go1.2.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
RUN cd Rexster && bash install-rexster.sh

#Make Persisted volume
RUN mkdir /mountedvol


WORKDIR /rexster

EXPOSE 8182 8183 8184
