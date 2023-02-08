import Swinject

protocol AuthenticatedAssembly: Assembly {
    init(userAuthenticatedTwitterClient: TwitterApiClient)
}

class DependencyManager {
    public static let authenticatedAssemblies: [AuthenticatedAssembly.Type] = [
        RepositoryAssembly.self,
        TimelineAssembly.self
    ]
    public static var assembler = Assembler()

    public static func boot() {
        let container = Container()
        assembler = Assembler(
            [
                FormatterAssembly(),
                ConverterAssembly(),
            ],
            container: container
        )
    }

    public static func applyAuthenticatedAssemblies(userAuthenticatedTwitterClient: TwitterApiClient) {
        var initializedAssemblies: [AuthenticatedAssembly] = []

        for assembly in authenticatedAssemblies {
            initializedAssemblies.append(assembly.init(userAuthenticatedTwitterClient: userAuthenticatedTwitterClient))
        }

        assembler.apply(assemblies: initializedAssemblies)
    }
}
