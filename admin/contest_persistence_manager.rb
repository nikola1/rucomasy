class ContestPersistanceManager
  attr_reader :contest

  def initialize(contest)
    @contest = contest
  end

  def save
    if @contest.save
      puts "Contest saved successfuly."
      print
    else
      puts "Contest not saved."
    end
  end

  def delete
    ContestPersistanceManager.delete @contest.id
  end

  def print
    ContestPersistanceManager.print @contest
  end

  def self.fetch(id)
    if (contest = Contest.get id)
      new contest
    else
      nil
    end
  end

  def self.create(attributes)
    new Contest.new(attributes)
  end

  def self.add(attributes)
    create(attributes).save
  end

  def self.select(attributes)
    Contest.all(attributes).map { |contest| new contest }
  end

  def self.delete(id)
    if Contest.get(id).destroy
      puts "Contest was successfully deleted!"
    else
      puts "The contest was not deleted."
    end
  end

  def self.delete_matching(all = false, attributes)
    contests = select attributes

    if contests.count == 0
      puts "Such a contest doesn't exist."
    elsif contests.count == 1
      contests.first.delete
    else
      if all
        contests.each &:delete
      else
        contests.each &:print
        puts "Pick one? (by contest id)"
        delete STDIN.readline.to_i
      end
    end
  end

  def self.edit(attributes)
    contest = fetch attributes[:id]

    if contest
      attributes.each { |k, v| contest.attribute_set k, v }
      if contest.save
        puts "Contest saved successfully."
        print contest
      else
        puts "Contest not saved."
      end
    else
      puts "Such a contest doesn't exist."
    end
  end

  def self.print(contest)
    puts "Name: #{contest.name}".ljust(40) + "Start date: #{contest.start_date}"
    puts "Contest id: #{contest.id}".ljust(40) + "End date:   #{contest.end_date}"
    unless contest.description.nil?
      puts "-" * CHARS_PER_LINE
      puts "Description:"
      puts contest.description.chars.each_slice(CHARS_PER_LINE).map { |x| x.join.lstrip }.join "\n"
    end
    puts "=" * CHARS_PER_LINE
  end

  def method_missing(name, *arg, &block)
    @contest.send name, *arg, &block
  end
end
