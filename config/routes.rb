Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

	root 'registration#new'
	
	resources :cats, only: [:index, :show, :edit, :update]

	get  "/register", to: "registration#new"
	post "/register", to: "registration#create"
	post   "/login",  to: "catlogin#create"
	delete "/logout", to: "catlogin#destroy"
end
