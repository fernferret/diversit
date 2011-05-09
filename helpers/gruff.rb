class DiversitPie < Gruff::Mini::Pie
  def initialize_ivars()
    super

    @hide_title = false
  end

  def theme_diversit()
    @red = '#ff3333'
    @green = '#339933'
    @blue = '#336699'
    @yellow = '#FFFF00'
    @black = 'black'
    @colors = [@red, @green, @blue, @yellow, @black]
    @font = 'helvetica'

    self.theme = {
      :colors => @colors,
      :additional_line_colors => [],
      :marker_color => 'white',
      :font_color => 'white',
      :background_colors => 'transparent',
      :background_image => nil
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
