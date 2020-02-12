import Foundation

func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

let result = calculator(n1: 3, n2: 6, operation: {$0 + $1})

let array = [3, 5, 4, 1, 2, 8, 10, 14]

func addOne(no1: Int) -> Int{
    return no1 + 1
}



