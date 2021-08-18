
This Commit is regarding the Drawing a dependency reationship diagram for the codebase:

In this lecture the dependency inversion principle and composition

1. Understand basic depiction of dependencies, abstractions, and concrete types in diagrams
2. Understand how diagrams translate into code and vice versa
3. Understand how the SOLID principles and composition are applied through the examples
4. Understand differences and similarities between closures and protocols as abstractions in Swift (unnamed type signatures vs. strictly named types)

__Visualizing the dependency graph__
1. Visualizing our code in diagrams can be a great framework to think while modeling the design of our systems.
2. The early visualization of the design can make an excellent tool for communicating ideas to our colleagues and planning/coordinating a team effort. 
3. Diagrams can also help with independent development, as the team can quickly plan new features design (5-10 minutes on a whiteboard), build them in parallel and later integrate the pieces without conflicting with the work of other developers.

Moreover, diagrams serve as a great diagnostic tool as they embody the dependency graph of components and modules, revealing tight coupling and even retain cycles that could potentially lead to rigidity and memory leaks. Learning how to draw and read diagrams is an excellent addition to the skillset of developers that aim to create sustainable codebases.

__Writing/Reading Dependency Diagrams__
There are different types of dependency you can represent in a dependency diagram using different annotations, lines, and arrows. Here are the main ones:

1. Solid line, empty head = "inherits from" / "is a".

A solid line with an empty head denotes that a class inherits from another class.

    Example:
    class MyViewController: UIViewController {}

    The MyViewController class inherits from the UIViewController class, or the MyViewController "is a" subtype of UIViewController.

2. Dashed line, empty head = "conforms to" or "implements"

A dashed line with an empty head denotes that a component conforms/implements a protocol/abstract interface.

    Example:
    protocol HTTPClient {}

    class URLSessionHTTPClient: HTTPClient {}

    The URLSessionHTTPClient conforms to the HTTPClient protocol.

3. Solid line, filled head = "depends on" / "has a" (strong dependency)

A solid line with a filled head denotes a strong dependency.

When a type instance depends on another type instance to exist, it's considered a stronger dependency, such as Association, Aggregation, and Composition.

    Example:

    class RemoteFeedLoader {
        private let client: HTTPClient

        init(client: HTTPClient) {
            self.client = client
        }
    }

    The RemoteFeedLoader *has an* HTTPClient.

    You cannot instantiate a RemoteFeedLoader without an HTTPClient instance. The code wouldn't even compile. So that's a strong dependency.

    The RemoteFeedLoader depends on an HTTPClient to exist.

4. Dashed line, filled head = "depends on" (weak dependency)

A dashed line with a filled head denotes a weak dependency.

It's important to note that a type can depend on and use another but still work without one.

    Example:

    class RemoteFeedLoader {
        func load(with client: HTTPClient) {
            client.doSomething()
        }
    }

    The RemoteFeedLoader has a source code dependency to the HTTPClient because it references and uses it. But it doesn't require an HTTPClient instance to exist.

You can create a RemoteFeedLoader without an HTTPClient.

That's considered a weaker dependency, but still a dependency!

The RemoteFeedLoader **uses an** HTTPClient dependency in the load method. But it doesn't *have* one. It must be provided as a parameter.

Those are the main concepts to keep in mind when writing/reading dependency diagrams. But remember that you don't need to annotate your diagrams for each specific dependency precisely. It depends on how thorough you want to be in your diagrams. If the diagram becomes too complex, it may lose its value because no one will understand it. So it's important to annotate what will make a difference to help others understand the message you want to pass.

