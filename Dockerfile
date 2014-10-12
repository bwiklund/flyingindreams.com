FROM octohost/ruby-1.9

RUN gem install middleman therubyracer --no-rdoc --no-ri

RUN gem install bundler

ADD mm /var/deploy
RUN cd /var/deploy && bundle install && middleman build

RUN rm /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/sites-enabled/gamepad

CMD nginx
