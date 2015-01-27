namespace :events do

  desc "Fill database with theatre events"
  task fetch: :environment do
    require 'nokogiri'
    require 'open-uri'
    require_relative 'scrapers/theatre_scraper'
    TheatreScraper.new
  end

  desc "Delete Events that are older than 30 days"
  task prune: :environment do
    Event.destroy_all(['created_at < ?', 30.days.ago])
  end

  desc "Delete all Events."
  task clean: :environment do
    Event.destroy_all()
  end

end
