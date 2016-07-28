require 'open-uri'
require 'nokogiri'

user = User.create!(email: 'test@test',
                    password: '12345',
                    password_confirmation: '12345',
                    locale: 'en',
                    subscribe: true,
                    name: 'zaza')
puts "created user \nlogin: test@test \npassword: 12345"

user.decks.create!(title: 'test deck', description: 'lorem ipsum')
puts 'deck created'

url = 'http://russian.languagedaily.com/wordsandphrases/russian-cognates'
html = open(url)

page = Nokogiri::HTML(html)
words = page.css('.jsn-article-content')
words = words.css('li').map { |tag| tag.text }

pair_words = words.map do |item|
  item.split('---').map(&:strip)
end

hh = Hash[*pair_words.flatten]


hh.each.with_index(1) do |(k, v), i|
  Card.create!(original_text: v, translated_text: k, deck_id: user.decks.first.id)
  print "\rCreated #{i} cards"
end
puts