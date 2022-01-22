=begin

 ndefined8 main(void)

{
  char acStack1080 [512];
  char local_238 [512];
  undefined8 local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined4 local_20;
  undefined2 local_1c;
  int local_18;
  char local_11;
  int local_10;
  int local_c;
  
  local_38 = 0x4164485d5549525a;
  local_30 = 0x41494447414a644e;
  local_28 = 0x4173444476414978;
  local_20 = 0x71444479;
  local_1c = 0x5f;
  local_c = 0;
  local_10 = 0;
  puts("-------------------------------------");
  puts("\tKnight Switch Bank");
  puts("--------------------------------------");
  puts("Welcome to Knight Switch Bank....");
  printf("Please enter your password : ");
  __isoc99_scanf(&DAT_00402130,local_238);
  for (; local_238[local_c] != '\0'; local_c = local_c + 1) {
    if ((local_238[local_c] < 'A') || ('M' < local_238[local_c])) {
      if ((local_238[local_c] < 'a') || ('m' < local_238[local_c])) {
        if ((local_238[local_c] < 'N') || ('Z' < local_238[local_c])) {
          if ((local_238[local_c] < 'n') || ('z' < local_238[local_c])) {
            acStack1080[local_c] = local_238[local_c] + -0x20;
          }
          else {
            acStack1080[local_c] = local_238[local_c] + -0xd;
          }
        }
        else {
          acStack1080[local_c] = local_238[local_c] + -0xd;
        }
      }
      else {
        acStack1080[local_c] = local_238[local_c] + '\r';
      }
    }
    else {
      acStack1080[local_c] = local_238[local_c] + '\r';
    }
  }
  for (; acStack1080[local_10] != '\0'; local_10 = local_10 + 1) {
    acStack1080[local_10] = acStack1080[local_10] + '\x02';
  }
  local_11 = '\0';
  local_18 = 0;
  do {
    if (*(char *)((long)&local_38 + (long)local_18) == '\0') {
LAB_00401437:
      if (local_11 == '\0') {
        puts("Oh My God ! You entered a wrong password.");
      }
      else {
        winner();
      }
      return 0;
    }
    if (*(char *)((long)&local_38 + (long)local_18) != acStack1080[local_18]) {
      local_11 = '\0';
      goto LAB_00401437;
    }
    local_11 = '\x01';
    local_18 = local_18 + 1;
  } while( true );
}
=end

text0 = [0x41,0x64,0x48,0x5d,0x55,0x49,0x52,0x5a].reverse
text1 = [0x41,0x49,0x44,0x47,0x41,0x4a,0x64,0x4e].reverse
text2 = [0x41,0x73,0x44,0x44,0x76,0x41,0x49,0x78].reverse
text3 = [0x71,0x44,0x44,0x79].reverse

flag = []

4.times do |i|
    tmp_flag = []
    eval("text#{i}").map.with_index do |byte, j|
        algo_operation1 = ((byte-0x2)-13)
        algo_operation2 = ((byte-0x2)+0xd)
        algo_operation3 = ((byte-0x2)+0x20)
        if (algo_operation1 >= 'A'.ord && algo_operation1 <= 'M'.ord) ||(algo_operation1 >= 'a'.ord && algo_operation1 <= 'm'.ord)
            tmp_flag[j] = algo_operation1.chr
        elsif (algo_operation2 >= 'N'.ord && algo_operation2 <= 'Z'.ord) || (algo_operation2 >= 'n'.ord && algo_operation2 <= 'z'.ord)
            tmp_flag[j] = algo_operation2.chr
        else
            tmp_flag[j] = algo_operation3.chr
        end
    end
    flag[i] = tmp_flag.join()
end

flag = flag.join('')

puts "Flag found => #{flag}}"

