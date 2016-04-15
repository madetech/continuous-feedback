class BadOnes
  def initialize
    @file_contents = File.open('README.md')
  end

  def blame!
    offenders = employees.select { |employee| late_for_review?(employee) }

    break_build_with!(offenders) unless offenders.empty?
  end

  private

  def break_build_with!(offenders)
    puts offenders
    abort('Some people have not had a 1-2-1 recently...')
  end

  def late_for_review?(employee)
    should_have_had_session_by > last_session_date(employee).to_i
  end

  def last_session_date(employee)
    Time.new(*last_session(employee))
  end

  def should_have_had_session_by
    Time.now.to_i - (60 * 60 * 24 * 14)
  end

  def last_session(employee)
    matches(employee)[2].split('/').map(&:to_i).reverse
  end

  def matches(employee)
    /\| (\w+)\s+\| ([0-9]{2}\/[0-9]{2}\/[0-9]{4})   \|/.match(employee)
  end

  def employees
    @file_contents.grep(/[0-9]{2}   \| /)
  end
end

BadOnes.new.blame!
