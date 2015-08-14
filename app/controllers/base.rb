module BookMark
  module Routes
    class Base < Sinatra::Base

      include AppHelpers


      # register Sinatra::Partial
      # set :partial_template_engine, :erb

      use Rack::MethodOverride

      enable :sessions
      set :session_secret, 'super secret'
      register Sinatra::Flash

      set :views, proc { File.join(root,'../..','views') }
      set :public_folder, proc { File.join(root, '../..' 'public') }

    end
  end
end