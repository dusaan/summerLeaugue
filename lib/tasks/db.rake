require 'yaml'
require 'matrix'


namespace(:db) do

  desc("Create matches for badminton leagues")
  task(:create_matches_for_badminton_leagues => :environment) do
    include ApplicationHelper
    begin
      leagues = League.find :all, :conditions => ["sport_id = ?", (Sport.find_by_name "badminton").id]
      leagues.each do |league|
        league.matches = []
        users = league.users
          while user = users.pop do 
            users.each do |looser|
             puts 1# Match.create! :league_id => league.id, :user1_id => user.id, :user2_id => looser.id
            end
          end
      end      
      Match.create
    end

  end


  desc("Create badminton players")
  task(:create_players_badminton => :environment) do
    include ApplicationHelper
    begin
      sport = Sport.find_by_name "badminton"
      sport.users.destroy_all
      6.times { User.create! :email=> "#{randomStr(5)}@#{randomStr(5)}.sk", :password => "xxxx", :password_confirmation => "xxxxx", :first_name => "#{randomStr(5)}", :sports => [sport], :league_level => 1, :ranking => (rand 300 + 150)}
      sport.reload   
      12.times { User.create! :email=> "#{randomStr(5)}@#{randomStr(5)}.sk", :password => "xxxx", :password_confirmation => "xxxxx", :first_name => "#{randomStr(5)}", :sports => [sport], :league_level => 2, :ranking => (rand 150 + 50)}
      sport.reload   

      24.times { User.create! :email=> "#{randomStr(5)}@#{randomStr(5)}.sk", :password => "xxxx", :password_confirmation => "xxxxx", :first_name => "#{randomStr(5)}", :sports => [sport], :league_level => 3, :ranking => (rand 50 + 1)}
      sport.reload   

    puts "#{sport.users.count} users belongs to #{sport.name}"
    end

  end

  desc("Assign players to baedminton leagues")
  task(:assign_players_badminton => :environment) do
    begin
      sport = Sport.find_by_name "badminton"
      sport.users.each do |user|
        league = League.find :first, :conditions => ["league_level = #{user.league_level} AND users_count < 6 "]
puts "#{user.inspect}\n#{league.inspect}\n\n\n"        
        league.users << user
        league.save
      end  
      puts "All users assigned"
    end

  end

  desc("Inserts initial data into database")
  task(:populate_badminton => :environment) do
    begin
      Round.destroy_all
      League.destroy_all
      puts "\nCreating leagues a rounds:"
      sport = Sport.find_by_name "badminton"
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton A", :teams_count => 6, :league_level => 1).id
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton B1", :teams_count => 6, :league_level => 2).id
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton B2", :teams_count => 6, :league_level => 2).id
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton C1", :teams_count => 6, :league_level => 3).id
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton C2", :teams_count => 6, :league_level => 3).id
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton C3", :teams_count => 6, :league_level => 3).id
Round.create! :starts_at=> Time.now, :finishes_at => (Time.now + 30.days), :league_id => (League.create! :name => "Badminton C4", :teams_count => 6, :league_level => 3).id   
      (League.find :all).each do |x| 
        x.sport = sport
        x.save
      end


      puts "#{League.count} leagues and #{Round.count} rounds created"
    end

  end
  task(:populate => :environment) do
    begin
      include ApplicationHelper     
      User.destroy_all
      puts "\nCreating dusan:"
      User.create! :email=> "dusan@trt.sk", :password => "dusan", :password_confirmation => "dusan", :first_name => "dusan"
      User.create! :email=> "danieeli@gmail.com", :password => "danielko", :password_confirmation => "danielko", :first_name => "dano"
      puts "Creating admin:"
      User.create! :email=> "admin@trt.sk", :password => "admin", :password_confirmation => "admin", :first_name => "alfonz"
      puts "Creating random users:"
			User.create! :email=> "aiwen@trt.sk", :password => "aiwen", :password_confirmation => "aiwen", :first_name => "ivanko"
      puts "Creating random users:"


      20.times { User.create! :email=> "#{randomStr(5)}@#{randomStr(5)}.sk", :password => "xxxx", :password_confirmation => "xxxxx", :first_name => "#{randomStr(5)}" }
      puts "#{User.count} users created\nCreating sports"


      Sport.destroy_all
      Sport.create! :name=> 'badminton', :parts=> 2, :team => false
      Sport.create! :name=> 'streetball', :parts=> 3, :team => true
      Sport.create! :name=> 'petanque', :parts=> 2, :team => true
      Sport.create! :name=> 'billiard', :parts=> 3, :team => true
      Sport.create! :name=> 'squash', :parts=> 1, :team => true
      Sport.create! :name=> 'golf', :parts=> 1, :team => true
      puts "#{Sport.count} sports created\nCreating news"

      Newz.destroy_all
      Newz.create! :text => "Pes spal az do rana", :header=> "Novinka dna!", :sport_id => (Sport.find :first).id
      Newz.create! :text => "Koza nahanala psa az do rana", :header=> "Tiez zaujimava tema!", :sport_id =>(Sport.find :first).id
      Newz.create! :text => "Vsetci bol stastni, az kym nepomreli...", :header=> "Nieco paradne sa stalo!", :sport_id =>(Sport.find :last).id
      ids = (Sport.find :all).collect {|aa| aa.id}
      20.times {Newz.create! :text => randomStr(rand 50 + 20), :header=>  randomStr(rand 20 + 5), :sport_id =>ids.rand}
      puts "#{Newz.count} news created\nCreating ..."
      
      Event.destroy_all
      ids = (User.find :all).collect {|aa| aa.id}
      100.times { Event.create! :name => randomStr(rand 20 + 5), :start_at => (Time.now + (rand 40).hours), :end_at => (Time.now + (rand 40).hours), :user_id => ids.rand}
      puts "#{Event.count} events created\nCreating ..."

    rescue Exception => e
      puts e.inspect
    end
  end
  desc("Inserts all data into database")
  task(:populate_all => :environment) do
    begin

      Rake::Task['db:populate'].invoke
      Rake::Task['db:create_players_badminton'].invoke
      Rake::Task['db:populate_badminton'].invoke    
      Rake::Task['db:assign_players_badminton'].invoke
    end
  end
end

