require 'open-uri'
require 'nokogiri'

namespace :import_to_db do
  task :task => :environment do
    url = 'http://russian.languagedaily.com/wordsandphrases/russian-cognates'
    html = open(url)

    # загружаем станицу в nokogiri
    page = Nokogiri::HTML(html)
    # выдираем нужный фрагмент
    words = page.css('.jsn-article-content')
    # находим по тегу нужные элементы, убираем тэги, получаем массив
    words = words.css('li').map { |tag| tag.text }

    pair_words = words.map do |item|
      item.split('---').map(&:strip)
    end

    hh = Hash[*pair_words.flatten]


    hh.each do |k, v|
      Card.create!(original_text: v,
                   translated_text: k,
                   review_date: Time.now + 3.days)
    end
  end
end
