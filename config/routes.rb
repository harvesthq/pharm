ActionController::Routing::Routes.draw do |map|
  map.resources :photos, :collection => {:home => :get}

  map.resources :photos,
                :collection  => {:home => :get},
                :path_prefix => '/admin',
                :name_prefix => 'admin_',
                :controller  => 'admin_photos'
  
  map.admin 'admin', :controller => 'admin_photos'
  map.settings 'admin/settings', :controller => 'admin_users', :action => 'edit'

  map.resource :user,
               :path_prefx  => '/admin', 
               :name_prefix => 'admin_', 
               :controller  => 'admin_users'
  
  map.root :controller => "photos", :action => "home"
end
