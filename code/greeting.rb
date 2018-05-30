def greeting
    greetingType = ARGV.shift
    ARGV.each do |name|
        puts "#{greetingType} #{name}!"
    end
end

greeting