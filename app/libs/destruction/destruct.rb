module Destruction
  class Destruct
    def initialize(item)
      @item = item
    end

    def check_and_mark_to_destruct
      destruction_method_object = Factory.new(@item).get_destruction_method_object
      destruction_method_object.check_and_mark_to_destruct
    end
  end
end