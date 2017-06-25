//
//  Problem11.swift
//  Euler
//
//  Created by Erik Villegas on 6/23/17.
//  Copyright © 2017 Erik Villegas. All rights reserved.
//

import Foundation

class Problem11 {
    var currentHighestProduct = -1
    var currentHighestNumbers = (-1, -1, -1, -1)
    
    var grid = Array(repeating: Array(repeating: 0, count: 20), count: 20)
    
    @discardableResult
    func checkAndCompare(first: Int, second: Int, third: Int, fourth: Int) -> Bool {
        let product = first * second * third * fourth
        
        if product > currentHighestProduct {
            currentHighestProduct = product
            currentHighestNumbers = (first, second, third, fourth)
            return true
        }
        return false
    }
    
    func enumerateGrid(enumerator: (_ number: Int, _ column: Int, _ row: Int) -> ()) {
        for (column, columnArray) in grid.enumerated() {
            for (row, value) in columnArray.enumerated() {
                enumerator(value, column, row)
            }
        }
    }
    
    func searchLeftRight() {
        self.enumerateGrid { (value, column, row) in
            let secondNumber = gridNumberAt(column + 1, row)
            let thirdNumber = gridNumberAt(column + 2, row)
            let fourthNumber = gridNumberAt(column + 3, row)
            
            if let second = secondNumber, let third = thirdNumber, let fourth = fourthNumber {
                self.checkAndCompare(first: value, second: second, third: third, fourth: fourth)
            }
        }
    }
    
    func searchUpDown() {
        self.enumerateGrid { (value, column, row) in
            let secondNumber = gridNumberAt(column, row + 1)
            let thirdNumber = gridNumberAt(column, row + 2)
            let fourthNumber = gridNumberAt(column, row + 3)
            
            if let second = secondNumber, let third = thirdNumber, let fourth = fourthNumber {
                self.checkAndCompare(first: value, second: second, third: third, fourth: fourth)
            }
        }
    }
    
    func searchDiagonalForward() {
        self.enumerateGrid { (value, column, row) in
            let secondNumber = gridNumberAt(column - 1, row + 1)
            let thirdNumber = gridNumberAt(column - 2, row + 2)
            let fourthNumber = gridNumberAt(column - 3, row + 3)
            
            if let second = secondNumber, let third = thirdNumber, let fourth = fourthNumber {
                self.checkAndCompare(first: value, second: second, third: third, fourth: fourth)
            }
        }
    }
    
    func searchDiagonalBackwards() {
        self.enumerateGrid { (value, column, row) in
            let secondNumber = gridNumberAt(column + 1, row + 1)
            let thirdNumber = gridNumberAt(column + 2, row + 2)
            let fourthNumber = gridNumberAt(column + 3, row + 3)
            
            if let second = secondNumber, let third = thirdNumber, let fourth = fourthNumber {
                self.checkAndCompare(first: value, second: second, third: third, fourth: fourth)
            }
        }
    }
    
    func solve(input: String) -> Int {
        let numberStrings = input.split { $0 == " " || $0 == "\n" }
        let numbers = numberStrings.map { Int(String($0))! }
        
        for (index, number) in numbers.enumerated() {
            let row = index/20
            let column = index % 20
            
            grid[column][row] = number
        }
        
        self.searchLeftRight()
        self.searchUpDown()
        self.searchDiagonalForward()
        self.searchDiagonalBackwards()
        
        return currentHighestProduct
    }
    
    /// Helper
    
    func gridNumberAt(_ column: Int, _ row: Int) -> Int? {
        guard column >= 0 && column < 20 && row >= 0 && row < 20 else {
            return nil
        }
        return grid[column][row]
    }
}


