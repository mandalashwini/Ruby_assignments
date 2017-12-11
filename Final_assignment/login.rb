require 'csv'
require_relative 'login_menu'
module Login

  def self.login
      puts "Enter emailid"
      @emailid=gets.chomp
      puts "Enter password"
      @pass=gets.chomp
      if(Login.check_login)
        puts "successfully login"
        Loginmenu.loginfun

      else
        puts "try again.."
      end

  end
    def self.check_login
      all_records = CSV.read('/home/ashwini/MY_TRAINING/Ruby/Banking System/register_data.csv', :headers=>true)
      arr_of_hashed_data = all_records.map { |d| d.to_hash }

      temp=arr_of_hashed_data.find {|i| i["emailid"] == @emailid and i["password"] == @pass}
      #hash_data=arr_of_hashed_data.select{|key, hash| key["emailid"] == @emailid  and key["name"] == @name }

      if temp
        return true
      else
        return false
      end

    end

end
#Login.login
