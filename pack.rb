class Pack
  def initialize
    @pack = ['2H','2D','2C','2S','3H','3D','3C','3S','4H','4D','4C','4S','5H','5D','5C','5S',
      '6H','6D','6C','6S','7H','7D','7C','7S','8H','8D','8C','8S','9H','9D','9C','9S',
      'TH','TD','TC','TS','JH','JD','JC','JS','QH','QD','QC','QS','KH','KD','KC','KS',
      'AH','AD','AC','AS']
  end
  # Returns 2 hidden cards from the pack
  def hidden
    hidden = @pack.sample(2)
    @pack.delete_if { |el| hidden.include?(el) }
    hidden
  end
  # Returns 5 open cards from the pack
  def open
    open = @pack.sample(5)
    @pack.delete_if { |el| open.include?(el) }
    open
  end  
end 
