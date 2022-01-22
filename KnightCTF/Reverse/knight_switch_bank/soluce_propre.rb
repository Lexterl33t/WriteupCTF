def step2(byte)
    return byte-0x2
end

def algo_range_a_m(byte)
    return (step2(byte)-13)
end

def algo_range_n_z(byte)
    return (step2(byte)+0xd)
end


def step1(byte)
    algo_operation1 = algo_range_a_m(byte)
    algo_operation2 = algo_range_n_z(byte)
    algo_operation3 = (step2(byte)+0x20)

    if (algo_operation1 >= 'A'.ord && algo_operation1 <= 'M'.ord) ||(algo_operation1 >= 'a'.ord && algo_operation1 <= 'm'.ord)
        return algo_operation1.chr
    elsif (algo_operation2 >= 'N'.ord && algo_operation2 <= 'Z'.ord) || (algo_operation2 >= 'n'.ord && algo_operation2 <= 'z'.ord)
        return algo_operation2.chr
    else
        return algo_operation3.chr
    end
end

def main()
    text0 = [0x41,0x64,0x48,0x5d,0x55,0x49,0x52,0x5a].reverse
    text1 = [0x41,0x49,0x44,0x47,0x41,0x4a,0x64,0x4e].reverse
    text2 = [0x41,0x73,0x44,0x44,0x76,0x41,0x49,0x78].reverse
    text3 = [0x71,0x44,0x44,0x79].reverse

    flag = []
    4.times do |i|
        tmp_flag = []

        eval("text#{i}").map.with_index do |byte, j|
            tmp_flag[j] = step1(byte)
        end

        flag[i] = tmp_flag
    end

    puts "Flag: #{flag.join}}"
end

if __FILE__ == $0
    main()
end