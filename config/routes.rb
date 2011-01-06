ActionController::Routing::Routes.draw do |map|
  map.resources :tournaments

  map.resources :tournaments

  map.resources :courts



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


  map.with_options :controller => 'services' do |services|
    services.services      '/services',  :action => 'index', :conditions => { :method => :get }
  end

  map.with_options :controller => 'newzs' do |newzs|
    newzs.default   '/',            :action => 'index', :conditions => { :method => :get }
    newzs.news      'news/:sport',  :action => 'index', :conditions => { :method => :get }
    newzs.rules     'rules/:sport', :action => 'rules', :conditions => { :method => :get }
  end

  map.with_options :controller => 'scores' do |scores|
    scores.scores  'scores/:sport', :action => 'index', :conditions => { :method => :get }
  end

  map.with_options :controller => 'users' do |users|
    users.users_    'users_/:sport', :action => 'index', :conditions => { :method => :get }
    users.join_sport    'join_sport', :action => 'join', :conditions => { :method => :get }
  end

  map.with_options :controller => 'matches' do |matches|
    matches.join_free_match    'join_free_match/:match_id', :action => 'join', :conditions => { :method => :get }
  end

  map.with_options :controller => 'leagues' do |leagues|
    leagues.leagues_             'leagues_/:sport',            :action => 'index',               :conditions => { :method => :get }
    leagues.edit_league_teams    'leagues_/:league_id/edit',   :action => 'edit_league_teams',   :conditions => { :method => :get }
    leagues.league_team_remove   'league_team/:team_id',       :action => 'remove_league_team',  :conditions => { :method => :delete }
    leagues.league_team_add 'league_team_add/:league_id/:team_id', :action => 'league_team_add', :conditions => { :method => :put }
  end

  map.with_options :controller => 'teams' do |teams|
    teams.teams_    'teams_/:sport', :action => 'index', :conditions => { :method => :get }
    
  end

  map.with_options :controller => 'matches' do |matches|
    matches.matches_    'matches_/:sport', :action => 'index', :conditions => { :method => :get }
  end

  map.with_options :controller => 'sessions' do |session|
    session.new_session    'session/new', :action => 'new',     :conditions => { :method => :get }
    session.session        'session',     :action => 'create',  :conditions => { :method => :post }
    session.connect        'session',     :action => 'destroy', :conditions => { :method => :delete }
    session.update_selected    'session/update/:sport', :action => 'update_selected_sport',     :conditions => { :method => :get }
  end

  map.resources :seasons

  map.resources :newzs

  map.resources :team_players

  map.resources :match_parts

  map.resources :matches

  map.resources :teams

  map.resources :rounds

  map.resources :leagues

  map.resources :users

  map.resources :sports


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
