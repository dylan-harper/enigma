module Encryption

  def combine_key_offset(key, offset)
    combined = {}
    key.each_pair do |key, x|
      offset.each_pair do |offset, y|
        if key == offset
          add = x.to_i + y.to_i
          combined[key] = add.to_s
        end
      end
    end
    combined
  end

  def applies_keys(message, key, offset)
    combined = {}
    key.each_pair do |key, x|
      offset.each_pair do |offset, y|
        if key == offset
          add = x.to_i + y.to_i
          combined[key] = add.to_s
        end
      end
    end

    characters_array = message.chars

    encrypted_message = []
    characters_array.each_with_index do |char, index|
      if index == 0 || index % 4 == 0
        move = combined["A"].to_i
      elsif index == 1 || index % 4 == 1
        move = combined["B"].to_i
      elsif index == 2 || index % 4 == 2
        move = combined["C"].to_i
      elsif index == 3 || index % 4 == 3
        move = combined["D"].to_i
      end
        @alphabet.each_with_index do |letter, ind|
          if char == letter
            new_ind = ind + move
            if @alphabet[new_ind] == nil
              while @alphabet[new_ind] == nil do
                new_ind = new_ind - 27
              end
            end
            replace = @alphabet[new_ind]
            encrypted_message << replace
        end
      end
    end
    encrypted_message = encrypted_message.join("")
    k = key.values.join
    k = k.chars
    k.delete_at(1)
    k.delete_at(3)
    k.delete_at(4)
    k = k.join
    @encryption = {
      encryption: encrypted_message,
      key: k,
      date: @date
    }
    @encryption
  end
end
