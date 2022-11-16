class Resource:

    RED    = 0 # can only be collected within time windows
    BLUE   = 1 # takes longer to collect
    ORANGE = 2 # requires multiple actors to mine
    BLACK  = 3 # cannot be carried with any other resource
    GREEN  = 4 # decays over time

    def __init__(self, world, location, colour=0):
        """
        A resource in the craftbots simulation. Resources are produced from mines and used to build buildings. Each
        colour of the resources has its own special properties that affect how the resource can be collected or used.

        :param world: The world in which the resources exists
        :param location: The place the the resource currently is
        :param colour: The colour of the resource
        """
        self.world = world
        self.colour = colour
        self.location = location
        self.tick_created = self.world.tick
        self.used = False
        self.id = self.world.get_new_id()

        self.location.append_resource(self)

        self.fields = {"id": self.id, "location": self.location.id, "tick_created": self.tick_created,
                       "used": self.used, "colour": colour}

    def __repr__(self):
        return "Resource(" + str(self.id) + ", " + self.world.get_colour_string(self.colour) + ", " + str(
            self.location) + ")"

    def __str__(self):
        return self.__repr__()

    def update(self):
        """
        A call to update the resource, which is called by the world every tick. It only effects the green resource that
        will decay after a certain amount of time.
        """
        if self.colour == Resource.GREEN and self.world.tick - self.tick_created >= self.world.resource_config["green_decay_time"]:
            self.set_used(True)
            self.location.remove_resource(self)

    def set_location(self, location):
        """
        Sets the location of the resource and records the id of the location in the resources fields

        :param location: the new location
        """
        self.location = location
        self.fields.__setitem__("location", location.id)

    def set_used(self, used):
        """
        Sets the used state of the resource and records it in the resources fields

        :param used: the new used state
        """
        self.used = used
        self.fields.__setitem__("used", used)
