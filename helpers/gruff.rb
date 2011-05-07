def gruff_pie(title, data, qid, demo_id)
  g = Gruff::Pie.new
  g.title = title
  data.each do |d|
    g.data d[0], d[1]
  end
  g
end
