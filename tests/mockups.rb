
class FakeAnimation
  def initialize(file, x, y, size); end
  def image; "the image"; end
end

class FakeColor
  def self.Red;   @@red   ||= FakeColor.new; end
  def self.Blue;  @@blue  ||= FakeColor.new; end
  def self.Green; @@green ||= FakeColor.new; end
  def red=(val); end
  def blue=(val); end
  def green=(val); end
end

