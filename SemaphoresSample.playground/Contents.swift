//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "This playground will demo soultion to 2threaded problem"

let queue1 = DispatchQueue(label: "first", qos: .background, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
let queue2 = DispatchQueue(label: "second", qos: .background, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)

let semaphore = DispatchSemaphore(value: 0)
let maxTimeOut = 10 // play with this

queue1.async {
    print("queue1 started")
    semaphore.wait(timeout:  .now() + .seconds(maxTimeOut))
    print("queue1 finished")
}

queue2.async {
    print("queue2 started")
    queue2.asyncAfter(deadline: .now() + .seconds(3), execute: {
        print("queue2 finished")
        semaphore.signal()
    })
}

PlaygroundPage.current.needsIndefiniteExecution = true
