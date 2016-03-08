#!/usr/bin/env ruby

require 'open-uri'
require 'rss'

if not ARGV[0]
  puts 'specify user name'
  exit
end

open("http://b.hatena.ne.jp/#{ARGV[0]}/rss", 'User-Agent' => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)') do |rss|
  items = RSS::Parser.parse(rss).items.shuffle.each do |item|
    next unless item.dc_subjects.any? { |s| /あとで読む/ === s.content }
    break [item.title, item.link, item.dc_subjects.map { |s| s.content }.join(', '), item.description].reject(&:empty?).each { |msg| puts msg}
  end
end
