#
# TERMINOLOGY
# **Client**:  object that invokes a Factory
# **Factory**: object responsible for creating other objects
# **Product**: object created by a Factory
#
# GOOD
# + extract object and apply SRP (object only creates other objects)
# + introduce open/closed principle (easy to extend with new product)
# + simplify creation of products by using only one interface
# + prevent creating dependencies on product constants
#
# BAD
# - raising complexity (new object is introduced to the codebase)
#

class Car
  def drive
    # custom logic
  end
end

class Bicycle
  def drive
    # custom logic
  end
end

class Motorcycle # <-- Product
  def drive
    # custom logic
  end
end

class VehicleFactory # <-- Factory
  VEHICLES = {
    car: Car,
    bicycle: Bicycle,
    motorcycle: Motorcycle
  }

  def self.build(vehicle_type, args)
    VEHICLES[vehicle_type].new(*args)
  end
end

#
# `main` <-- CLIENT
#
vehicle_args = []
car = VehicleFactory.build(:car, vehicle_args)
car.drive
