class NumberWrapper

  def initialize(number)
    @number = number
  end

  def do_stuff(var)
    NumberWrapper.new(var+10)
  end

  def coerce(other)
    [self, other]
  end

  def to_s
    "NumberWrapper(#{@number})"
  end

  def unwrap
    @number
  end

  def method_missing2(sym, *args, &block)
    puts "#{sym}, #{args}"

    args = args.map do |arg|
      if arg.respond_to? :unwrap
        arg.unwrap
      else
        arg
      end
    end

    var = @number.send(sym, *args, &block)
    NumberWrapper.new(var)
  end

end

foo = NumberWrapper.new(10)
foo2 = NumberWrapper.new(10)

puts "#{foo} #{foo2}"

bar = foo + foo2

puts "#{bar}"

