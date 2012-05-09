class Elgamal
  attr_accessor :p, :g, :x, :h

  def initialize(_p, _g, _x)
    @p = _p
    @g = _g
    @x = _x
    @h = CryptoHelper::mod_pow(@g,@x,@p)
    puts "create elgamal with "
    puts "p: #{@p}"
    puts "g: #{@g}"
    puts "x: #{@x}"
    puts "h: #{@h}"
  end

  def encrypt(m)
    w = CryptoHelper::rand_num(@p - 3) + 1
    puts "w : #{w}"
    a = CryptoHelper::mod_pow(@g,w,@p)
    puts "g^w = #{a}"
    kk =CryptoHelper::mod_pow(@h,w,@p)
    puts "a_x = (g^w^x) = #{kk}" 
    b = CryptoHelper::mul_mod(kk, m,@p)
    puts "h^w*m = (g^x^w)*m#{b}"
    #b = CryptoHelper::mod_pow(@h,w,@p)* m
    puts "A= #{a}, B = #{b}"
    EncryptedMessage.new(a,b)
  end

  def decrypt(m)
    puts "decrypting message #{m.inspect}"
    puts "g^w = #{m.a}"
    puts "h^w*m = (g^x^w)*m#{m.b}"
    a_x = CryptoHelper::mod_pow(m.a, -@x, @p)
    puts "a_x = (g^w^x) = #{a_x}" 
    m = CryptoHelper::mul_mod(a_x, m.b, @p)
    m
  end

end
