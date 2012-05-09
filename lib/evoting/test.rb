path = "/home/abid/Projects/evoting/"
require "#{path}voting.rb"

voting = Voting.new
votes = []

votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(-1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(-1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(-1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(-1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(1)
votes<<voting.encrypt_vote(-1)
votes<<voting.encrypt_vote(1)

kanj = voting.calculate_results(votes)

puts "kanj is #{kanj}"

#m1 = voting.scheme.encrypt(365484)
#m2 = voting.scheme.encrypt(365484)
#m3 = voting.scheme.encrypt(7109)
#m4 = voting.scheme.encrypt(7109)
#m5 = voting.scheme.encrypt(7109)
#m6 = voting.scheme.encrypt(365484)
#m7 = voting.scheme.encrypt(365484)
#m8 = voting.scheme.encrypt(365484)
#m9 = voting.scheme.encrypt(365484)
#mu = voting.scheme.encrypt(365484)
#mi = voting.scheme.encrypt(365484)
#mr = voting.scheme.encrypt(162113)

#kanj = voting.calculate_results([m1,m2,m3,m4,m5,m6,m7,m8,m9,mu,mi,mr])






#ev1 = voting.encrypt_vote(1)
#ev2 = voting.encrypt_vote(1)
#
#vts = [ev1, ev2]
#voting.calculate_results(vts)

#voting.possible_outcomes

#(1..10).each do |i|
#  r = [1,1].sample
#  puts "vote casted for #{r}"
#  votes<<voting.encrypt_vote(r)
#end
#
#votes.each do |v|
#  puts "a = #{v.a}"
#  puts "b = #{v.b}"
#
#  r = voting.scheme.decrypt(v)
#  puts "caste vote was #{r}"
#end

#result = voting.calculate_results(votes)

#puts result



#p = CryptoHelper::create_random_prime(21)

#puts "Prime p = #{p}"
#x = 123456789876543234567876543456789
#g = CryptoHelper::get_generator(p)
#puts "Generator g = #{g}"
#
#
#elgamal = Elgamal.new(p,g,x)
#
#puts "Elgamal Created #{elgamal.inspect}"
#
#m = elgamal.encrypt(-11234)
#
#puts "Encrypted messgage a = #{em.a}, b = #{em.b}"
#
#m = elgamal.decrypt(em)
#
#puts "Decrypted message #{m}"
