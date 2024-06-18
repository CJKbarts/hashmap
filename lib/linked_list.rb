class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(key, value)
    node = Node.new(key, value)
    @head = node if head.nil?

    if tail.nil?
      @tail = node
    else
      tail.next_node = node
      @tail = node
    end

    @size += 1
  end

  def at(index)
    return if index >= size

    current_node = head
    (index).times { current_node = current_node.next_node }
    current_node
  end

  def contains?(key)
    each_node { |node| return true if node.key == key }
    false
  end

  def find(key)
    index = 0
    each_node do |node|
      return index if node.key == key

      index += 1
    end
    nil
  end

  def get_node(key)
    each_node { |node| return node if node.key == key }
    nil
  end

  def to_s
    string = ''
    each_node do |node|
      string += "(#{node}) -> "
    end

    string += 'nil'
    string
  end

  def remove_at(index)
    @size -= 1
    removed_node = nil
    if index == 0
      removed_node = head
      @head = head.next_node
    elsif index == (size - 1)
      removed_node = tail
      @tail = at(index - 1)
      tail.next_node = nil
    else
      removed_node = at(index)
      at(index - 1).next_node = at(index + 1)
    end

    removed_node
  end

  def remove(key)
    remove_at(find(key))
  end

  def each_node
    current_node = head
    size.times do
      yield(current_node)
      current_node = current_node.next_node
    end
  end
end
