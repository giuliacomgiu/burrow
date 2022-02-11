FROM ruby:3.0
RUN apt-get update && apt-get install -y \
  apt-utils \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

WORKDIR /burrow_1

COPY package.json /burrow_1/package.json
COPY yarn.lock /burrow_1/yarn.lock
RUN yarn install

COPY Gemfile /burrow_1/Gemfile
COPY Gemfile.lock /burrow_1/Gemfile.lock
RUN bundle install

# script executed every time the container starts
# it is located at the file path
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
