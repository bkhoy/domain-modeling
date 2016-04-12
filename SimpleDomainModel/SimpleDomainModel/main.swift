//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation



////////////////////////////////////
// Money
//
public struct Money {
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
    let scale = conversion[self.currency]! / conversion[to]!
    return Money(amount: Int(Double(self.amount) * scale), currency: to)
  }

  public func add(to: Money) -> Money {
    if self.currency == to.currency {
        return Money(amount: self.amount + to.amount, currency: self.currency)
    } else {
        let newMoney = self.convert(self.currency)
        return Money(amount: self.amount + newMoney.amount, currency: self.currency)
    }
  }
    
  public func subtract(from: Money) -> Money {
    if self.currency == from.currency {
        return Money(amount: self.amount - from.amount, currency: self.currency)
    } else {
        let newMoney = self.convert(self.currency)
        return Money(amount: self.amount - newMoney.amount, currency: self.currency)
    }
  }
}

////////////////////////////////////
// Job
//
public class Job {
 
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
        return (Int(rate * Double(hours)))
    case .Salary(let value):
        return value
    }
  }
 /*
    //passed in a percentage
    //expected to add the percentage of salary to total salary
  public func raise(amt : Double) {
    
    switch self.type {
    case .Hourly(let rate):
        let addMoney = rate + amt
    case .Salary(let value):
        let addMoney = Int(Double(value) * amt)
    }
  }
}
    
    */

////////////////////////////////////
// Person
//
public class Person {
  public var firstName : String = ""
  public var lastName : String = ""
  public var age : Int = 0

  public var job : Job? {
    get { return self.job }
    set(value) {
        if self.age < 16 { self.job = nil }
        else { self.job = value }
    }
  }
    

  //matt.spouse = Person(firstName: "Bambi", lastName: "Jones", age: 42)
  public var spouse : Person? {
    get { return self.spouse }
    set(value) {
        if self.age < 18 { self.spouse = nil }
        else { self.spouse = value }
    }
  }
    
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
    
    //[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]
  public func toString() -> String {
    return("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job) spouse:\(spouse)]")
  }
    
}
/*
////////////////////////////////////
// Family
//
public class Family {
  private var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  public func haveChild(child: Person) -> Bool {
  }
  
  public func householdIncome() -> Int {
  }


*/
}
print("Hello, World!")
let testMoney = Money(amount: 2, currency: "USD")
print(testMoney.convert("EUR"))

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }

}


