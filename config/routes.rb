ActionController::Routing::Routes.draw do |map|

  map.with_options :controller => 'users' do |users|
    users.new_user     'registracia',  :action => 'new', :conditions => { :method => :get }
    users.invite_self  'invite_self',  :action => 'invite_self', :conditions => { :method => :post }
  end

  map.with_options :controller => 'services' do |services|
    services.services      '/poster',  :action => 'index', :conditions => { :method => :get }
    services.poster       '/poster',  :action => 'index', :conditions => { :method => :get }
  end
  map.with_options :controller => 'newzs' do |newzs|
    newzs.contacts     '/kontakty', :action => 'contacts', :conditions => { :method => :get }
    newzs.faq     '/FAQ', :action => 'faq', :conditions => { :method => :get }

  end




  map.with_options :controller => 'tournaments' do |tournaments|
    tournaments.tournaments_            'turnaje/:sport',                          :action => 'index', :conditions => { :method => :get }
    tournaments.edit_tournament_teams   'turnaje/:tournament_id/edit',             :action => 'edit_tournament_teams',   :conditions => { :method => :get }
    tournaments.tournament_team_remove  'tournament_team/:tournament_id/:team_id',      :action => 'remove_tournament_team',  :conditions => { :method => :delete }
    tournaments.tournament_team_add     'tournament_team_add/:tournament_id/:team_id',  :action => 'tournament_team_add', :conditions => { :method => :put }
    tournaments.tournament_team_confirm 'tournament_team_confirm/:tournament_id/:team_id',  :action => 'tournament_team_confirm', :conditions => { :method => :put }
    tournaments.generate_tournament_mathces 'gen_matches/:tournament_id',  :action => 'generate_tournament_mathces', :conditions => { :method => :put }
    tournaments.tournament_matches 'tournament_matches/:tournament_id',  :action => 'tournament_matches'
  #  tournaments.show_public 'tournament_public/:id',  :action => 'show_public'
  end

  map.resources :tournaments

  map.resources :courts

  map.with_options :controller => 'invitations' do |invitation|
    invitation.accept             'invitation_a/:invitation_id',      :action => 'accept'
    invitation.decline            'invitation_d/:invitation_id',      :action => 'decline'

  end
  
map.with_options :controller => 'calendar' do |calendar|
    calendar.calendar_            'calendar/:year/:month',      :action => 'index',           :requirements => {:year => /d{4}/, :month => /d{1,2}/}, :year => nil, :month => nil
    calendar.new_calendar        'calendars/new',              :action => 'new',             :conditions => { :method => :get }
    calendar.connect             'events'   ,                  :action => 'create',          :conditions => { :method => :post }
    calendar.calendar            'events/:event_id',           :action => 'show',            :conditions => { :method => :get }
    calendar.edit_calendar       'events/:event_id/edit',      :action => 'edit',            :conditions => { :method => :get }
    calendar.event               'events/:event_id',           :action => 'update',          :conditions => { :method => :put }
    calendar.destroy_calendar    'calendars/:event_id',        :action => 'destroy',         :conditions => { :method => :delete }
    calendar.update_calendar     'calendars/update',           :action => 'update_inplace',  :conditions => { :method => :post }
  end


  map.with_options :controller => 'newzs' do |newzs|
#    newzs.default   '/',            :action => 'default', :conditions => { :method => :get }
    newzs.news      'novinky/:sport',  :action => 'index', :conditions => { :method => :get }
    newzs.rules     'pravidla/:sport', :action => 'rules', :conditions => { :method => :get }
  end

  map.with_options :controller => 'scores' do |scores|
    scores.scores  'scores/:sport', :action => 'index', :conditions => { :method => :get }
  end

  map.with_options :controller => 'users' do |users|
    users.users_        'sportovci/:sport',  :action => 'index', :conditions => { :method => :get }
    users.users_admin   'sportovci_/admin',  :action => 'index_admin', :conditions => { :method => :get }
    users.join_sport    'join_sport',     :action => 'join',  :conditions => { :method => :get }
    users.join_league   'jo/:join_string',    :action => 'join_league',  :conditions => { :method => :get }
  end

  map.with_options :controller => 'matches' do |matches|
    matches.join_free_match    'join_free_match/:match_id', :action => 'join', :conditions => { :method => :get }
    matches.edit_match_score  'edit_match_score/:id', :action => 'edit_match_score'
    matches.update_score  'update_score/:id', :action => 'update_score'
  end

  map.with_options :controller => 'leagues' do |leagues|
    leagues.leagues_             'leagues_/:sport',            :action => 'index',               :conditions => { :method => :get }
    leagues.edit_league_teams    'leagues_/:league_id/edit',   :action => 'edit_league_teams',   :conditions => { :method => :get }
    leagues.league_team_remove   'league_team/:team_id',       :action => 'remove_league_team',  :conditions => { :method => :delete }
    leagues.league_team_add 'league_team_add/:league_id/:team_id', :action => 'league_team_add', :conditions => { :method => :put }
  end

  map.with_options :controller => 'teams' do |teams|
    teams.edit_team       'teams/:id/edit',  :action => 'edit',            :conditions => { :method => :get }
    teams.teams_    'timy/:sport', :action => 'index', :conditions => { :method => :get }
    teams.invite    'invite_to_team/:team_id', :action => 'invite', :conditions => { :method => :get }
    teams.invite_temp  'reg2', :action => 'invite_temp', :conditions => { :method => :get }
    teams.user_team_remove   'remove_from_team/:user_id/:team_id',  :action => 'remove_user',  :conditions => { :method => :delete }
    teams.user_team_add 'invite_to_team/:team_id', :action => 'invite_submit', :conditions => { :method => :post }
    
    
  end

  map.with_options :controller => 'matches' do |matches|
    matches.matches_    'matches_/:sport', :action => 'index', :conditions => { :method => :get }
  end

  map.with_options :controller => 'sessions' do |session|
    session.new_session    'session/new', :action => 'new',     :conditions => { :method => :get }
    session.default    '/', :action => 'new',     :conditions => { :method => :get }
    session.session        'session',     :action => 'create',  :conditions => { :method => :post }
    session.connect        'session',     :action => 'destroy', :conditions => { :method => :delete }
    session.update_selected    'session/update/:sport', :action => 'update_selected_sport',     :conditions => { :method => :get }
  end

  map.resources :seasons

  map.resources :newzs

  map.resources :team_players

  map.resources :match_parts

  map.resources :messages

  map.resources :matches

  map.resources :teams

  map.resources :rounds

  map.resources :leagues

  map.resources :users, :except => :new

  map.resources :sports

  map.with_options :controller => 'tournaments' do |tournaments|
    tournaments.show_public '/:name',  :action => 'show_with_name'
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
