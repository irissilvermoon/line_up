module DjsHelper
  #URI.parse
  #if URI is blank return nil
  #else return normalize! uri
  def external_url(link)
    if link.blank?
      nil
    else
      uri = URI.parse(link)
      uri.normalize!
    end
  end
end
