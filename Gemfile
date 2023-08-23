source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem 'sassc-rails'
gem "rails", "~> 7.0.2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "jsbundling-rails"
gem "hotwire-livereload", "~> 1.1"
gem "turbo-rails", '~> 1.0.0'

gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "sprockets-rails"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
# gem "font-awesome-rails"
gem "letter_opener", group: :development

gem 'devise-i18n'
gem 'rails-i18n', '~> 7.0.0'

gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'

gem "devise", github: "ghiculescu/devise", branch: "error-code-422"
gem "responders", github: "heartcombo/responders"
gem "pundit", "~> 2.2"

gem "omniauth-rails_csrf_protection"
gem "omniauth"
gem 'omniauth-vkontakte'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'

gem "simple_form", "~> 5.1.0"

# наследие railstart
gem "dotenv-rails", "~> 2.7"
gem "sidekiq", "~> 6.3"
gem "whenever", "~> 1.0", require: false

gem "awesome_print", "~> 1.9"

gem "rails_admin", "~> 3.0.beta2"

gem "pghero", "~> 2.8"

gem "meta-tags", "~> 2.16"

# gem "inline_svg", "~> 1.8"
# gem "font-awesome-rails", "~> 4.7"
gem "font_awesome5_rails", "~> 1.5"

# gem "devise", "~> 4.8" TODO: может надо заменить мой девайс на этот?

gem "groupdate", "~> 6.0"
gem "apexcharts", "~> 0.1.11"
# gem "chartkick", "~> 4.1"

group :development do
  gem "ffaker", "~> 2.20"
  # gem "faker", "~> 2.19"
end

group :production do
  # UglifyJS only works with ES5. If you need to compress ES6, ruby-terser is a better option.
  # gem "uglifier"
  gem "terser", "~> 1.1"
end

gem "tinymce-rails", "~> 5.10"
gem "tinymce-rails-langs", "~> 5.20200505"

gem "remixicon", "~> 1.0"

# optional: just for generate svg
gem "bootstrap-icons-helper", "~> 2.0"

gem "bootstrap_icons_rubygem", "~> 0.1.0"

gem "quill-editor-rails"

gem 'activestorage-aliyun', '~> 1.1'

gem "sentry-ruby"
gem "sentry-rails"
gem "sentry-sidekiq"

gem "loaf", "~> 0.10.0"
gem 'slim-rails'

group :development do
  gem "web-console"
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'

  # наследие от railstart
  # gem "capistrano-rvm", "~> 0.1.2"
  # gem "capistrano3-puma", "~> 5.2"
  # gem "capistrano-rails-console", "~> 2.3", require: false
  # gem "capistrano-db-tasks", "~> 0.6", require: false
  # gem "capistrano-sidekiq", "~> 2.0"
  # # fix net-ssh bug for deploy
  # gem "ed25519", "~> 1.3"
  # gem "bcrypt_pbkdf", "~> 1.1"
end

group :development, :test do
  gem 'pry'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "faker", "~> 2.23"
