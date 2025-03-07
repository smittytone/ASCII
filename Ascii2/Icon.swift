

struct Icon: Identifiable {
    
    var id: Int         = 0
    var name: String    = "Untitled"
    var isColour: Bool  = false
    var data1: UInt64   = 0
    var data2: UInt64   = 0
}


struct AsciiLibrary {

    static let icons: [Icon] = [
        Icon(id: 0, name: "Alien", isColour: false, data1: 1097874442017455119),
        Icon(id: 1, name: "Arrow", isColour: false, data1: 1742999708409802776),
        Icon(id: 2, name: "Bat", isColour: false, data1: 17309704173766064368),
        Icon(id: 3, name: "Trophy", isColour: false, data1: 3524239913838831664)
    ]
}

