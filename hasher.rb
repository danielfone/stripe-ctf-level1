#!/usr/bin/env ruby

require 'digest/sha1'

def debug(message)
  STDERR.puts message
end

STDERR.sync = true

counter = 0
tree = ARGV[0]
parent = ARGV[1]
difficulty = ARGV[2]
timestamp = `date +%s`.strip
content = ''

sha1 = 'z'

  body = <<-COMMIT.strip
tree #{tree}
parent #{parent}
author CTF user <me@example.com> #{timestamp} +0000
committer CTF user <me@example.com> #{timestamp} +0000

Give me a Gitcoin
COMMIT

debug 'Mining...'

while sha1 >= difficulty do
  counter += 1
  content = body + counter.to_s + "\n"
  header = "commit #{content.length}\0"
  store = header + content
  sha1 = Digest::SHA1.hexdigest(store).to_s
end

debug "SHA1 found:    #{sha1}"

puts content
