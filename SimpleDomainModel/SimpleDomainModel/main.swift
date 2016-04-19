//  Brittney Hoy
//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

public class TestMe {
    public func Please() -> String {
        return "I have been tested"
    }
    
}

protocol CustomStringConvertible {
    var description : String { get }
}

protocol Mathematics {
    func +(left: Money, right: Money) -> Money
    
    func -(left: Money, right: Money) -> Money
}

public func +(left: Money, right: Money) -> Money {
    let result = left.add(right)
    return result
}

public func -(left: Money, right: Money) -> Money {
    let result = left.subtract(right)
    return result
}


extension Double {
    var USD: Money {return Money(amount: Int(self), currency: "USD")}
    
    var EUR: Money {return Money(amount: Int(self), currency: "EUR")}
    
    var GBP: Money {return Money(amount: Int(self), currency: "GBP")}
    
    var YEN: Money {return Money(amount: Int(self), currency: "YEN")}
}


////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics {
    public var amount : Int
    public var currency : String

    //1 USD = .5 GBP (2 USD = 1 GBP) 
    //1 USD = 1.5 EUR (2 USD = 3 EUR) 
    //1 USD = 1.25 CAN (4 USD = 5 CAN)
    
    public func convert(to: String) -> Money {
    //if currencies are the same, return itself
        if self.currency == to {
            return self
        }
        let conversion = ["USD": 1, "EUR": 1.5, "CAN": 1.25, "GBP": 0.5]
        let scale = conversion[to]! / conversion[self.currency]!
        return Money(amount: Int(Double(self.amount) * scale), currency: to)
    }

    public func add(to: Money) -> Money {
        if self.currency == to.currency {
            return Money(amount: self.amount + to.amount, currency: self.currency)
        } else {
            let newMoney = self.convert(to.currency)
            return Money(amount: to.amount + newMoney.amount, currency: to.currency)
        }
    }
    
    public func subtract(from: Money) -> Money {
        if self.currency == from.currency {
            return Money(amount: self.amount - from.amount, currency: self.currency)
        } else {
            let newMoney = self.convert(from.currency)
            return Money(amount: newMoney.amount - from.amount, currency: self.currency)
        }
    }
    public var description : String {
        get{
            return "\(self.currency)\(self.amount)"
        }
    }

}

////////////////////////////////////
// Job
//
public class Job : CustomStringConvertible {
 
    public var title : String
    public var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }

    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }

    public func calculateIncome(hours: Int) -> Int {
        switch self.type {
        case .Hourly(let rate):
            return Int(rate * Double(hours))
        case .Salary(let value):
            return value
        }
    }

    public func raise(amt : Double) {
        switch self.type {
        case .Hourly(let rate):
            self.type = .Hourly(Double(rate + amt))
        case .Salary(let value):
            self.type = .Salary(value + Int(amt))
        }
        
    }
    
    public var description : String {
        get {
            switch self.type {
            case .Hourly(let value) :
                print(value)
                return "\(self.title) - $\(value) per hour"
            case .Salary(let value) :
                return "\(self.title) - $\(value) per year"
            }
            
        }
    }
}

////////////////////////////////////
// Person
//
public class Person : CustomStringConvertible {
    public var firstName : String = ""
    public var lastName : String = ""
    public var age : Int = 0
    public var job2 : Job?
    public var spouse2 : Person?


    public var job : Job? {
        get {
            if self.age < 16 {
                return nil
            } else {
                return job2
            }
        }
        set(value) {
            job2 = value
        }
    }
    
    public var spouse : Person? {
        get {
            if self.age < 18 {
                return nil
            } else {
                return spouse2
            }
        }
        set(value) {
            spouse2 = value
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        job2 = nil
        spouse2 = nil
    }
    
    public func toString() -> String {
        return("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job2) spouse:\(spouse2)]")
    }
    
    public var description : String {
        get {
            var hasJob = "no job"
            
            var hasSpouse = "no spouse"
            
            if self.job != nil {
                hasJob = self.job!.title
            }
            
            if self.spouse != nil {
                hasSpouse = "\(self.spouse!.firstName) \(self.spouse!.lastName)"
            }
            return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(hasJob) spouse:\(hasSpouse)]"
        }
    }
}

////////////////////////////////////
// Family
//
public class Family : CustomStringConvertible {
    private var members : [Person] = []
  
    public init(spouse1: Person, spouse2: Person) {
        if spouse1.spouse == nil && spouse2.spouse == nil {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse1)
            members.append(spouse2)
        }
    }
  
    public func haveChild(child: Person) -> Bool {
        var ofAge = false;
        for member in members {
            if member.age > 21 {
                ofAge = true;
            }
        }
        if ofAge {
            members.append(child)
        }
        return ofAge;
    }
  
    public func householdIncome() -> Int {
        var total = 0;
        for member in members {
            if member.job != nil {
                total += (member.job?.calculateIncome(2000))!
            }
        }
        return total
    }
    
    public var description : String {
        get {
            var family = "Family: "
            for member in members {
                family += "\(member.description) "
            }
            
            family += "Household income: \(householdIncome())"
            return family
        }
    }
}


