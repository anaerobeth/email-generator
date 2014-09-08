puts 'How many email addresses do you need?'
number_of_emails = gets.chomp.to_i
if number_of_emails > 0
  puts 'Do you want to use a custom email domain name? (Y/N)'
  customize = gets.chomp.upcase
  if customize == 'Y'
    puts 'Please enter your desired email domain name'
    custom_domain = gets.chomp.downcase
  elsif customize == 'N'
    custom_domain = ''
  else
    puts 'Invalid input. Please start over'
    exit
  end
else
  puts 'Invalid input. Please start over'
  exit
end

if custom_domain == ''
  reps = (number_of_emails/186000).floor + 1
else
  reps = (number_of_emails/370).floor + 1
end


time_start = Time.new
stamp = time_start.strftime('%j%M%S')

email_count = 0
filename = "emails#{stamp}.txt"
File.open(filename,'a') do |f|
  File.open('companies.txt', 'r').each_line do |company|
    if custom_domain == ''
      domain = "#{company.chomp}.com"
    else
      domain = custom_domain
    end
    File.open('names.txt', 'r').each_line do |name|
      (1..reps).each do |num|
        if email_count < number_of_emails
          f.write "#{name.chomp}#{num.to_s}@#{domain}"
          f.write "\n"
          email_count += 1
        else
          puts '-------------------------------------------------------------------'
          puts "#{email_count} emails generated and saved in file #{filename}. Bye."
          time_end = Time.now
          elapsed_time = time_end - time_start
          puts "Your request took: #{elapsed_time} seconds"
          puts '-------------------------------------------------------------------'
          exit
        end
      end
    end
  end
end

