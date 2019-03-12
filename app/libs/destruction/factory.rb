module Destruction
  class Factory
    class DestructFactoryException < StandardError; end

    def initialize(item)
      @item = item
    end

    def get_destruction_method_object
      case destruction_method
      when 'number_of_link'
        Destruction::Methods::NumberOfLink.new(@item)
      when 'number_of_hours'
        Destruction::Methods::NumberOfHours.new(@item)
      else
        raise DestructFactoryException.new('Undefined destruction method')
      end
    end

    private

    def destruction_method
      @item.message_destruction.destruction_method
    end
  end
end