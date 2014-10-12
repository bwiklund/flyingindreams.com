FROM ubuntu:14.04

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nginx nodejs git ruby-dev nodejs curl build-essential

RUN gem install bundler

ADD mm /var/deploy
RUN cd /var/deploy && bundle install && middleman build

RUN rm /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/sites-enabled/gamepad

CMD nginx
