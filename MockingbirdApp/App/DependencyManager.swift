import Swinject

class DependencyManager {
    public static var assembler = Assembler()

    public static func boot() {
        let container = Container()
        assembler = Assembler(
            [
                
            ],
            container: container
        )
    }
}
