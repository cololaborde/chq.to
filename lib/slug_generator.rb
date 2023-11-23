class SlugGenerator

  attr_accessor :slug_size, :range_0, :range_1, :range_2

  @slug_size = 5
  @range_0 = ('a'..'z')
  @range_1 = ('A'..'Z')
  @range_2 = ('0'..'9')
  
  def self.possible_combinations
    combinations = (@range_0.count + @range_1.count + @range_2.count) ** @slug_size
    combinations
  end
  
  def self.generate
    three_quarter = (possible_combinations * 0.75).to_i
    loop do
      if Link.count >= three_quarter
        @slug_size += 1
        three_quarter = (possible_combinations * 0.75).to_i
      end
      characters = [@range_0, @range_1, @range_2].map(&:to_a).flatten
      slug = (0...@slug_size).map { characters[rand(characters.length)] }.join
      break slug unless Link.exists?(slug: slug)
    end
  end
end
  