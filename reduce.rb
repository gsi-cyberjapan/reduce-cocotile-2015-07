#!/usr/bin/env ruby
#hadoop jar /usr/local/Cellar/hadoop/2.6.0/libexec/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar -input input -output output -mapper cat -reducer reduce.rb
require 'fileutils'

last = nil
payload = nil

def write(payload, path)
  path = "cocotile/#{path}.csv"
  dir = File.dirname(path)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  File.open(path, 'w') {|w|
    w.print payload.join(','), "\n"
  }
end

while gets
  r = $_.strip.split("\t")
  current = r[0]
  if current != last
    write(payload, last) unless last.nil?
    payload = []
  end
  payload << r[1]
  last = current
end
write(payload, last)
