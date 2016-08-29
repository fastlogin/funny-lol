
namespace :match_crawl do



	desc "Testing, testing."
	task :test_one => :environment do
		puts getSomeMore(3)
	end
end

	def getSomeMore(value)
		value + 5
	end