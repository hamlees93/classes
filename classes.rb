#Example app to practice using classes. 2 classes have been created - a cat and a dog class

require 'geocoder'


#Creating a cat class. User must add in all details following the world 'initialize' when creating a new instance of the class
class Cat
	def initialize(name, age, location, breed, colour)
		@name = name
		@age = age
		@location = location
		@breed = breed
		@colour = colour
	end

	#A function to make the cat speak out it's own information
	def speak
		puts "Meow. My name is #{@name.capitalize}."
		puts "I am #{@age} years old and I live in #{@location}"
		puts "I am a #{@colour.downcase} #{@breed.downcase}."
	end
end

#Calling the cat class to create new objects
garfield = Cat.new("Garfield", 4, "New York", "Tom-Cat", "Orange")
garfield.speak
puts "###################"
catDog = Cat.new("CatDog", 12, "Sydney", "Tabby", "kind of off yellow")
catDog.speak
puts "###################"



#Practicing using attr_accessor. Setting it up like this only requires 'name' to create an object of the class Dog. Age, home and colour can be added at a later date, and the app won't break if they aren't added at all
class Dog
attr_accessor :name, :age, :home, :colour

	#These class variables are created to carry data between functions. The data from each time the walk function is called are stored in distance, location, coordinates and walk, while instances stores any new instances of the dog class
	@@distance = []
	@@location = []
	@@coordinates = []
	@@walks = 0
	@@instances = []

	#Object can be initialised just using name. Each time a new object is created, it is sent to the instances array
	def initialize name
		@name = name
		@@instances << self
	end

	#A self method to print out all objects of the class dog
	def self.names
		@@instances.each do |dog|
			puts dog.name
		end
	end

	#A method that saves the location, distance and coordinates of each walk each object goes on. This data is saved to class variables, and can be accessed in other functions. The self at the end returns the result of the function, allowing the chaining of walks
	def walk(location, distance)
		@@distance.append(distance)
		@@location.append(location)
		@time = Time.now
		exactLocations = Geocoder.search(location).first.coordinates
		@@coordinates.append(exactLocations)
		@@walks += 1
		self
	end

	#display all walks doggo has been on by accessing data in distance, location and coordinates arrays. This info is printed out with the dogs name, and the current time, printed in a user friendly manner
	def displayWalks
		i = 0
		while i < @@walks
			puts "Woof"
			puts "On the #{@time.strftime("%d-%m-%Y at %H:%M")} #{@name} walked #{@@distance[i]}kms in #{@@location[i]}, coordinates: #{@@coordinates[i]}. "
		i += 1
		end
	end

	#display the total distance doggo has walked, calculated by summing the integer value of distances together. This data is presented differently, depending on amoount of walks, just so the grammer checks out
	def totalDistance
		i = 0
		sum = 0
		while i < @@walks
			sum += @@distance[i].to_i
			i += 1
		end
		puts "Bark"
		if @@walks == 0
			puts "#{@name}'s owners don't love them. They haven't been on a walk yet :("
		elsif @@walks == 1
			puts "#{@name} has walked #{sum}kms in a single walk"
		else
			puts "#{@name} has already walked #{sum}kms in #{@@walks} walks"
		end
	end

	#Get doggo to say all instance variables about itself
	def speak
		puts "My name is #{@name}. I am a #{@colour} dog. I am #{@age} years old and live in #{@home}"
	end
end

#Testing code by adding 2 dogs and sending them on various walks
fido = Dog.new "Fido"
fido.age = 2
fido.home = "Sydney"
fido.colour = "Brown"
fido.speak
fido.walk("Sydney",2).walk("Brisbane",42).walk("Linden",8).walk("Hazelbrook",25).displayWalks
doggo = Dog.new "Spot"
doggo.age = 4
doggo.home = "Springwood"
doggo.colour = "Black"
doggo.speak
doggo.walk("Winmalee",10).walk("Springwood",23).displayWalks
doggo.totalDistance

puts
puts "The dogs currently at the dog park are: "
Dog.names