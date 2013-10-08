### Introduction

### Usage

    class B; end;
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
