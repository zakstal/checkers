module GameExtras

  def clear_screen
     puts "\e[H\e[2J"
   end

   def get_chr
       begin
         system("stty raw -echo")
         str = STDIN.getc
       ensure
         system("stty -raw echo")
       end
     end

end