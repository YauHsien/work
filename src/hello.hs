data FizzBuzz = Num Int | FizzBuzz Int String

instance Show FizzBuzz where
  show (Num n) = show n
  show (FizzBuzz _ fzbz) = show fzbz

fizzbuzz :: Int -> FizzBuzz
fizzbuzz n | n `mod` 15 == 0 = FizzBuzz n "fizzbuzz"
fizzbuzz n | n `mod` 3 == 0 = FizzBuzz n "fizz"
fizzbuzz n | n `mod` 5 == 0 = FizzBuzz n "buzz"
fizzbuzz n = Num n

fizzbuzzRun :: Int -> Int -> [FizzBuzz]
fizzbuzzRun n m = fizzbuzzRun1 n m (n `mod` 3, n `mod` 5)

fizzbuzzRun1 :: Int -> Int -> (Int, Int) -> [FizzBuzz]
fizzbuzzRun1 n m _ | n > m = []
fizzbuzzRun1 n m (0, 0) = FizzBuzz n "fizzbuzz" : fizzbuzzRun1 (n+1) m (1, 1)
fizzbuzzRun1 n m (0, k) | k < 4 = FizzBuzz n "fizz" : fizzbuzzRun1 (n+1) m (1, nextMod 5 k)
fizzbuzzRun1 n m (k, 0) | k < 2 = FizzBuzz n "buzz" : fizzbuzzRun1 (n+1) m (nextMod 3 k, 1)
fizzbuzzRun1 n m (k, l) = Num n : fizzbuzzRun1 (n+1) m (nextMod 3 k, nextMod 5 l)

nextMod :: Int -> Int -> Int
nextMod n m | n - 1 == m = 0
nextMod n m | n - 1 > m = m + 1

-- *Main> map fizzbuzz [1..100]
-- [1,2,"fizz",4,"buzz","fizz",7,8,"fizz","buzz",11,"fizz",13,14,"fizzbuzz",16,17,"fizz",19,"buzz","fizz",22,23,"fizz","buzz",26,"fizz",28,29,"fizzbuzz",31,32,"fizz",34,"buzz","fizz",37,38,"fizz","buzz",41,"fizz",43,44,"fizzbuzz",46,47,"fizz",49,"buzz","fizz",52,53,"fizz","buzz",56,"fizz",58,59,"fizzbuzz",61,62,"fizz",64,"buzz","fizz",67,68,"fizz","buzz",71,"fizz",73,74,"fizzbuzz",76,77,"fizz",79,"buzz","fizz",82,83,"fizz","buzz",86,"fizz",88,89,"fizzbuzz",91,92,"fizz",94,"buzz","fizz",97,98,"fizz","buzz"]

-- *Main> fizzbuzzRun 1 100
-- [1,2,"fizz",4,"buzz","fizz",7,8,"fizz","buzz",11,"fizz",13,14,"fizzbuzz",16,17,"fizz",19,"buzz","fizz",22,23,"fizz","buzz",26,"fizz",28,29,"fizzbuzz",31,32,"fizz",34,"buzz","fizz",37,38,"fizz","buzz",41,"fizz",43,44,"fizzbuzz",46,47,"fizz",49,"buzz","fizz",52,53,"fizz","buzz",56,"fizz",58,59,"fizzbuzz",61,62,"fizz",64,"buzz","fizz",67,68,"fizz","buzz",71,"fizz",73,74,"fizzbuzz",76,77,"fizz",79,"buzz","fizz",82,83,"fizz","buzz",86,"fizz",88,89,"fizzbuzz",91,92,"fizz",94,"buzz","fizz",97,98,"fizz","buzz"]
