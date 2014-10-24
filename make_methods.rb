class NumberWrapper

  def initialize(number)
    @number = number
  end

  def do_stuff(var)
    NumberWrapper.new(var+10)
  end

  def coerce(other)
    puts "coercing #{self} to #{other}"
    [self, other]
  end

  def to_s
    "NumberWrapper(#{@number})"
  end

  def unwrap
    @number
  end

  def method_missing(sym, *args, &block)
    puts "#{self} is missing method #{sym}. Args #{args}"

    args = args.map do |arg|
      (arg.respond_to? :unwrap) ? arg.unwrap : arg
    end

    var = @number.send(sym, *args, &block)
    NumberWrapper.new(var)
  end

end

foo = NumberWrapper.new(10)
foo2 = NumberWrapper.new(20)

puts "#{foo} #{foo2}"

bar = foo + foo2

puts "#{bar}"

bar1 = foo + 10
puts "#{bar1}"

puts '--------------------------'
bar2 = 15 + foo
puts "#{bar2}"
