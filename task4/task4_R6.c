#include <stdio.h>

int f(unsigned number, int *binary_form){
  static int ind = 0, current_bit = 0, count = 0, n = 32;
  if (n == 0){
    binary_form[ind] = current_bit;
    return 0;
  }
  else {
    binary_form[ind++] = current_bit;
    current_bit = number & 1;
    number >>= 1;
    n--;
    count = f(number, binary_form);
    count++;
    count -= binary_form[ind--];
  }
  return count;
}

int main(void){
  unsigned number;
  scanf("%u", &number);
  int binary_form[33];
  int ans = f(number, binary_form);
  printf("%d\n", ans);// ans - count of "0" in the 32-bit form of the binary number
  return 0;
}
