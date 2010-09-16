module Security

protected

  def encrypt(s1, s2)
    Digest::SHA1.hexdigest("--#{s1}--#{s2}--")
  end

  def generate_random_string(length = 40, *args)
    chars = []
    chars += ("a".."z").to_a if args.empty? || args.include?(:lowercase)
    chars += ("A".."Z").to_a if args.empty? || args.include?(:uppercase)
    chars += ("0".."9").to_a if args.empty? || args.include?(:digits)
    return nil if chars.empty?
    Array.new(length) { chars.rand }.join
  end
end
