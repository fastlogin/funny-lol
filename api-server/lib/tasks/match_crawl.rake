
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
