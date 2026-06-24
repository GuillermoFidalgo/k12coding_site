FROM ruby

WORKDIR /srv/jekyll/

COPY Gemfile* /srv/jekyll/

RUN apt-get update && apt-get install -y build-essential nodejs git && \
    rm -rf /var/lib/apt/lists/* && \
    gem install jekyll bundler && \
    gem install dnsruby csv json logger faraday faraday-retry && \
    bundle install --jobs=4 --retry=3 && \
    apt-get autoremove -y && apt-get clean

COPY . /srv/jekyll/

EXPOSE 4000

CMD ["bundle", "exec", "jekyll","serve","--force_polling","--host", "0.0.0.0","--port","4000"]
 