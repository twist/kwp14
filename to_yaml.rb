#!/usr/bin/ruby

require 'yaml'
require 'csv'

a = CSV.read("ziele.csv", :col_sep => ";", :quote_char => "\x00")
topic = {}
tags = {}

count_topic  = 0
count_tag  = 0

current_tag = ""

a.each do |entry|
  id = entry[0]
  text = entry[1]
  if text.nil?  #tag
    current_tag = "tag_#{count_tag}"

    tags[current_tag] = {}
    tags[current_tag]["title"] = id
    count_tag+=1
  else
    current_topic = "topic_#{count_topic}"
    topic[current_topic] = {}
    topic[current_topic]["body"] = text
    topic[current_topic]["tags"] = [current_tag]
    topic[current_topic]["id"] = count_topic
    count_topic += 1
  end


end

pp tags.to_yaml
pp topic.to_yaml

File.open("topics.yml", "w") do |file|
  file.write topic.to_yaml
end

File.open("tags.yml", "w") do |file|
  file.write tags.to_yaml
end

#thema_one:
#  id: 1
#  body: "Es wird ein gesamtstädtisches Wohnungskonzept entwickelt."
#  tags: ["Wohnen" , "Stadtentwicklung" , "Soziales"]
