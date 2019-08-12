//
//  Array+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation

public extension Array where Element: Equatable {
    var uniqueElementsInOrder: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}

public extension Array where Element: Hashable {
    func uniqueArray() -> Array {
        return Array(Set(self))
    }
}

public extension Array where Element: Comparable {
    // MARK: - Swap an item in array with the current if it satisfies the scenario. Do this until complete acension and descension exists.
    func selectionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        
        for i in 0..<(data.count-1) {
            var key = i // 1
            
            for j in i+1..<data.count where areInIncreasingOrder(data[j], data[key]) { // 2
                key = j
            }
            
            guard i != key else { continue }
            
            data.swapAt(i, key) // 3
        }
        
        return data
    }
}

extension Array where Element: Comparable {
    // MARK: - Sort array by moving values 1 x 1 to the end of the array until ascencion or descension exists.
    func bubbleSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        for i in 0..<(data.count-1) {
            for j in 0..<(data.count-i-1) where areInIncreasingOrder(data[j+1], data[j]) {
                data.swapAt(j, j + 1)
            }
        }
        return data
    }
}

extension Array where Element: Comparable {
    // MARK: - Like sorting a deck of cards. Pull card out and order while keeping a reference to the new order, then replace until acension or descension exists.
    // Best for small itemsets
    func insertionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        
        for i in 1..<data.count { // 1
            let key = data[i] // 2
            var j = i - 1
            
            while j >= 0 && areInIncreasingOrder(key, data[j]) { // 3
                data[j+1] = data[j] // 4
                
                j = j - 1
            }
            
            data[j + 1] = key // 5
        }
        
        return data
    }
}

extension Array where Element: Comparable {
    //  MARK: - Merge sort is the most efficient by splitting the data into chucnks and performing sorting accordingly until ascension or descension exists.
    private func merge(left: [Element], right: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var output: [Element] = []
        
        var mutableLeft = left
        var mutableRight = right
        while mutableLeft.count > 0 && mutableRight.count > 0 {
            
            if let firstElement = mutableLeft.first, let secondElement = mutableRight.first {
                
                if !areInIncreasingOrder(firstElement, secondElement) {
                    output.append(secondElement)
                    mutableRight.remove(at: 0)
                } else {
                    output.append(firstElement)
                    mutableLeft.remove(at: 0)
                }
            }
        }
        
        output.append(contentsOf: mutableLeft)
        output.append(contentsOf: mutableRight)
        
        return output
    }
    
    private func _emMergeSort(data: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        if data.count < 2 { return data }
        
        let leftArray = Array(data[..<Int(data.count / 2)]) // 1
        let rightArray = Array(data[Int(data.count / 2)..<data.count]) // 2
        return merge(left: _emMergeSort(data: leftArray, by: areInIncreasingOrder), right: _emMergeSort(data: rightArray, by: areInIncreasingOrder), by: areInIncreasingOrder) // 3
    }
    
    func emMergeSort(by: ((Element, Element) -> Bool) = (<)) -> [Element] {
        let data = self
        return _emMergeSort(data: data, by: by)
    }
}

extension Array where Element: Comparable {
    // MARK: - Similar to the merge sort but uses less space to achieve complete ascension or descension. However its best on small sets of data.
    private func _quickSort(_ array: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool)) -> [Element] {
        if array.count < 2 { return array } // 0
        
        var data = array
        
        let pivot = data.remove(at: 0) // 1
        let left = data.filter { areInIncreasingOrder($0, pivot) } // 2
        let right = data.filter { !areInIncreasingOrder($0, pivot) } // 3
        let middle = [pivot]
        
        return _quickSort(left, by: areInIncreasingOrder) + middle + _quickSort(right, by: areInIncreasingOrder) // 4
    }
    
    func quickSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        return _quickSort(self, by: areInIncreasingOrder)
    }
}
