require 'csv'
require 'date'

data = CSV.read("file.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
arr_of_hashed_data = data.map { |d| d.to_hash }

puts("\n----- emplyoee details------- \n #{arr_of_hashed_data.class}")
i=0
puts("code\tname\tage\tdepartment\t\texperience\tjoin_date\n")
arr_of_hashed_data.each_with_index do |element, index|
  emp_hash = element
  emp_hash.keys.each do |key|
     print "#{emp_hash[key]}\t\t"
  end
  puts("\n")
end
puts("\n-----Max age emplyoee details-------\n")
flag=0
max_age=0
arr_of_hashed_data.each_with_index do |element, index|
  emp_hash = element
  if emp_hash[:age]>max_age
    flag=index
  end
end
 arr_of_hashed_data[flag].keys.each do |key|
   print "#{arr_of_hashed_data[flag][key]}\t\t"

 end

puts("\n\n----- emplyoee details with experience------\n")
arr_of_hashed_data.each_with_index do |element, index|
  emp_hash = element
  emp_hash.keys.each do |key|
    print "#{emp_hash[key]}\t\t"
  end
  exp=emp_hash[:experience]
  case exp
    when (0..5)
      print("fresher\t")
    when (6..23)
      print("beginner\t")
    when (24..48)
      print("implementer\t")
    when (47..100)
      print("expert\t")
  end
  puts("\n")
end


puts("\n----- emplyoee details according to department ------\n")
grp_data=arr_of_hashed_data.group_by{|h| h[:department]}.values
puts("code\tname\tage\tdepartment\t\texperience\tjoin_date\n")
grp_data.each_with_index do |element, index|
  emp_hash = element
  emp_hash.each do |element|
    element.keys.each do |key|
      print "#{element[key]}\t\t"
    end
    puts "\n"
  end

end


puts("\n----- emplyoee details who have joined in last 6 month ------")
#puts(Time.now-6.month)
now = Date.today
 now=now-180
temp=arr_of_hashed_data.select{ |data1| Date.parse(data1[:join_date]) > now}
temp.each_with_index do |element, index|
  emp_hash = element
  emp_hash.keys.each do |key|
    print "#{emp_hash[key]}\t\t"
  end
  puts("\n")
end










