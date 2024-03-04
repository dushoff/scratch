
class Event:
    """An event in our grocery store simulation.

    Events have an ordering based on the event timestamp. For any two events
    e1 and e2, e1 < e2 iff event e1 has a timestamp that is less than event e2.
    This signifies that e1 happens before e2.

    This is an abstract class and should not be instantiated.

    Attributes:
    - timestamp: The time when this event occurs.

    Representation Invariants:
    - timestamp >= 0
    """
    timestamp: int

    def __init__(self, timestamp: int) -> None:
        """Initialize an Event with a given timestamp.

        Preconditions:
            - timestamp >= 0

        >>> Event(7).timestamp
        7
        """
        self.timestamp = timestamp

    # The following three methods allow for comparison of Event instances
    # using the standard comparison operators, such as ==, <, and <=.
    # All methods simply perform the desired comparison on the 'timestamp'
    # attribute of the two events.
    def __eq__(self, other: Event) -> bool:
        """Return whether this Event is equal to <other>.

        Two events are equal 
iff
 they have the same timestamp.

        >>> first = Event(1)
        >>> second = Event(2)
        >>> first == second
        False
        >>> second.timestamp = first.timestamp
        >>> first == second
        True
        """
        return self.timestamp == other.timestamp

    def __lt__(self, other: Event) -> bool:
        """Return True iff this Event is less than <other>.

        >>> first = Event(1)
        >>> second = Event(2)
        >>> first < second
        True
        >>> second < first
        False
        """
        return self.timestamp < other.timestamp

    def __le__(self, other: Event) -> bool:
        """Return True iff this Event is less than or equal to <other>.

        >>> first = Event(1)
        >>> second = Event(2)
        >>> first <= first
        True
        >>> first <= second
        True
        >>> second <= first
        False
        """
        return self.timestamp <= other.timestamp

    def do(self, store: GroceryStore) -> list[Event]:
        """Perform this event as specified in the A1 handout, and return any
        events generated by doing so.
        """
        raise NotImplementedError


# TODO: create subclasses for the different types of events below.
class CustomerArrival(Event):
    """A customer arrives at the checkout area ready to join a line and
    check out.

    Attributes:
    - customer: The arriving customer
    """
    timestamp: int
    customer: Customer

    def __init__(self, timestamp: int, c: Customer) -> None:
        """Initialize a CustomerArrival event with the given <timestamp>
        and customer <c>.

        If the customer's arrival time is None, set it now to record
        the fact that this is the time when they first arrived at the
        checkout area. (This is the start of their waiting time.)

        Preconditions:
        - timestamp >= 0
        """
        Event.__init__(self, timestamp)
        self.customer = c
        if c.arrival_time is None:
            c.arrival_time = timestamp + 1


class CheckoutStarted(Event):
    """A customer starts the checkout process in a particular checkout line.

    Attributes:
    - line_number: The number of the checkout line.
    """
    timestamp: int
    line_number: int

    def __init__(self, timestamp: int, line_number: int) -> None:
        """Initialize a CheckoutStarted event with the given <timestamp>
        and <line_number>.

        Preconditions:
        - timestamp >= 0
        - line_number >= 0
        """
        # TODO: Implement this method


class CheckoutCompleted(Event):
    """A customer finishes the checkout process.

    Attributes:
    - line_number: The number of the checkout line where a customer
      is finishing.
    - customer: The finishing customer.
    """
    timestamp: int
    line_number: int
    customer: Customer

    def __init__(self, timestamp: int, line_number: int, c: Customer) -> None:
        """Initialize a CheckoutCompleted event.
        """
        # TODO: Implement this method


class CloseLine(Event):
    """A CheckoutLine gets closed.

    Attributes:
    - line_number: The number of the checkout line.
    """
    timestamp: int
    line_number: int

    def __init__(self, timestamp: int, line_number: int) -> None:
        """Initialize a CloseLine event.
        """
        # TODO: Implement this method

