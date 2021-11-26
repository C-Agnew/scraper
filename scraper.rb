require 'open-uri'
require 'net/http'
require 'nokogiri'
url = "https://coinmarketcap.com/"
uri = URI.parse(url)
response = Net::HTTP.get_response(uri)

html_response = Nokogiri::HTML(response.body)
headers = []
html_response.css("table").css("thead").css("tr").css("th").size.times do |element|
  headers[element] = html_response.css("table").css("thead").css("tr").css("th")[element].text
end

coins = []

html_response.css("table").css("tbody").css("tr").size.times do |element|
  coins[element] = html_response.css("table").css("tbody").css("tr")[element]
end



file = File.open("cryptoTest.txt", "w")

printf "%-25s %-15s \n", headers[2], headers[3]


coin_map = Hash.new


15.times do |coin|
  printf "%-25s %-15s \n", coins[coin].css("td")[2].text.chomp("Buy"),coins[coin].css("td")[3].text
end


puts coin_map

15.times do |coin|
    coin_map[coins[coin].css("td")[2].text.chomp("Buy")] = coins[coin].css("td")[3].text
end


# puts coin_map.inspect