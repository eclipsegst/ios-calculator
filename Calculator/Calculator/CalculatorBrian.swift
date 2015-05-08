//
//  CalculatorBrian.swift
//  Calculator
//
//  Created by iOS Students on 5/7/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    // : Printable - is a protocol, return description
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                    case .Operand(let operand):
                        return "\(operand)"
                    case .UnaryOperation(let symbol, _):
                        return symbol
                    case .BinaryOperation(let symbol, _):
                        return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    //var knownOps = Dictionary<String, Op>()
    private var knownOps = [String:Op]()
    
    init() {
        
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        //knownOps["×"] = Op.BinaryOperation("×") { $0 * $1}
        //knownOps["×"] = Op.BinaryOperation("×", *)
        learnOp(Op.BinaryOperation("×", *))
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0}
        knownOps["+"] = Op.BinaryOperation("+") { $0 + $1}
        knownOps["−"] = Op.BinaryOperation("−") { $1 - $0}
        //knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
                
    }
    
//    typealias PropertyList = AnyObject
//    var program: PropertyList {
    var program: AnyObject {    // guaranteed to be a PropertyList
        
        get {
//            var returnValue = Array<String>()
//            for op in opStack {
//                returnValue.append(op.description)
//            }
//            return returnValue
            // Replace above with one line below
            return opStack.map { $0.description }
        }
        set {
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols {
                    if let op = knownOps[opSymbol] {
                        newOpStack.append(op)
                    } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                        newOpStack.append(.Operand(operand))
                    }
                }
                opStack = newOpStack
            }
        }
        
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        
        if !ops.isEmpty {
            // copy ops
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
                // case op.Operand
                case .Operand(let operand):
                    return (operand, remainingOps)
                // _ ignore that part
                case .UnaryOperation(_, let operation):
                    let operandEvaluation = evaluate(remainingOps)
                    if let operand = operandEvaluation.result {
                        return (operation(operand), operandEvaluation.remainingOps)
                    }
                case .BinaryOperation(_, let operation):
                    let op1Evaluation = evaluate(remainingOps)
                    if let operand1 = op1Evaluation.result {
                        let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result {
                            return (operation(operand1, operand2), op2Evaluation.remainingOps)
                        }
                    }
            }
            
        }
        
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        // result = result, remainder = remainingOps
        let (result, remainder) = evaluate(opStack)
        // let (result, _) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
        
    }
}