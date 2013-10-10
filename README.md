### Introduction

### Usage

    pry(main)> ø(String)
      => ""
    
    pry(main)> ø(Fixnum)
      => 0

    pry(main)> x = λ {|e| e + 1}
      => x[2]
        => 3

    pry(main)> y = λ {|x, y| x + y}
      => y[1,2]
        => 3

    pry(main)> ƒ [1,2,3,4] {|x,y| x + y}
      => 10

    pry(main)> z = L {|x| ƒ(x) {|x,y| x + y}}
      => z[[1,2]]
        => 3

    pry(main)> ∀ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
      => false

    pry(main)> ∃ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
      => true

    pry(main)> ∃t [1,2,"cat",3], Fixnum
      => true

    pry(main)> class B; end;
    pry(main)> x = B.replicate(5)
      => [B, B, B, B, B]

    x = [1,2,3,4]
    pry(main)> [1,2,3,4].to_hash
      => {0=>1, 1=>2, 2=>3, 3=>4}

    x = [[1,2],[3,4]]
    pry(main)> [[1,2],[3,4]].to_hash
      => {1=>2, 3=>4}

    x = {"cat" => "dog", 1 => 2}
    pry(main)> x.to_a
      => [["cat", "dog"], [1, 2]]
