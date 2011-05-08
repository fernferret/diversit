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
    @colors = [@yellow, @blue, @green, @red, @purple, @orange, @black]

    self.theme = {
      :colors => @colors,
      :marker_color => 'white',
      :font_color => 'white',
      :background_color => 'transparent'
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
