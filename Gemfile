source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'bcrypt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'faker'
gem 'fast_jsonapi'
gem 'figaro'
gem 'jwt'
gem 'pg', '>= 0.18', '< 2.0'
gem 'rack-cors'
gem 'raddocs'
gem 'rails', '~> 6.1', '>= 6.1.1'
gem 'rspec_api_documentation'
gem 'rswag'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner-active_record'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'puma'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
