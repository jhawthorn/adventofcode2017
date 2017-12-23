require 'prime'
p (106700..123700).step(17).count{|x|!x.prime?}
