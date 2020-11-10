#
# TERMINOLOGY
# **Subject**:  object responsible for notifying other objects (Observers)
# **Observer**: object being notified by Subject
#
# RESOURCES
#   Wikipedia:        https://en.wikipedia.org/wiki/Observer_pattern
#   Refactoring guru: https://refactoring.guru/design-patterns/observer
#   Hackernoon:       https://hackernoon.com/observer-vs-pub-sub-pattern-50d3b27f838c
#
# PROBLEM
#   How to notify different objects on a certain event?
#
# SOLUTION
#   Use a Subject object to hold references to objects that immplement Observer
#   interface. Upon an event, notify/update subscribed observers about the event.
#

class Subject
  def observers
    @observers ||= {}
  end

  def subscribe(new_observer)
    observers[new_observer.id] = new_observer
  end

  def unsubscribe(existing_observer)
    observers.delete(existing_observer.id)
  end

  def notify!(new_event)
    observers.values.each { |observer| observer.update(new_event) }
  end
end

module Observable
  def events
    @events ||= []
  end

  def last_event
    events.last
  end

  def update(new_event)
    events << new_event
  end
end

class Foo
  include Observable

  def id
    @id ||= rand(1_000_000)
  end

  def present_last_event
     puts "From #{self.class} instance: #{last_event.downcase}"
  end
end

class Bar
  include Observable

  def id
    @id ||= rand(1_000_000)
  end

  def present_last_event
     puts "From #{self.class} instance: #{last_event.upcase}"
  end
end

subject = Subject.new

foo = Foo.new
bar = Bar.new

subject.subscribe(foo)
subject.subscribe(bar)

subject.notify!("First event")
foo.present_last_event
bar.present_last_event

subject.unsubscribe(bar)

subject.notify!("Second event")
foo.present_last_event
bar.present_last_event # <- Didn't receive second event
