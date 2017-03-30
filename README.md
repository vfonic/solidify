# Solidify

[![Build Status](https://travis-ci.org/vfonic/solidify.svg?branch=master)](https://travis-ci.org/vfonic/solidify)
[![Code Climate](https://codeclimate.com/github/vfonic/solidify/badges/gpa.svg)](https://codeclimate.com/github/vfonic/solidify)
[![Test Coverage](https://codeclimate.com/github/vfonic/solidify/badges/coverage.svg)](https://codeclimate.com/github/vfonic/solidify/coverage)
[![security](https://hakiri.io/github/vfonic/solidify/master.svg)](https://hakiri.io/github/vfonic/solidify/master)
[![git.legal](https://git.legal/projects/3620/badge.svg?key=5c097d05a251758abac3 "Number of libraries approved")](https://git.legal/projects/3620)

Rails meets Shopify liquid theme files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'solidify'
```

And then execute:

    $ bundle install

## Usage

To get the necessary migrations into your app, run the following
(this assumes you have already set `solidus` with `solidus_auth_devise`):

```sh
rails generate solidify:install
```

Add these ENV variables so that Carrierwave gem can store your theme files to S3:

```yaml
AWS_ACCESS_KEY_ID: ''
AWS_SECRET_ACCESS_KEY: ''
AWS_S3_REGION: 'us-east-1'
AWS_S3_BUCKET_NAME: 'solid5-shop'
```

Run this command to seed the default theme, shop settings and link lists:

```sh
rails solidify:shop:seed_everything
```

Run `rake solidify:theme:download_all_themes` to download theme files.

[MIT License](http://opensource.org/licenses/MIT)
