class String

  def humanize
    include?("-") ? self.split("-").join(" ").downcase : self
  end

end