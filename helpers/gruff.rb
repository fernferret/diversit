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
      :marker_color => '#eeeeee',
      :font_color => '#eeeeee',
      :background_colors => 'transparent',
      :background_image => nil
    }
  end
end

def gruff_pie(title, data, qid, demo_id, var)
  g = DiversitPie.new('300x300')
  g.title = ''
  case demo_id
  when 0
    g.title += "Gender: "
    case var
    when 0
      g.title += "Male"
    when 1
      g.title += "Female"
    end
  when 1
    g.title += "Age: "
    case var
    when 0
      g.title += "< 25"
    when 1
      g.title += "25 to 44"
    when 2
      g.title += "> 45"
    end
  when 2
    g.title += "Income: "
    case var
    when 0
      g.title += "< 40,000"
    when 1
      g.title += "40,000 to 80,000"
    when 2
      g.title += "> 80,000"
    end
  end

  g.theme_diversit()
  data.each do |d|
    g.data d[0], d[1]
  end
  g
end
