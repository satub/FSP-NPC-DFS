require 'net/http'

module AI

class HeroBot

def initialize
end

def talk(input)
  uri = URI("http://www.pandorabots.com/pandora/talk-xml")
  params = {:'botid' => '9826fae0be37785e', :'input' => input}
  response = Net::HTTP.post_form(uri, params)
  /<that>(.*?)<\/that>/.match(response.body)[1]
end

end

end
