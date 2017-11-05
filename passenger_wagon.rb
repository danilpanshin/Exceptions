require_relative 'wagon'

class Passenger < Wagon

  attr_reader :type

  def initialize
    @type = "passenger"
  end

end