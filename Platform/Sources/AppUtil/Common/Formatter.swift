import Foundation


public struct Formatter{
    public static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()        
    
    
    public static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()        
        formatter.numberStyle = .currency
        return formatter
    }()
        
    
    // yyyy-MM-dd'T'HH:mm:ss
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
    
    public static let calendarFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    public static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
}
