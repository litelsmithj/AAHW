module Searchable
    def dfs(target = nil, &prc)
        raise "Need a proc or target" if [target, prc].none?
        prc ||= Proc.new(){|node| node.value == target}

        return self if prc.call(self)

        children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end

        nil
    end

    def bfs(target = nil, &prc)
        raise "Need a proc or target" if [prc, target].none?
        prc ||= Proc.new(){|node| node.value == target}
        
        q = [self]

        until q.empty?
            node = q.shift
            return node if prc.call(node)
            q.concat(node.children)
        end

        nil
    end

    def count
        1 + children.map(&:count).inject(:+)
    end
end



class PolyTreeNode
    include Searchable
    attr_reader :value, :parent

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        @value.inspect
    end

    def children
        @children.dup
    end
    
    def parent=(new_parent)
        return if self.parent == new_parent

        parent._children.delete(self) if self.parent

        @parent = new_parent
        parent._children << self if self.parent

        self
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise "Error" unless children.include?(child) || !child

        child.parent = nil 
    end

    protected
  
    # Protected method to give a node direct access to another node's
    # children.  
    def _children
        @children
    end
end