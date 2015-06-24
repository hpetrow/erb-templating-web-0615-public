class Movie
  attr_reader :title, :release_date, :director, :summary
  @@all = []

  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date.to_i
    @director = director
    @summary = summary
    @@all << self
  end

  def url
    "#{self.title.downcase.gsub(" ", "_")}.html"
  end

  def self.all
    @@all
  end

  def self.reset_movies!
    @@all.clear
  end

  def self.make_movies!
    File.open("spec/fixtures/movies.txt").each_line {|line|
      data = line.split(" - ")
      Movie.new(*data)
    }
  end

  def self.recent
    @@all.select{|movie|
      movie.release_date >= 2012
    }
  end
end
