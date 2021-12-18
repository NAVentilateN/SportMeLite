require 'nokogiri'
require 'open-uri'

namespace :locations do
  desc "TODO"
  task import: :environment do
    doc = Nokogiri::XML(File.open("#{Rails.root}/lib/tasks/1.DUS_School_Sports_Facilities.kml")) # it works
    # doc = Nokogiri::XML(File.open("2.PLAYSG.kml")) # it works
    # doc = Nokogiri::XML(File.open("3.sportsg-dus-sport-facilities-kml.kml")) # it does not work
    # doc = Nokogiri::XML(File.open("4.sportsg-sport-facilities-kml.kml")) # it does not work
    # doc = Nokogiri::XML(File.open("5.AQUATICSG.kml")) # it works

    location_array = doc.css('Placemark')
    location_array.each do |location|
      coordinate = location.css('Point coordinates').text.split(",") #getting all the cooridinates
      labels = {}
      labels[:name] = location.css('name').text
      labels[:long] = coordinate[0].to_f
      labels[:lat] = coordinate[1].to_f
      description = Nokogiri::XML(location.css('description')[0])

      description.css('td').each {|node|

        if node.text == "ADDRESSPOSTALCODE"
          labels[:postalcode] = node.next_element.text
        elsif node.text == "ADDRESSBUILDINGNAME" || node.text == "ADDRESSSTREETNAME"
          labels[:address] = node.next_element.text
        elsif node.text == "DESCRIPTION"
          labels[:description] = node.next_element.text
        elsif node.text == "Sports"
          labels[:sport] = node.next_element.text
        end
      }
      location = Location.new(labels)
      location.save!
      # p '------------------------------------------------------------'
    end

    puts 'seed all location from 1.DUS_School_Sports_Facilities.kml'

  end

end
