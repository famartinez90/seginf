# encoding: UTF-8
# This proxy module will redirect all images to an image of our choice.

class ImageReplacer < BetterCap::Proxy::HTTP::Module
  meta(
    'Name'        => 'Pwnd',
    'Description' => 'This proxy module will redirect the target(s) images requests to an image of our choice.',
    'Version'     => '1.0.0',
    'Author'      => "Federico Martinez",
    'License'     => 'GPL3'
  )

  # Choosen image URL
  @@url = 'http://www.catster.com/wp-content/uploads/2017/08/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg'

  def on_request( request, response )
    if response.content_type =~ /^image\/.*/ and !@@url.include?(request.host)
      BetterCap::Logger.info "[#{'REDIRECT'.green}] The requested image #{request.to_url} has been replaced! ..."
      response.redirect!(@@url)
    end
  end
end