class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new
  end

  def count
    store.length
  end

  def extract
    @store.pop
  end

  def peek
    store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(self, -1)
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

  def self.heapify_down(array, parent_idx, len = array.length)
    children = BinaryMinHeap.child_indices(len, parent_idx)
    return array if children.empty? 
    if prc.call(array[parent_idx], array[children.first]) == 1
      array[parent_idx], array[children.first] = array[children.first], array[parent_idx]
    end
    return BinaryMinHeap.heapify_down(array, children.first, len, prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc || Proc.new { |parent, child| parent <=> child }

    parent_idx = BinaryMinHeap.parent_index(child_idx)
    return array if child_idx == 0
    if prc.call(array[child_idx], array[parent_idx]) == -1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
    end
    return BinaryMinHeap.heapify_down(array, parent_idx, len, prc)
  end
end
