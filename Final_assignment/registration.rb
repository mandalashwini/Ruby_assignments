require 'csv'

module Registration
       Array_hash_data=Array.new
       @balance=0
      def self.get_info
           @acccount_no=Registration.findaccount
           @acccount_no=@acccount_no+1
           file=File.open("register_data.csv","a+")
           loop do
              puts "Enter Name"
              @name=gets.chomp
              if (@name.class==String && @name.length<10)
                     break;
              else
                  puts ("Name length exceed")
              end
          end

          loop do
            puts "Enter Mobile Number"
            @mbnumber=gets.chomp
            if (@mbnumber.to_i.class==Integer && @mbnumber.length==10)
                  break;
            else
                puts ("Enter Correct Mobile Number")
            end
          end


        loop do
            puts("Enter email.id")
            @emailid=gets.chomp
            @valid_email_expression=/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
            if ( @emailid=~ @valid_email_expression )
                break
            else
               puts "invalid email id"
            end
        end


      loop do
          puts("Enter password")
          @password=gets.chomp
          @valid_password_expression=/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/
          if ( @password=~ @valid_password_expression )
                break
          else
              puts "invalid password"
          end
      end

      loop do
          puts("Enter confirm password")
          @confirm_password=gets.chomp
          if ( @confirm_password== @password )
              break
          else
            puts "confirm password not match"
          end
      end
      str="\n#{@acccount_no},#{@name},#{@emailid},#{@password},#{@balance}"
      if (Registration.check_available)
        puts "already registered..."
      else
        file.write(str)
        file.close
        puts "successfully registered..."
      end
  end

  def self.check_available
    all_records = CSV.read('/home/ashwini/MY_TRAINING/Ruby/Banking System/register_data.csv', :headers=>true)
    arr_of_hashed_data = all_records.map { |d| d.to_hash }
    temp=arr_of_hashed_data.find {|i| i["emailid"] == @emailid and i["name"] == @name}
    if temp
        return true
    else
        return false
    end

  end

       def self.findaccount
         max_accountnumber=0
         data = CSV.read("register_data.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
         arr_of_hashed_data = data.map { |d| d.to_hash }
         arr_of_hashed_data.each_with_index do |element, index|
           cust_hash = element
           if cust_hash[:accountnumber].to_i > max_accountnumber.to_i
             max_accountnumber=cust_hash[:accountnumber]
           end
         end
         return max_accountnumber
       end


end



#Registration.get_info
