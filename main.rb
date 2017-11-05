require_relative 'train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'

class Main

  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    loop do
      puts "What do you want:
      Make station - 1
      Make train - 2
      Make route(add/delete route) - 3
      Set route to train - 4
      Add wagon to train - 5
      Leave wagon from train - 6
      Move train forward/back - 7
      Stations list with trains - 8

      Exit - 0"

      action = gets.chomp.to_i

      case action
        when 1
          make_station
        when 2
          make_train
        when 3
          make_route_and_govern_stations
        when 4
          get_route
        when 5
          get_wagon
        when 6
          push_wagon
        when 7
          move_train
        when 8
          choose_station
      end

      break if action.zero?
    end
  end

  private # данные методы не вызываются извне

  def make_station
    puts "Enter station name"
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  def make_train
    puts "which train do you want to create? (Cargo or Passenger)"
    chose = gets.chomp
    begin
    puts "enter the train number in the format xxx-xx"
    number = gets.chomp
    if chose == "Cargo"
      train = CargoTrain.new(number)
    elsif chose == "Passenger"
      train = PassengerTrain.new(number)
    end
    rescue ArgumentError => e
      puts e.message
      retry
    end
    puts "train #{train.number} was created"
    @trains << train
  end

  def make_route
    puts "Enter the first station"
    first_station = choose_station
    puts "Enter the last station"
    last_station = choose_station
    puts "Add route name"
    name = gets.chomp
    @routes << Route.new(name,first_station, last_station)
  end

  def choose_station
    puts "Choose station from list"
    @station_list = @stations.each_with_index {|station, index| puts "#{index +1}. #{station.name}"}
    chosen_station = gets.chomp
    @stations.select {|station| station.name == chosen_station}.first
  end

  def choose_route
    puts "Choose route from list"
    @routes_list = @routes.each_with_index {|route, index| puts "#{index +1}. #{route.name}"}
    chosen_route = gets.chomp
    @routes.select {|route| route.name == chosen_route}.first
  end

  def choose_train
    puts "Choose train from list"
    @train_list = @trains.each_with_index {|number, index| puts "#{index + 1}. #{number.number}"}
    train_number = gets.chomp
    @trains.select {|number| number.number == train_number}.first
  end


  def make_route_and_govern_stations
    puts "Make route - 1
          Add station to route - 2
          Delete station from route - 3
          Exit - 0"
    choice = gets.chomp.to_i
    case choice
      when 1 then make_route
      when 2 then add_station_to_route
      when 3 then delete_station_from_route
      when 0 then menu
    end
  end


  def add_station_to_route
    route = choose_route
    station = choose_station
    route.add_station(station)
  end

  def delete_station_from_route
    route = choose_route
    station = choose_station
    route.delete_station(station)
  end

  def get_route
    route = choose_route
    train = choose_train
    train.set_route(route)
  end

  def move_train
    puts "Go forward - 1
          Go back - 2
          Exit - 0"
    choice = gets.chomp.to_i
    case choice
      when 1 then go
      when 2 then go_back
      when 0 then menu
    end
  end

  def go
    train = choose_train
    train.forward
  end

  def go_back
    train = choose_train
    train.back
  end

  def get_wagon
    train = choose_train
    if train.class == PassengerTrain
      wagon = Passenger.new
    elsif train.class == CargoTrain
      wagon = Cargo.new
    end
    train.take_wagon(wagon)
  end

  def push_wagon
    train = choose_train
    if train.class == PassengerTrain
      wagon = Passenger.new
    elsif train.class == CargoTrain
      wagon = Cargo.new
    end
    train.leave_wagon(wagon)
  end


end


