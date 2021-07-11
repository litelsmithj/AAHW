class PolyTreeNode
    attr_reader :value, :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def children
        @children.dup
    end
    
    def parent=(new_parent)
        return if self.parent == new_parent

        parent._children.delete(self) if self.parent

        @parent = new_parent
        @parent._children << self unless self.parent.nil?

        self
    end

    protected
  
    # Protected method to give a node direct access to another node's
    # children.  
    def _children
        @children
    end
end