class SiteGenerator

  def make_index!
    @movies = Movie.all

    html = "<!DOCTYPE html><html><head><title>Movies</title></head><body><ul>"
    @movies.each{|movie|
      html << "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"
    }
    html << "</ul></body></html>"

    File.write('_site/index.html', html)
  end

  def generate_pages!
    FileUtils.rm_rf('_site/movies')
    FileUtils.mkdir_p('_site/movies')
    html = File.read("lib/templates/movie.html.erb")
    template = ERB.new(html)
    @movies = Movie.all
    @movies.each {|movie|
      result = template.result(binding)
      File.write("_site/movies/#{movie.url}", result)
    }
  end
end
