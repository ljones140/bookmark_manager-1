module BookMark
  module Routes

    class Home < Base

      get '/' do
        erb :index
      end
    end
  end
end

