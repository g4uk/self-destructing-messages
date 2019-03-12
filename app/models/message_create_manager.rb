class MessageCreateManager
  SECURE_ID_LENGTH = 15

  def initialize(message, message_destruction)
    @message = message
    @message_destruction = message_destruction
  end

  def map_models_params!(params)
    @message.message = params[:message]
    @message_destruction.destruction_method = params[:destruction_method]
    @message_destruction.value = params[:destruction_value]
  end

  def valid?
    @message.valid? && @message_destruction.valid?
  end

  def error_messages
    @message.errors.full_messages + @message_destruction.errors.full_messages
  end

  def create(params)
    ActiveRecord::Base.transaction do
      @message.id = SecureRandom.hex(SECURE_ID_LENGTH)
      @message.message = params[:message]

      if @message.save
        @message_destruction.message_id = @message.id
        @message_destruction.save
      end
    end

    @message
  end
end