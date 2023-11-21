class SlugGenerator
    def self.generate
      loop do
        characters = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
        slug = (0...6).map { characters[rand(characters.length)] }.join
        break slug unless RegularLink.exists?(slug: slug)
      end
    end
  end
  