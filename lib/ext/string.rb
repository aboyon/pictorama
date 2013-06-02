class String

  def humanize(options)
    
    if include?("-")
      split("-").join(" ").downcase
    end

    if (options == :all_caps)
      capitalize!
    end

  end

end