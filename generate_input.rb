# Assumptions / requirements
# - /Users/hfu/htdocs/ is the downloaded/mapped DocumentRoot for gsimaps.
# - ./layers_txt/ contains layers-dot-text formatted matadata in staging state.
require 'json'
require 'zlib'

DIRS = %w{/Users/hfu/htdocs/layers_txt ./layers_txt}
$tes = []

def process(entry, stack)
  case entry['type']
  when 'LayerGroup'
    stack.push(entry['title'])
    entry['entries'].each {|child|
      process(child, stack)
    }
    stack.pop
  when 'Layer'
    stack.push(entry['title'])
    r = entry['url'].split('/{z}/{x}/{y}.')
    if r.size == 2
      $tes << [r[0].split('/xyz/')[-1], r[1]]
    end
    stack.pop
  end
end

DIRS.map{|dir| Dir.glob("#{dir}/*.txt").sort}.flatten.each {|path|
  JSON.parse(open(path).read)['layers'].each {|entry|
    process(entry, [])
  }
}

$tes.uniq!

$tes.each {|te|
  next if te[0] == 'cocotile'
  path = "/Users/hfu/htdocs/xyz/#{te[0]}/mokuroku.csv.gz"
  Zlib::GzipReader.open(path).each {|l|
    print [l.split('.')[0], te[0]].join("\t"), "\n"
  }
}
