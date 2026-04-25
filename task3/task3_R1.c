#include <stdio.h>

int main(void){
  int n;
  scanf("%d", &n);
  unsigned ans = 0;
  unsigned temp = 1;
  unsigned loop_temp;

  for (int i = n; i > 0; i--){
    loop_temp = ans;
    ans = temp;
    temp = loop_temp;
    temp += ans;
  }

  printf("%u\n", ans);
  return 0;
}
