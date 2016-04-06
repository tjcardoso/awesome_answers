class WelcomeController < ApplicationController
  # this defines an 'action' called index for the 'welcomecontroller'
  def index
    # render text: "Hello World"

    #by default (convention) Rails will render:
    # views/welcome/index.html.erb (when receiving a requests that has an HTML format)

    # if you use another format by going to url such as '/home.txt'
    # rails will render a template accordot thath format so in the case of
    # '/home.text' it will be:
    #  views/welcome.index.text.erb

  end

  def aboot
    
  end

end
