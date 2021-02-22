import SwiftUI

struct Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var subtext: String
    var address: String
    var status: String
}

struct RestaurantRow: View {
    var restaurant: Restaurant
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Visit us at \(restaurant.name)")
                    .padding(.bottom, 5)
                    .font(.system(size: 20))
                Text("\(restaurant.subtext)").font(.system(size: 17))
                    .padding(.trailing, 5)
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                HStack(alignment: .center) {
                    Text("\(restaurant.address)").font(.subheadline)
                    Spacer()
                    Text("\(restaurant.status)")
                        .padding(5)
                        .font(.footnote)
                        .border(Color.green, width: 1)
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                }
            }.padding(5)
        }
    }
}

struct RestaurantView: View {
    var body: some View {
        let restaurants = buildData()
        return List(restaurants) { restaurant in
                    RestaurantRow(restaurant: restaurant)
        }
        .navigationBarTitle("Restaurants",
                            displayMode: .inline)
    }
    
    func buildData() -> [Restaurant] {
        let first = Restaurant(name: "Yummy Chinese",
                               subtext: "Drinks are complimentary",
                               address: "Brooklyn, New York",
                               status: "CLOSED")
        let second = Restaurant(name: "Paprika - Premium Italian Cuisine",
                                subtext: "Free Wine",
                                address: "Manhattan, New York",
                                status: "OPEN")
        let third = Restaurant(name: "Dugout",
                               subtext: "Drinks at a flat rate of $10",
                               address: "Manhattan, New York",
                               status: "OPEN")
        let restaurants = [first, second, third]
        return restaurants
    }
}

//struct ContentView: View {
//    var body: some View {
//        CombineView()
//    }
//}


struct ContentView: View {
    var body: some View {
        RestaurantView()
    }
}

// MARK: - Previews -
#if DEBUG
@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ContentViewOutside_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
