### Introduction

### Usage

#### Monoid identity element zero
    pry(main)> ø(String)
      => ""
    
    pry(main)> ø(Fixnum)
      => 0

#### Lambda shorthand using λ and array syntax for fn calls
    pry(main)> x = λ {|e| e + 1}
      => x[2]
        => 3

    pry(main)> y = λ {|x, y| x + y}
      => y[1,2]
        => 3
        
#### first-class functional folds and maps
    pry(main)> fold [1,2,3,4] {|x,y| x + y}
      => 10
      
    pry(main)> fmap [1,2,3] {|x| x + 1}
      => [2,3,4]

    pry(main)> z = λ {|x| fold(x) {|x,y| x + y}}
      => z[[1,2]]
        => 3
#### shorthand for first-class inject        
    pry(main)> λ {|x| ƒ(x) {|x,y| x + y}}[[1,2]]
        => 3
        
#### Universal quantification
    pry(main)> ∀ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
      => false
      
#### Existential quantification
    pry(main)> ∃ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
      => true
      
#### Existential type quantification
    pry(main)> ∃t [1,2,"cat",3], Fixnum
      => true

#### Object and module replication

    pry(main)> class B; end;
    pry(main)> x = B.replicate(5)
      => [B, B, B, B, B]

#### ordered array -> hash
    x = [1,2,3,4]
    pry(main)> [1,2,3,4].to_hash
      => {0=>1, 1=>2, 2=>3, 3=>4}

#### zipped array -> hash
    x = [[1,2],[3,4]]
    pry(main)> [[1,2],[3,4]].to_hash
      => {1=>2, 3=>4}

#### hash -> zipped array
    x = {"cat" => "dog", 1 => 2}
    pry(main)> x.to_a
      => [["cat", "dog"], [1, 2]]
      
