ActionController::Routing::Routes.draw do |map|
  map.resources :metadata

  map.resources :text_blocks, :collection => {:embedded_pager => :get}
  map.text_block_tag "text_blocks/tag/:tag", :controller => :text_blocks, :action => :index

  map.resources :item_annotations

  map.resources :item_questions

  map.resources :item_collages

  map.resources :item_cases

  map.resources :item_playlists

  map.resources :item_rotisserie_discussions

  map.resources :item_question_instances

  map.resources :influences

  map.resources :item_texts

  map.resources :item_text_blocks

  map.resources :item_images

  map.resources :item_youtubes

  map.resources :annotations, :collection => {:embedded_pager => :get}

  map.resources :case_jurisdictions

  map.resources :case_docket_numbers

  map.resources :case_citations

  map.resources :cases, :collection => {:embedded_pager => :get}, :member => {:metadata => :get}
  map.case_tag "cases/tag/:tag", :controller => :cases, :action => :index

  map.resources :collages, :collection => {:embedded_pager => :get},
    :member => {:spawn_copy => :post, :save_readable_state => :post,
	            :record_collage_print_state => :post, :access_level => :get}
  map.export_collage "collages/:id/export", :controller => :collages, :action => :export
  map.export_collage_record "collages/:id/export/:state_id", :controller => :collages, :action => :export
  map.collage_tag "collages/tag/:tag", :controller => :collages, :action => :index

  map.resources :playlists, :collection => {:block => :get, :url_check => :post, :load_form => :post, :embedded_pager => :get},
    :member => {:spawn_copy => :post, :position_update => :post,
	  :delete => :get, :copy => [:get, :post], :metadata => :get,
	  :export => :get, :access_level => :get, :check_export => :get}
  map.playlist_tag "playlists/tag/:tag", :controller => :playlists, :action => :index
  map.notes_tag "playlists/:id/notes/:type", :controller => :playlists, :action => :notes

  map.resources :playlist_items, :collection => {:block => :get}, :member => {:delete => :get }

  map.resources :item_defaults

#  map.connect 'casebooks/annotation', :controller => 'casebooks', :action => :annotation, :method => :get
  
  map.resources :rotisserie_trackers

  map.resources :rotisserie_assignments

  map.resources :rotisserie_posts, :collection => {:block => :get}, :member => {:delete => :get }

  map.resources :rotisserie_discussions, :collection => {:block => :get}, :member => {
    :delete => :get, :add_member => :get, :activate => :post, :notify => :post, :changestart => :post, :metadata => :get}

  map.resources :rotisserie_instances, 
    :collection => {:block => :get, :display_validation => [:get, :post], :validate_email_csv => [:post]},
    :member => {:delete => :get, :invite => [:get, :post], :add_member => :get}


  map.resources :questions, :collection => {:embedded_pager => :get} do |q|
    q.vote_for 'vote_for', :controller => 'questions', :action => :vote_for, :method => :get
    q.vote_against 'vote_against', :controller => 'questions', :action => :vote_against, :method => :get
    q.replies 'replies', :controller => 'questions', :action => :replies, :method => :get
  end

  map.resources :question_instances, :member => {:metadata => :get}, :collection => {:embedded_pager => :get}

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

  map.resources :users, :collection => {:create_anon => :post}
  map.resource :user_session, :collection => {:crossroad => [:get,:post]}
  map.log_out "/log_out", :controller => :user_sessions, :action => :destroy
  map.anonymous_user "/create_anon", :controller => :users, :action => :create_anon
  map.bookmark_item "/bookmark_item/:type/:id", :controller => :users, :action => :bookmark_item

  map.search_all "/all_materials", :controller => :base, :action => :search
  map.root :controller => "base"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
