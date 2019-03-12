class App < Sinatra::Application
  get '/' do
    @message = Message.new
    @destruction_methods = MessageDestruction.destruction_methods
    erb :index
  end

  get '/message/:id' do
    @message = MessageManager.new(Message).find_by_id_with_destruct(params[:id])
    session[:error_messages] = 'Message has destructed' if @message.nil?
    erb :'message/show'
  end

  post '/message' do
    @message = nil
    @errors = nil
    message_manager = MessageCreateManager.new(Message.new, MessageDestruction.new)
    message_manager.map_models_params!(params)
    if message_manager.valid?
      begin
        @message = message_manager.create(params)
        session[:success_messages] = "Message created. You can show it by link: #{base_url}/message/#{@message.id}"
      rescue StandardError => e
        session[:error_messages] = e.message
      end
    else
      session[:error_messages] = message_manager.error_messages
    end
    redirect '/'
  end
end