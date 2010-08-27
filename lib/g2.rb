require 'sinatra/base'
require 'haml'

require 'singleton'
class G2
  include Singleton

  def initialize
    @objs = []
  end
  attr_reader :objs

  def inspect(obj)
    @objs << obj
  end
end

def g2(obj)
  G2.instance.inspect obj
end

class G2::UI < Sinatra::Base
  get '/stylesheet.css' do
    content_type 'text/css', :charset => 'utf-8'
    html %<
.object{ border: 1px; }
    >
  end

  get '/' do
    haml %{

- G2.instance.objs.each do |obj|
  %table.object
    %tr
      %th #inspect
      %td= obj.inspect

    %tr
      %th #object_id
      %td= obj.object_id

    }
  end
end

G2::UI::THREAD = Thread.new{
  G2::UI.run! :port => 1291
}
