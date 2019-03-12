require ::File.expand_path('../config/boot', __FILE__)

require 'rake'
require 'sinatra/activerecord/rake'

desc 'Start IRB with application environment loaded'
task :console do
  exec 'irb -r ./config/boot'
end

namespace :message do
  desc 'Destruct messages which is waiting to destruct'
  task :destruct_destructed do
    MessageManager.new(Message).find_and_destruct_destructed
  end
end