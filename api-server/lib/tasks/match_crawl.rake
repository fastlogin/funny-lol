
##
# Match Crawl Task
#
# @author: George Ding (gd264@cornell.edu)
# @description: Main crawling task that crawls through Riot API, finds matches, saves them to
# database and also updates all statistics for champion item metrics and champion summoner spell
# metrics.
##
namespace :match_crawl do
	desc "Testing saving via crontab"
	task :test_save_match => :environment do
		Match.create({
			player1: 'The current time is:',
			player2: Time.now.inspect,
			matchWon: true
			})
	end
end
