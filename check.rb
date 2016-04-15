require 'date'

class NaughtyList
  def initialize(file, days)
    @file = file
    @days = days

    report(naughty_people)
  end

  private

  def report(naughty_people)
    if naughty_people.count > 0
      puts 'Some people have not had a 1-2-1 recently...'
      puts naughty_people
      exit 1
    end
  end

  def naughty_people
    people.keep_if { |person| naughty?(*person) }
  end

  def people
    File.open(@file).map { |line| name_and_last_date(line) }.compact
  end

  def naughty?(name, last_date)
    last_date + @days < Date.today
  end

  def name_and_last_date(line)
    name, last_date = line.split('|').map(&:strip).delete_if(&:empty?).compact
    [name, Date.strptime(last_date, '%d/%m/%Y')]
  rescue
  end
end

NaughtyList.new('README.md', 14)
