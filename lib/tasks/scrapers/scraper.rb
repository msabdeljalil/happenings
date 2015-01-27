require "open-uri"

class EventScraper
  include Helpers
  attr_accessor :event_search_class

  SITE_URL        = "http://www.theatreinchicago.com/"
  QUERY           = "opening/CalendarMonthlyResponse.php?"
  EVENT_CSS_CLASS = "tr td span.detailhead a" 

  def initialize(args = {})
    scrape
  end

  def scrape(scrape_url = nil)
    doc = Nokogiri::HTML(open(scrape_url || SITE_URL))
    process_document(doc) if scrape_url.nil?
    doc
  end

  def process_document(doc)
    event_listings = doc.css(EVENT_CSS_CLASS)
    event_listings.each do |event_link|
      link = event_link.attribute("href").value
      # p link
      process_event(scrape(link), link)
    end
  end

  def process_event(event_data, link)
    theatre_data  = event_data.at_css('#theatreName a')
    venue         = find_or_create_venue(theatre_data, event_data)
    event_name    = event_data.at_css('#titleP').text.squish
    theatre_event = Event.find_or_initialize_by(name: event_name)
    if theatre_event.new_record?
      theatre_event.venue       = venue
      theatre_event.event_url   = link
      theatre_event.description = event_data.at_css('p.detailBody').text.squish
      process_event_details(event_data.css('p.detailBody'), theatre_event)
      theatre_event.save
    end
    if theatre_event.venue.nil?
      theatre_event.venue = venue
      theatre_event.save
    end
    process_event_dates(event_data.css("table.daysTable > tr"), theatre_event)
  end


  def create_venue(args)
    name = args.fetch(:name)
    description = args.fetch(:description)
    addy = args.fetch(:address)
    Venue.find_or_create_by(name:        name,
                            description: description,
                            address:     addy)
  end

  def create_event_date(parsed_date, event)
    EventDate.find_or_create_by(date_time: parsed_date,
                                event:     event,
                                venue:     event.venue)
  end

  protected

  def url(_args = {})
    "#{@url}#{@query}#{query_args.to_param}"
  end

  def query_args
    {}
  end


  def process_event_details(details, theatre_event)
    details.each do |detail|
      detail = detail.text.squish
      unless detail.blank?
        if detail.include?("Price:")
          theatre_event.price        ||= detail.remove("Price:")
        end
        if detail.include?("Show Type:")
          theatre_event.show_type    ||= detail.remove("Show Type:")
        end
        if detail.include?("Box Office:")
          theatre_event.phone_number ||= detail.remove("Box Office:")
        end
        if detail.include?("Running Time:")
          theatre_event.run_time ||= detail.remove("Running Time:")
        end
      end
    end
    theatre_event
  end

  def process_event_dates(event_date_data, theatre_event)
    event_date_data.each do |date_data|
      data = date_data.text.squish
      unless data.blank? || data.nil?
        create_event_dates(data, theatre_event)
      end
    end
  end

  def create_event_dates(data, theatre_event)
    case data
      when /^\w+(,)\s\w+\s+\d+(:)\s\w+(:)\d+\w+/
        date, time = data.split(",")[1].split(":", 2)
        time       = time.split("&")
        time.each do |stime|
          parsed_date = showtime(date, stime)

          create_event_date(parsed_date, theatre_event)
        end
        return true
      when /(:)/
        day, time = data.split(":", 2)

        day  = "#{day.remove(":").downcase.singularize}?".to_sym
        days = parsing_date_month.all_month.reject { |d| !d.send(day) }
        days.each do |date_event|
          parsed_date = showtime(date_event, time)
          create_event_date(parsed_date, theatre_event)
        end
        return true
      else
        false
    end
  end

  def create_event_date(parsed_date, event)
    EventDate.find_or_create_by(date_time: parsed_date,
                                event:     event,
                                venue:     event.venue)
  end

end
