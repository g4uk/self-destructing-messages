ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rubygems'

require 'pg'
require 'active_record'

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?

require 'sass/plugin/rack'
require 'active_support/core_ext'
require 'erb'

APP_ROOT = File.expand_path('../..', __FILE__)

require File.join(APP_ROOT, 'config', 'configure')
require File.join(APP_ROOT, 'app', 'app')
require File.join(APP_ROOT, 'app', 'libs', 'destruction', 'methods', 'base')

Dir[File.join(Sinatra::Application.root, 'app', 'libs', '**/*.rb')].each do |lib_file|
  require lib_file
end

Dir[File.join(Sinatra::Application.root, 'app', 'helpers', '*.rb')].each do |helper_file|
  require helper_file
end

Dir[File.join(Sinatra::Application.root, 'app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack