#!/usr/bin/env ruby

#Define Default Constants
PATH = '~/Music'


#Define Handler Methods
def list(path=PATH)
  puts "----- 💿  List of Music : #{path} -----"
  songs = songs_at_path(PATH)
  songs.each_with_index do |song_path, index|
    puts "#{index} : #{File.basename(song_path)}"
  end
  puts "-----------------------------------"
end

def play(id)
  songs = songs_at_path(PATH)
  path = songs[id]
  puts "----- 🎵  Now Playing : #{File.basename(path)} -----"
  system('say', "Now Playing #{File.basename(path)}")
  system('afplay', path)
end

def stop
  `killall afplay`
end


#Helper Methods
def songs_at_path(path, format='mp3')
  absolute_path = `echo #{path}`.strip
  songs = Dir[absolute_path+"/*.#{format}"]
  songs
end


#Command Line Inputs Handler
command = ARGV.shift

case command
when 'list', 'ls'
  list
when 'play', 'pl'
  id = ARGV.shift.to_i
  play(id)
when 'stop', 'st'
  stop
end
