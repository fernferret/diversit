helpers do
  def logged_in?
    return true if session[:user]
    nil
  end

  def logged_in
    return session[:user]
  end

  def link_to name, location, alternative = false
    if alternative and alternative[:condition]
      "<a href=#{alternative[:location]}>#{alternative[:name]}</a>"
    else
      "<a href=#{location}>#{name}</a>"
    end
  end

  def random_string len
   chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
   str = ""
   1.upto(len) { |i| str << chars[rand(chars.size-1)] }
   return str
  end

  def flash msg
    session[:flash] = msg
  end

  def show_flash
    if session[:flash]
      tmp = session[:flash]
      session[:flash] = false
      "<fieldset><legend>Notice</legend><p>#{tmp}</p></fieldset>"
    end
  end

  def protected!
    unless session[:user]
      redirect '/login'
    end
  end

  def showTree root
    tree = ""
    tree += "<ul>"
    tree += "<li>"
    tree += "User " + (root.user.id * 7919 % 6997).to_s + " "
    if root.parent_id == nil
      tree += "(" + root.timestamp.to_s[0..9] + ") - (" + "Choice: " + (root.choice + 64).chr + ") - "
    else
      tree += "(" + root.timestamp.to_s[0..9] + ") - "
    end
    tree += '<a href="/comment/'+root.question.id.to_s+'/'+root.id.to_s+'">'+root.body+'</a> '
    unless root.children.nil?
      root.children.each do |child|
        tree += showTree child
      end
    end
    tree += "</li>"
    tree += "</ul>"
    return tree
  end
end
