module DjsHelper
  #URI.parse
  #if URI is blank return nil
  #else return normalize! uri
  def normalize_uri(uri)
    return unless uri
    if uri !~ /^http/
      "http://#{uri}"
    else
      uri
    end
  end
end
