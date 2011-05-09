class DiversitPie < Gruff::Mini::Pie
  def initialize_ivars()
    super
  end

  def theme_diversit()
    @green1 = '#388f42'
    @green2 = '#82dc86'
    @green3 = '#20cd20'
    @green4 = '#2f7d2d'
    @black = 'black'
    @colors = [@green1, @green2, @green3, @green4, @black]

    @font = 'helvetica'
    @hide_legend = true
    @hide_line_markers = true
    @hide_line_numbers = true
    @hide_title = false
    @legend_box_size = 30
    @legend_font_size = 30
    @marker_font_size = 30

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
