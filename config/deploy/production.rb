set :stage, :production

role :app, %w{http://95.85.39.48/:22}
role :web, %w{http://95.85.39.48/:22}
role :db,  %w{http://95.85.39.48/:22}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'http://95.85.39.48/:22, user: 'root', roles: %w{website}

set :deploy_to, "/home/root/appnaam/production"

set :rails_env, 'production'       # If the environment differs from the stage name
set :branch, 'master'