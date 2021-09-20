module FHIRPath
  class Expression
    attr_accessor :tree

    def initialize(tree)
      @tree = tree
    end

    def to_s
      @tree.to_s
    end

    def inspect
      to_s
    end

    def clone
      clone_tree = @tree.map do |x|
        begin
          x.clone
        rescue
          # TODO: This appears to be dead code
          x
        end
      end
      FHIRPath::Expression.new(clone_tree)
    end
  end
end
