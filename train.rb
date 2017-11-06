require_relative 'company_manufacturer'
require_relative 'valid'
require_relative 'Instance_counter'

class Train

  include CompanyName
  include Exceptions
  include InstanceCounter

  attr_reader :speed, :wagons, :number

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, speed = 0)
    @number = number
    @speed  = speed
    @wagons =[]
    validate!
    @@trains[number] = self
  end

  def self.trains
    @@trains
  end

  def break
    @speed = 0
  end

  def take_wagon(wagon)
    @wagons << wagon if wagon.type == self.type && @speed == 0
  end


  def leave_wagon(wagon)
    @wagons.pop if @wagons.any? && @speed == 0
  end


  def set_route(route)
    @route = route
    @index_station = 0
    current_station.arrival_train(self)
  end

  def forward
    current_station.departure_train(self)
    @index_station += 1
    current_station.arrival_train(self)
  end

  def back
    current_station.departure_train(self)
    @index_station -= 1
    current_station.arrival_train(self)
  end

  def current_station
    @route.stations[@index_station]
  end

  def previous_station
    @route.stations[@index_station - 1]
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  protected

  def validate!
    raise ArgumentError, "number has invalid format" if @number !~ NUMBER_FORMAT
    raise ArgumentError, "wrong speed value" if @speed != 0
    true
  end

  def accelerate(num)
    @speed += num
  end

end
