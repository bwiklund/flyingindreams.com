FROM ubuntu:14.04

RUN echo "deb http://archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nginx nodejs curl build-essential

# RVM SHIT
RUN \curl -sSL https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
run /usr/local/rvm/bin/rvm-shell && rvm requirements
run /usr/local/rvm/bin/rvm-shell && rvm install 2.1.2
run /usr/local/rvm/bin/rvm-shell && rvm use 2.1.2 --default

ENV PATH /usr/local/rvm/rubies/ruby-2.0.0-p247/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# END RVM SHIT

RUN gem update --system
RUN echo "gem: --no-document" >> ~/.gemrc
RUN gem install bundler

ADD mm /var/deploy
RUN cd /var/deploy && bundle install && middleman build

RUN rm /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/sites-enabled/gamepad

CMD nginx
