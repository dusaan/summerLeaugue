# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def randomStr(count)
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten  
    (0...count).map{ o[rand(o.length)]  }.join
  end
  def randomInt(count)
    o =  [('0'..'9')].map{|i| i.to_a}.flatten  
    (0...count).map{ o[rand(o.length)]  }.join
  end
end
