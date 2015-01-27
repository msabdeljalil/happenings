# just using this for ideas
RiCal.Calendar do
  event do
    description "MA-6 First US Manned Spaceflight"
    dtstart     DateTime.parse("2/20/1962 14:47:39")
    dtend       DateTime.parse("2/20/1962 19:43:02")
    location    "Cape Canaveral"
    add_attendee "john.glenn@nasa.gov"
    alarm do
      description "Segment 51"
    end
  end
end