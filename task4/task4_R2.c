#include <stdio.h>

int main(void){
  int n1, n2, ans = 0;
  char symb;
  
  scanf("%d", &n1);
  scanf("%c", &symb);
  scanf("%d", &n2);
  
  symb -= 42;

  switch(symb){
    case 0:
      ans = n1 * n2;
      break;
    case 1:
      ans = n1 + n2;
      break;
    case 3:
      ans = n1 - n2;
      break;
    case 5:
      ans = n1 / n2;
      break;
    default:
      break;
  }

  printf("%d", ans);
  
  return 0;
}
