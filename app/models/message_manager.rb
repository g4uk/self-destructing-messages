class MessageManager
  def initialize(model)
    @model = model
  end

  def find_by_id_with_destruct(id)
    message = @model.where(id: id, destructed: false).first

    unless message.nil?
      message.increment!(:number_of_link)
      Destruction::Destruct.new(message).check_and_mark_to_destruct
    end

    message
  end

  def find_and_destruct_destructed
    @model.where(destructed: true).delete_all
  end
end