require_relative 'wagon'

class Cargo < Wagon

  attr_reader :type

  def initialize
    @type = "cargo"
  end

end