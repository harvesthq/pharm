### Pharm

We at Iridesco could never find that "just right" photo-blogging. We want minimal configuration, minimal page noise, and big, beautiful pictures. And so, we decided to create an open source blogging engine to do just that. Heck, just install Pharm on Dreamhost and you'll be just fine to start with.

### Installation

This is a fully-formed Rails application. Thus you must know how to install Rails applications on your host.

Configuration files to update on the host:

* shared/config/database.yml
* shared/config/admin.yml
* shared/config/options.yml
* shared/config/session.secret

(admin: user/pass. options: main\_title, exception notification.)

To generate `session.secret`, visit your app current directory on your server and run:

    rake --silent secret > /path/to/app/shared/config/session.secret

environment.rb:

  ExceptionNotifier.sender_address       = %("Pharm bug" <info@iridesco.com>)
  ExceptionNotifier.exception_recipients = %w(shawn@iridesco.com barry@iridesco.com)

### Dreamhost Installation

* Get your domain, or fully-hosted subdomain ready at DH:
  - Click Ruby on Rails Passenger
  - Make sure your web directory reads for example:
    /home/username/snapped.bjhess.com/current/public/
* Create MySQL DB
  - pharm_production
  - note user/pass for the DB
* Copy deploy.rb.example to deploy.rb
  - Change DH_USERNAME to your Dreamhost username
  - Change DH_FTP_SERVER to your Dreamhost FTP address (mine's bazooka.dreamhost.com)
  - Change DH_SITE_URL to your domain name (mine's snapped.bjhess.com)
* SSH to DH, cd /home/username/domain_name
  - assure your current directory is empty
  - If so: rm -rf current
  - mkdir -p shared/uploads
  - mkdir -p shared/config
  - Using the app's config/admin.yml.example, setup DH shared/config/admin.yml
  - Using the app's config/database.yml.example, setup DH shared/config/database.yml
  - Using the app's config/options.yml.example, setup DH shared/config/options.yml
    (don't forget to specify host on Dreamhost)
* TODO: Something about setting up public key from DH on GitHub account
* Back on your local machine
  - cap deploy:setup
  - cap deploy:migrations
    o If this doesn't work for you (new changes aren't getting deployed), change:
        set :deploy_via, :remote_cache
      In deploy.rb to:
        set :deploy_via, :copy
      It'll be slow, but at least it should work.
* Visit http://yourdomain.tld/admin to add a picture. Then http://yourdomain.tld will work!

TODO: Instructions for remote cache deploy working
TODO: Can we make a simple drag and drop FTP deploy?

### Sample capistrano `deploy.rb`

    default_run_options[:pty] = true  # Force password prompt from git

    set :user, "bjhess"
    set :domain, "something.dreamhost.com"
    set :application, "snapped.bjhess.com"
  
    # should be your fork
    set :repository, "git@github.com:iridesco/pharm.git"

    set :deploy_to, "/home/#{user}/#{application}"
    set :deploy_via, :remote_cache
    set :scm, 'git'
    set :branch, 'origin/master'
    set :git_shallow_clone, 1
    set :scm_verbose, true
    set :use_sudo, false
    set :keep_releases, '10'

    server domain, :app, :web
    role :db, domain, :primary => true

    # =============================================================================
    # Custom tasks
    # =============================================================================

    namespace :deploy do
        desc "Tasks to complete after code update"
      task :after_update_code do
        configs_for = %w{database admin options}
        commands_todo = configs_for.map do |cfg|
          "ln -nfs #{deploy_to}/#{shared_dir}/config/#{cfg}.yml #{current_release}/config/#{cfg}.yml"
        end
        commands_todo << "ln -nfs #{deploy_to}/#{shared_dir}/config/session.secret #{current_release}/config/session.secret"
        commands_todo << "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
        run commands_todo.join(" && ")
      end

      desc "Restart Application"
      task :restart do
        run "touch #{current_path}/tmp/restart.txt"
      end
    end

    after "deploy", "deploy:cleanup"
    after "deploy:migrations", "deploy:cleanup"
  
### Credits

Pharm is maintained by [Barry Hess](mailto:barry@iridesco.com) and [Shawn Liu](mailto:shawn@iridesco.com), and is funded by [Iridesco](http://iridesco.com).

### License

Copyright © 2009 [Barry Hess](http://bjhess.com), [Shawn Liu](http://jiayo.net/), [Iridesco](http://iridesco.com). It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.