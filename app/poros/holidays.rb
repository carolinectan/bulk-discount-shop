class Holidays
  attr_reader :name1, :date1, :name2, :date2, :name3, :date3

  def initialize(repo)
    @name1 = repo[0][:name]
    @date1 = repo[0][:date]

    @name2 = repo[1][:name]
    @date2 = repo[1][:date]

    @name3 = repo[2][:name]
    @date3 = repo[2][:date]
  end
end
