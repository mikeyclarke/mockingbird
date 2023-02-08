import Swinject

class FormatterAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TimeAgoFormatter.self) { _ in
            TimeAgoFormatter()
        }
    }
}
