FROM ubuntu

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nginx git rubygems nodejs

RUN gem install bundler

ADD mm /var/deploy
RUN cd /var/deploy && bundle install && middleman build

RUN rm /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/sites-enabled/gamepad

CMD nginx
