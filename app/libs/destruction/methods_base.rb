module Destruction
  class MethodsBase
    class DestructMethodsBaseException < StandardError; end

    def initialize(item)
      @item = item
    end

    def check_and_mark_to_destruct
      mark_to_destruct if can_be_destructed
    end

    def can_be_destructed
      raise DestructMethodsBaseException.new('Method `can_be_destructed` must be implemented all succession')
    end

    def mark_to_destruct
      @item.update_attribute(:destructed, true)
    end
  end
end