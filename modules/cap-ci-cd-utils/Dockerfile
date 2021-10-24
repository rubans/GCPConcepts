FROM hashicorp/terraform:1.0.4


RUN apk update && \
    apk upgrade && \
    apk add bash ruby-dev ruby-full build-base python3 py3-pip && \
    rm -rf /var/cache/apk/*


RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile .
RUN gem install bundler
RUN bundle install

COPY . .
RUN pip install -r requirements.txt

ENTRYPOINT ["kitchen", "--help"]
