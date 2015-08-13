module BookMark
  module Routes
    class Session < Base

      get '/sessions/new' do
        erb :'sessions/new'
      end

      post '/sessions' do
        user = User.authenticate(params[:email], params[:password])
        if user
          session[:user_id] = user.id
          redirect to('/links')
        else
          flash.now[:errors] = ['The emails or password is incorrect']
        end
      end

      delete '/sessions' do
        session.clear
        flash.now[:notice] = ['goodbye!']
      end
    end
  end
end