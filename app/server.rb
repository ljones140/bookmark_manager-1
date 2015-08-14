
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require './data_mapper_setup'
require './app/helpers/apphelpers.rb'
require './app/controllers/base'
require './app/helpers/apphelpers.rb'
require './app/controllers/link'
require './app/controllers/user'
require './app/controllers/session'
require './app/controllers/tag'
require './app/controllers/home'

include BookMark::Models

module BookMark

  class Bookmark_Manager < Sinatra::Base

    use Routes::Links
    use Routes::Users
    use Routes::Session
    use Routes::Tags
    use Routes::Home

    # register Sinatra::Partial
    # set :partial_template_engine, :erb

    use Rack::MethodOverride


    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end