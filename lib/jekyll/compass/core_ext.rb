class Hash
  # Merges self with another hash, recursively.
  #
  # Returns the merged self.
  def deep_merge!(hash)
    hash.keys.each do |key|
      if hash[key].is_a? Hash and self[key].is_a? Hash
        self[key] = self[key].deep_merge!(hash[key])
        next
      end

      self[key] = hash[key]
    end

    self
  end

  # Turn all String keys of into symbols, and return in other Hash.
  #
  # Returns the symbolized copy of self.
  def symbolize_keys
    target = self.dup

    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end

    target
  end
end
