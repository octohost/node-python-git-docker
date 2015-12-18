FROM nodesource/trusty-base
MAINTAINER Darron Froese <darron@froese.org>

ENV NODE_ENV production
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN curl https://deb.nodesource.com/node_5.x/pool/main/n/nodejs/nodejs_5.1.1-1nodesource1~trusty1_amd64.deb > node.deb \
 && dpkg -i node.deb \
 && rm node.deb

RUN npm install -g pangyp\
 && ln -s $(which pangyp) $(dirname $(which pangyp))/node-gyp\
 && npm cache clear\
 && node-gyp configure || echo ""

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales && /usr/sbin/update-locale

RUN apt-get update \
 && apt-get upgrade -y --force-yes \
 && rm -rf /var/lib/apt/lists/*;

RUN apt-get update; \
  apt-get install -y python2.7 python2.7-dev python-pip git libyaml-dev; \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install PyYAML && pip install pre-commit
