require 'haml'

module ApplicationHelper
  def cta_link_to(text, url)
    html = "<span class='cta-button'>
              <span>
                <a href='#{ url }'>#{ text }</a>
              </span>
            </span>"
  end

end
