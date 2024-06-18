class HashMap
  LOAD_FACTOR = 0.8
  attr_reader :length

  def initialize
    @bucket_array = Array.new(16)
    @length = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end

  def set(key, value)
    index = get_bucket_index(key)

    if bucket_array[index].nil?
      bucket_array[index] = LinkedList.new
      bucket_array[index].append(key, value)
    elsif bucket_array[index].contains?(key)
      bucket_array[index].get_node(key).value = value
      @length -= 1
    else
      bucket_array[index].append(key, value)
    end

    @length += 1
    grow_bucket_array if grow?
  end

  def get(key)
    index = get_bucket_index(key)

    unless bucket_array[index].nil?
      node = bucket_array[index].get_node(key)
      return node.value unless node.nil?
    end

    nil
  end

  def has?(key)
    index = get_bucket_index(key)
    return bucket_array[index].contains?(key) unless bucket_array[index].nil?

    false
  end

  def remove(key)
    index = get_bucket_index(key)
    return bucket_array[index].remove(key).value unless bucket_array[index].nil?

    nil
  end

  def clear
    initialize
  end

  def entries
    filled_buckets = bucket_array.filter { |bucket| !bucket.nil? }
    filled_buckets.reduce([]) do |result, bucket|
      key_value_pairs = []
      bucket.each_node { |node| key_value_pairs.push([node.key, node.value]) }
      result += key_value_pairs
      result
    end
  end

  def keys
    entries.map { |entry| entry[0] }
  end

  def values
    entries.map { |entry| entry[1] }
  end

  def to_s
    string = ''
    bucket_array.each { |bucket| string += (bucket.nil?) ? "nil\n" : "#{bucket}\n" }
    string
  end

  private

  attr_reader :bucket_array

  def get_bucket_index(key)
    hash(key) % bucket_array.length
  end

  def grow?
    entries.length >= (length * LOAD_FACTOR)
  end

  def grow_bucket_array
    key_value_pairs = entries
    @bucket_array = Array.new(bucket_array.length * 2)
    key_value_pairs.each { |pair| set(pair[0], pair[1]) }
  end
end
