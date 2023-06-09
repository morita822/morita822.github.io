FROM ruby:3.1.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:2.3.26
RUN bundle install
COPY . /app
CMD ["rails", "server", "-b", "0.0.0.0"]
