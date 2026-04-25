#include <stdio.h>

int main(void){
  int n, k;
  int a[21] = {1}, b[21] = {1};
  int i, j, ans;

  scanf("%d", &n);
  scanf("%d", &k);

  for (i = 1; i <= n; i++){
    for (j = 1; j <= i; j++){
      if (i % 2 == 1){
        b[j] = a[j] + a[j - 1];
      }
      else {
        a[j] = b[j] + b[j - 1];
      }
    }
    

    if (i % 2 == 1){
      b[i] = 1;
    }
    else {
      a[i] = 1;
    }
  }

  if (i % 2 == 1){
    ans = a[k];
  }
  else {
    ans = b[k];
  }
  printf("%d\n", ans);

  return 0;
}
