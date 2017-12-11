
module Menu
  require_relative 'registration'
  require_relative 'login'
  def self.show_menu
     loop do
        puts ("\nMain Menu:-\n1.Login\n2.Registration\n3.exit\nEnter Your Choice.\n")
        menu_choice=gets.to_i
        case menu_choice
           when 1
                 Login.login
          when 2
                Registration.get_info
          when 3
                 exit
          else

      end
    end
end
end

Menu.show_menu