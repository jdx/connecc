source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'haml'
gem 'devise'
gem 'formtastic'
gem 'prawn-fast-png', :git => "git://github.com/amberbit/prawn-fast-png.git"
gem 'prawn', :git => "git://github.com/sandal/prawn.git", :submodules => true
gem 'money'
gem 'google4r-checkout', '1.1',:git => 'git://github.com/nbudin/google4r-checkout.git', :ref => '9825da4427b0dab73906'
gem 'jammit'
gem 'hpricot'
gem 'heroscale'
gem 'dalli'
gem 'rmagick'
gem 'delayed_job'
gem 'aws-s3'

group :development do
  gem 'heroku_san'
  gem 'ruby_parser'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'email_spec'
end

group :test, :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'ruby-debug'
end
