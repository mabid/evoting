require 'prime'
class CryptoHelper

class Integer 

  def prime?
  n = self.abs()
  return true if n == 2
  return false if n == 1 || n & 1 == 0
  return false if n > 3 && n % 6 != 1 && n % 6 != 5     # added
  d = n-1
  d >>= 1 while d & 1 == 0
  20.times do                               # 20 = k from above
  a = rand(n-2) + 1
  t = d
  y = mod_pow(a,t,n)                  # implemented below
  while t != n-1 && y != 1 && y != n-1
  y = (y * y) % n
  t <<= 1
  end
  return false if y != n-1 && t & 1 == 0
  end
  return true
  end
  end

  def self.mod(a,b)
    (a%b+b)%b
  end

  def self.mod_pow(base, power, mod)
    if(power < 0)
      power = mod-1+power
    end
    puts "mod pow called with #{base}, #{power}, #{mod}"
    result = 1
    while power > 0
      result = mod((result * base) , mod) if power & 1 == 1
      base = mod((base * base) , mod)
      power >>= 1;
    end
    result
  end

  def self.rand_num(q)
    rand(q)
  end

 def self.gcd(a,b)
   return [0,1] if mod(a , b) == 0
   x,y = gcd(b, mod(a , b))
   [y, x-(y*(a/b))]
 end


  def self.mul_mod(a,b,p)
    c = a*b
    puts "result of multi(#{a},#{b}) #{c}"
    mod(c,p)
  end

  def self.mod_inverse(a,p)
    x,y = gcd(a,p)
    puts "extended gcd for #{a}, #{p} is #{x}, #{y}"
    x 
  end

  def self.create_random_bignum(bits)
    middle = (1..bits-3).map{rand()>0.5 ? '1':'0'}.join
    str = "11" + middle + "1"
    str.to_i(2)
  end

  def self.create_random_prime(bits)
    while true
      val = create_random_bignum(bits)
      return val if val.prime?
    end
  end

  def self.get_factors(n)
    puts "getting factors"
    seq = []
    p = Prime.new
    t = p.next
    while(t<=n)
      if(mod(n,t) == 0)
        seq << t
        seq << (n/t)
      end 
      t = p.next
    end
    seq
  end

  def self.get_generator(p)
    factors = self.get_factors(p-1)
    puts factors.inspect + "000000000000"
    puts "got factors"
    while true
      notfound = false
      g = rand(p-1)
      puts "trying with #{g}"
      factors.each do |f|
        if self.mod_pow(g,f,p) == 1
          notfound = true
          break
        end
      end
      return g unless notfound
    end
  end

end
