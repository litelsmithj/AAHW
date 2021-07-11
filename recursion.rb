require "byebug"

def range(start, e)
    return [] if e < start
    [start] + range(start+1, e)
end

class Array

    def deep_dup
        new_arr = []

        self.each do |ele|
            new_arr << (ele.is_a?(Array) ? ele.deep_dup : ele)
        end

        new_arr
    end

    def merge_sort
        return self if self.length <= 1
        middle = self.length / 2

        left = self.take(middle)
        right = self.drop(middle)
        # debugger
        merge(left.merge_sort, right.merge_sort)
    end

    def clip n=1
        take size - n
    end

end

def merge(arr1, arr2)
    return arr1 if arr2.length < 1
    return arr2 if arr1.length < 1

    if arr1.first < arr2.first
        [arr1.shift] + merge(arr1, arr2)
    else
        [arr2.shift] + merge(arr1, arr2)
    end
end

def bsearch(array, target)
    # try to redo with case-when format in answer
    middle = (array.length / 2).floor
    return middle if array[middle] == target
    return nil if array.length < 1

    left = array[0...middle]
    right = array[middle+1..-1]

    if target < array[middle]
        bsearch(left, target)
    else
        result = bsearch(right, target)
        if result == nil
            return result
        else
            middle + 1 + result
        end
    end
end

#Review
def subsets(arr)
    return [[]] if arr.empty?
    
    subs = subsets(arr.take(arr.length - 1))
    subs.concat(subs.map {|sub| sub + [arr.last]})
end

def fibonacci(n)
    return [1] if n == 1
    return [1, 1] if n == 2

    prev = fibonacci(n-1)
    next_ele = prev[-1] + prev[-2]
    prev + [next_ele]
end

def permutations(arr)
    return [arr] if arr.length <= 1

    first = arr.shift
    # make the recursive call
    perms = permutations(arr)
    # we will need an array to store all our different permutations
    total_permutations = []


    # Now we iterate over the result of our recusive call say [[1, 2], [2, 1]]
    # and for each permutation add first into every index. This new subarray
    # gets added to total_permutations.
    perms.each do |perm|
        (0..perm.length).each do |i|
        total_permutations << perm[0...i] + [first] + perm[i..-1]
        end
    end
    total_permutations
end

