# encoding: UTF-8

# This proxy module will redirect all images to a cat image.
class RedirectToCat < BetterCap::Proxy::HTTP::Module
  meta(
    'Name'        => 'RedirectToCat',
    'Description' => 'This proxy module will redirect the target(s) images requests to a cat image.',
    'Version'     => '1.0.0',
    'Author'      => "Federico Martinez",
    'License'     => 'GPL3'
  )

  # Cat image URL
  @@url = 'http://www.catster.com/wp-content/uploads/2017/08/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg'

  def on_request( request, response )
    if response.content_type =~ /^image\/.*/ and !@@url.include?(request.host)
      BetterCap::Logger.info "[#{'REDIRECT'.green}] Redirecting #{request.to_url} to cat ..."
      response.redirect!(@@url)
    end
  end
end
