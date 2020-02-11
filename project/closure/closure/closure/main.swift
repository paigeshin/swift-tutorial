var array = [6, 2, 3, 9, 4, 1]

func addOne(n1: Int) -> Int {
    return n1 + 1
}

let newArray = array.map({"\($0)"})


let newOnePlusArray = array.map({(n1) -> Int in n1 + 1})

