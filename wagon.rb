require_relative 'company_manufacturer'
require_relative 'Instance_counter'

class Wagon
  include CompanyName
  include InstanceCounter
end