import Swinject

class ConverterAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(V2TweetsResponseConverter.self) { _ in
            V2TweetsResponseConverter()
        }
    }
}
