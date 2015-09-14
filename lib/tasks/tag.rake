if Rails.env.development? || Rails.env.production?
namespace :tag do

  desc "update articles_count"

  task update_articles_count: :environment do 
    result = Benchmark.realtime do
      Tag.update_articles_count()
    end
    puts "tag:update_articles_count: #{result}s"
  end

end
end