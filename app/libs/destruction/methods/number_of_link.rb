module Destruction
  module Methods
    class NumberOfLink < Destruction::MethodsBase
      def can_be_destructed
        @item.number_of_link.to_i >= @item.message_destruction.value.to_i
      end
    end
  end
end