# Use an official Ruby image
FROM ruby:3.3

# Set working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client

ENV RAILS_ENV=development
ENV NODE_ENV=development     

RUN gem install foreman

# Copy Gemfiles first (for caching bundle install)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the app
COPY . .

# Expose port 3000 to the host
EXPOSE 3000

# This gets rid of an error when trying to launch the docker container where rails 
# "thinks" a server is running already on the port 
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]

# OLD Default command to start the Rails server
# CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
#
# NEW
#
# Because "bash", "-c", "..." means:
#
# ✅ Start a shell
# ✅ Execute everything inside the string as if you typed it into a terminal
# ✅ Supports &&, ||, pipes, environment substitution, etc.
CMD ["bash", "-c", "bundle install && rails server -b 0.0.0.0 -p 3000"]