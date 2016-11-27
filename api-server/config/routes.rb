Rails.application.routes.draw do

  get 'simple_match_viewer/matches/:ids' => 'simple_match_viewer#get_matches'

end
