require 'yaml'
require 'matrix'

namespace(:db) do

  desc("Inserts initial data into database")
  task(:populate => :environment) do
    begin
      include ApplicationHelper
      User.destroy_all
puts "\nCreating dusan:"
      User.create! :email=> "dusan@trt.sk", :password => "dusan", :password_confirmation => "dusan", :first_name => "dusan"
      puts "Creating admin:"
      User.create! :email=> "admin@trt.sk", :password => "admin", :password_confirmation => "admin", :first_name => "alfonz"
      puts "Creating random users:"


      20.times { User.create! :email=> "#{randomStr(5)}@#{randomStr(5)}.sk", :password => "xxxx", :password_confirmation => "xxxxx", :first_name => "#{randomStr(5)}" }
      puts "#{User.count} users created\nCreating sports"


      Sport.destroy_all
      Sport.create! :name=> 'soccer', :parts=> 2, :team => true
      Sport.create! :name=> 'squash', :parts=> 3, :team => true
      Sport.create! :name=> 'streetball', :parts=> 1, :team => true
      puts "#{Sport.count} sports created\nCreating news"

      Newz.destroy_all
      Newz.create! :text => "Pes jebal kozu az do rana", :header=> "Novinka dna!", :sport_id => (Sport.find :first).id
      Newz.create! :text => "Koza jebala psa az do rana", :header=> "Tiez zaujimava tema!", :sport_id =>(Sport.find :first).id
      Newz.create! :text => "Na rad prisli riadne orgie...", :header=> "Totalna kokotina!", :sport_id =>(Sport.find :last).id
      puts "#{Newz.count} news created\nCreating ..."

    rescue Exception => e
      puts e.inspect
    end
  end

end
