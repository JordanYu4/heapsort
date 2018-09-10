class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
  end

  def count
    store.length
  end

  def extract
    extracted = @store.shift
    # BinaryMinHeap.heapify_down(@store, 0)
    # extracted
  end

  def peek
    store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(store, count - 1)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    left_child = parent_index * 2 + 1
    right_child = parent_index * 2 + 2
    children << left_child unless left_child >= len 
    children << right_child unless right_child >= len 
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = prc || Proc.new { |parent, child| parent <=> child }
    child_indices = BinaryMinHeap.child_indices(len, parent_idx)
    p array
    p "child indices:"
    p child_indices
    child_indices.each do |child_idx|
      if prc.call(array[parent_idx], array[child_idx]) >= 1
        # swap_idx = child_indices.sort { |idx| array[idx] }[0]
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        p array
        return BinaryMinHeap.heapify_down(array, child_idx)
      end
    end
    p array
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || Proc.new { |child, parent| child <=> parent }
    return array if child_idx == 0
    
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      return BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end
end
