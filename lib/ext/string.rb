class String

  def humanize
    
    if include?("-")
      self.split("-").join(" ").downcase
    end

  end

end