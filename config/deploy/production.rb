server '54.168.48.244', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/yujimoriya/.ssh/id_rsa'
set :rails_env, 'production'
set :unicorn_rack_env, 'production'
