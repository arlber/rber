# To use with thin 
#  thin start -p PORT -R config.ru

require './rber.rb'

set :environment, :production
run Rber
