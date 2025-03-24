

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
        Icon(id: 1, name: "Bat", isColour: false, data1: 17309704173766064368),
        Icon(id: 2, name: "Trophy", isColour: false, data1: 3524239913838831664),
        Icon(id: 3, name: "Arrow", isColour: false, data1: 1742999708409802776),
        Icon(id: 4, name: "Spade", isColour: false, data1: 2034635272074378268),
        Icon(id: 5, name: "Heart", isColour: false, data1: 8718122526292507768),
        Icon(id: 6, name: "Club", isColour: false, data1: 1746368612036787224),
        Icon(id: 7, name: "Diamond", isColour: false, data1: 1746410393481133080),
        Icon(id: 8, name: "Zig", isColour: false, data1: 14757226376558555955),
        Icon(id: 9, name: "Big Zig", isColour: false, data1: 17361641477348724495),
        Icon(id: 10, name: "Fog", isColour: false, data1: 12273903644374837845),
        Icon(id: 11, name: "Triangle", isColour: false, data1: 9169081515752227072),
        Icon(id: 12, name: "Stripes", isColour: false, data1: 11082345154861622835)
    ]
}

