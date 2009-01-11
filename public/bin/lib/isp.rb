require 'net/pop'
require 'net/http'

class Isp

  def initialize(pop_server, username, password)
    @pop_server = pop_server
    @username = username
    @password = password
  end

  def delete_mail
    Net::POP3.start(@pop_server, 110, @username, @password) do |pop|
      pop.each_mail do |mail| 
        mail.delete
      end
    end
  end
  
end
