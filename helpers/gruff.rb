class DiversitPie < Gruff::Mini::Pie
  def initialize_ivars()
    super

    @hide_title = false
  end

  def theme_diversit()
    @green = '#339933'
    @blue = '#336699'
    @yellow = '#FFF804'
    @red = '#ff0000'
    @black = 'black'
    @colors = [@yellow, @blue, @green, @red, @black]
    # @base_image = render_transparent_background

    self.theme = {
      :colors => %w(orange purple green white red),
      :marker_color => 'blue',
      :background_colors => 'transparent'
    }
  end
end

def gruff_pie(title, data, qid, demo_id)
  g = DiversitPie.new
  g.title = title
  g.theme_diversit()
  data.each do |d|
    g.data d[0], d[1]
  end
  g
end
