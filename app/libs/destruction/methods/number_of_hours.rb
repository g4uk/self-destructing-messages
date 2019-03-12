module Destruction
  module Methods
    class NumberOfHours < Destruction::MethodsBase
      def can_be_destructed
        diff_in_hours = (Time.now.utc - @item.created_at) / 3600
        diff_in_hours >= @item.message_destruction.value.to_i
      end
    end
  end
end