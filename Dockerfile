FROM ruby:3.1.0
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
COPY bin/entrypoints/ /usr/bin/entrypoints
RUN chmod +x /usr/bin/entrypoints/github.sh
RUN chmod +x /usr/bin/entrypoints/entrypoint.sh

# fix root file ownership problem
# docker build -t myimage --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .
# ARG USER_ID
# ARG GROUP_ID
# RUN addgroup --gid $GROUP_ID user
# RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
# USER user
