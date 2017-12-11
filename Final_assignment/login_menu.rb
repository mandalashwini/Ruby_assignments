require 'csv'
module Loginmenu
  def self.loginfun
    loop do
    puts "\nMenu:-\n 1.Credit Amount\n 2.Withdraw Amount\n 3.Account Details\n 4.Money Transfer\n 5.Exit"
    menu_choice=gets.to_i
    data = CSV.read("register_data.csv", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
    arr_of_hashed_data = data.map { |d| d.to_hash }
    case menu_choice
      when 1
        puts "Enter your Account number"
        accountnumber=gets.to_i
        Loginmenu.credit(arr_of_hashed_data,accountnumber)
      when 2
        puts "Enter your Account number"
        accountnumber=gets.to_i
        Loginmenu.withdraw(arr_of_hashed_data,accountnumber)
      when 3
        puts "Enter your Account number"
        accountnumber=gets.to_i
        Loginmenu.accountdetails(arr_of_hashed_data,accountnumber)
      when 4
        puts "Enter your Account number"
        accountnumber=gets.to_i
        Loginmenu.transfer(arr_of_hashed_data,accountnumber)
      when 5
         return
      else
        puts "Wrong choice...try again!!!"
    end
    puts "Do u want to continue..(yes/no)"
    ch=gets.chomp
    if(ch=='no')
      return
    end
    end
  end

    def self.credit(arr_of_hashed_data,accountnumber)
      arr_of_hashed_data.each_with_index do |element, index|
        cust_hash = element
        if cust_hash[:accountnumber]==accountnumber

          puts "Enter amount to credit"
          amount=gets.to_i
          cust_hash[:balance]=amount+cust_hash[:balance]
          arr_of_hashed_data[index]= cust_hash
        end
      end
      Loginmenu.setdata(arr_of_hashed_data)
      puts("amount credited....\n")
    end

    def self.withdraw(arr_of_hashed_data,accountnumber)
      arr_of_hashed_data.each_with_index do |element, index|
        cust_hash = element
        if cust_hash[:accountnumber]==accountnumber.to_i
          puts "Enter amount to withdraw"
          amount=gets.to_i
          if  cust_hash[:balance] >=  amount
          cust_hash[:balance]=cust_hash[:balance]-amount
          arr_of_hashed_data[index]= cust_hash
          else
            puts "Low balance"
            end
        end
      end
      Loginmenu.setdata(arr_of_hashed_data)
      puts("amount withdraw....\n")
    end


  def self.setdata(arr_of_hashed_data)

    @file=File.open("register_data.csv","w+")
    @file.write("accountnumber,name,emailid,password,balance\n")
    arr_of_hashed_data.each_with_index do |element, index|
      array_cust=element.values
      str=array_cust.join(",")
      @file.write(str)
      @file.write("\n")
    end
    @file.close
  end

  def self.accountdetails(arr_of_hashed_data,accountnumber)
  arr_of_hashed_data.each_with_index do |element, index|

    cust_hash = element
    if cust_hash[:accountnumber]==accountnumber.to_i
      print ("------Account Details-----\nAccount_number\t \tBalance\n")
      print (cust_hash[:accountnumber])
      print ("\t")
      print (cust_hash[:balance])
    end
  end
  end

 def self.transfer(arr_of_hashed_data,accountnumber)
   arr_of_hashed_data1=arr_of_hashed_data
   arr_of_hashed_data.each_with_index do |element, index|
     cust_hash = element
     if cust_hash[:accountnumber]==accountnumber.to_i
       puts "Enter amount to transfer"
       amount=gets.to_i
       if  cust_hash[:balance] >=  amount
         cust_hash[:balance]=cust_hash[:balance]-amount
         arr_of_hashed_data[index]= cust_hash
         puts "Enter Account number to transfer money"
         trns_accountnumber=gets.to_i
         if ( Loginmenu.sender(arr_of_hashed_data,trns_accountnumber,amount)== true )
           puts "Money successfully transfer"
         else
           puts "transfer account number not found"
           cust_hash[:balance]=cust_hash[:balance]+amount
         end

       else
         puts "Low balance"
       end
     end
   end
   Loginmenu.setdata(arr_of_hashed_data)
   end

  def self.sender(arr_of_hashed_data,trns_accountnumber,amount)
    arr_of_hashed_data.each_with_index do |element, index|
      cust_hash1 = element
      if cust_hash1[:accountnumber]==trns_accountnumber

        cust_hash1[:balance]=cust_hash1[:balance]+amount
        arr_of_hashed_data[index]= cust_hash1
        return true

      end
    end
  end


end
#Loginmenu.loginfun

