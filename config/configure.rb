configure do
  set :sessions, true
  set :root, APP_ROOT
  set :app_file, File.join(APP_ROOT, 'app', 'app')
  set :views, File.join(APP_ROOT, 'app', 'views')
  set :database_file, File.join(APP_ROOT, 'config', 'database.yml')
  set :logging, true
  set :dump_errors, Sinatra::Base.development?
  set :raise_errors, Sinatra::Base.development?
end