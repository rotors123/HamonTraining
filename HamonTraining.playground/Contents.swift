//: HamonTrainingPlayground

import UIKit

// 波紋初心者向けとして、手始めに2分間(120s)実施する。
// （最終的には10分間）
let executionTime = 120

let op1 = BlockOperation {
    let s = 1
    Thread.current.name = "1秒間に\(s)回の呼吸"
    
    for i in 0 ..< executionTime / s {
        print(Thread.current.description + ": \(i + 1)回目")
        Thread.sleep(forTimeInterval: 1 / Double(s))
    }
}
let op2 = BlockOperation {
    let m = 1, s = m * 60
    Thread.current.name = "\(m)分間息を吸い続け、その後吐き続ける"
    for i in 0 ..< executionTime / s {
        print(Thread.current.description + ": \(i + 1)回目")
        Thread.sleep(forTimeInterval: Double(s))
    }
}

let op3 = BlockOperation {
    Thread.current.name = "グラスのワインを溢さず蛙をメメタァ"
    print(Thread.current.description)
}

op3.addDependency(op1)
op3.addDependency(op2)

let queue = OperationQueue()

queue.addOperation(op1)
queue.addOperation(op2)
queue.addOperation(op3)

queue.waitUntilAllOperationsAreFinished()

