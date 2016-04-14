bad_ones = []

File.open('README.md').grep(/[0-9]{2}   \| /).each do |line|
  matches = /\| (\w+)\s+\| ([0-9]{2}\/[0-9]{2}\/[0-9]{4})   \|/.match(line)
  last_session = matches[2].split('/').map(&:to_i).reverse
  last_session_date = Time.new(*last_session)
  deadline = Time.now.to_i - (60 * 60 * 24 * 14)
  if deadline > last_session_date.to_i
    bad_ones << line
  end
end

if bad_ones.size > 0
  puts bad_ones
  abort('Some people have not had a 1-2-1 recently...')
end
