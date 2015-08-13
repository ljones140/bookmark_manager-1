module BookMark
  module Routes
    class Links < Base

      get '/links' do
        @links = Link.all
        erb :'links/index'
      end

      post '/links' do
        tags = params[:tag].split(/\s/).map { | tag | Tag.first_or_create(name: tag) }
        Link.create(url: params[:url], title: params[:title], tags: tags)
        redirect to('/links')
      end

      get '/links/new' do
        erb :'links/new'
      end
    end
  end
end

