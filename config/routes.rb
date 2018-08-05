Rails.application.routes.draw do
	namespace :api, defaults: {format: 'json'} do
		namespace :v1 do
  		resources :physical_people
  		resources :legal_people
  	end
  end
end