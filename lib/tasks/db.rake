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
			User.create! :email=> "aiwen@trt.sk", :password => "aiwen", :password_confirmation => "aiwen", :first_name => "ivanko"
      puts "Creating random users:"


      20.times { User.create! :email=> "#{randomStr(5)}@#{randomStr(5)}.sk", :password => "xxxx", :password_confirmation => "xxxxx", :first_name => "#{randomStr(5)}" }
      puts "#{User.count} users created\nCreating sports"


      Sport.destroy_all
      Sport.create! :name=> 'badminton', :parts=> 2, :team => true
      Sport.create! :name=> 'basketbal', :parts=> 3, :team => true
      Sport.create! :name=> 'soccer', :parts=> 2, :team => true
      Sport.create! :name=> 'voleyball', :parts=> 3, :team => true
      Sport.create! :name=> 'bowling', :parts=> 1, :team => true
      puts "#{Sport.count} sports created\nCreating news"

      Newz.destroy_all
      Newz.create! :text => "Pes jebal kozu az do rana", :header=> "Novinka dna!", :sport_id => (Sport.find :first).id
      Newz.create! :text => "Koza jebala psa az do rana", :header=> "Tiez zaujimava tema!", :sport_id =>(Sport.find :first).id
      Newz.create! :text => "Na rad prisli riadne orgie...", :header=> "Totalna kokotina!", :sport_id =>(Sport.find :last).id
      ids = (Sport.find :all).collect {|aa| aa.id}
      20.times {Newz.create! :text => randomStr(rand 50 + 20), :header=>  randomStr(rand 20 + 5), :sport_id =>ids.rand}
      puts "#{Newz.count} news created\nCreating ..."

    rescue Exception => e
      puts e.inspect
    end
  end

end
