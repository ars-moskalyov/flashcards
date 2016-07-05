require 'open-uri'
require 'nokogiri'

url = 'http://russian.languagedaily.com/wordsandphrases/russian-cognates'
html = open(url)

page = Nokogiri::HTML(html)
words = page.css('.jsn-article-content')
words = words.css('li').map { |tag| tag.text }

pair_words = words.map do |item|
  item.split('---').map(&:strip)
end

hh = Hash[*pair_words.flatten]


hh.each do |k, v|
  Card.create!(original_text: v,
               translated_text: k)
end
