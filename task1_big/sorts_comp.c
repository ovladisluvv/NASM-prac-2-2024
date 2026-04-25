#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

static int bubble_comp_count, bubble_swap_count, quick_comp_count, quick_swap_count; //counters for compares and swaps of sorting methods

static int cmp(const void *n1, const void *n2){ //function for comparing two numbers. returned value is positive if abs(n1) > abs(n2), equals to zero if abs(n1) = abs(n2) and is negative if abs(n1) < abs(n2)
  double eps = 1e-10;
  if (fabs(*(double *)n1 - *(double *)n2) < eps){
    return 0;
  }
  return fabs(*(double *)n1) - fabs(*(double *)n2) < 0 ? -1 : 1;
}

static int anticmp(const void *n1, const void *n2){ //function for comparing two numbers. returned value is positive if abs(n1) < abs(n2), equals to zero if abs(n1) = abs(n2) and is negative if abs(n1) > abs(n2)
  double eps = 1e-10;
  if (fabs(*(double *)n1 - *(double *)n2) < eps){
    return 0;
  }
  return fabs(*(double *)n2) - fabs(*(double *)n1) < 0 ? -1 : 1;
}

static int is_sorted_cmp(const void *n1, const void *n2){ //function for comparing two numbers. returned value is positive if n1 > n2, equals to zero if n1 = n2 and is negative if n1 < n2
  double eps = 1e-10;
  if (fabs(*(double *)n1 - *(double *)n2) < eps){
    return 0;
  }
  return *(double *)n1 - *(double *)n2 < 0 ? -1 : 1;
}

static void create_random(double *arr, int len){ //procedure for creating an array with random numbers
  srand(time(NULL) + rand()); //full randomizing of the numbers
  for (int i = 0; i < len; i++){
    arr[i] = ((double)rand() / (double)RAND_MAX * RAND_MAX) * (rand() % 2 ? 1 : -1); //generating random number in range [-RAND_MAX;RAND_MAX]. left side of multiplication stands for the absolute value of number [0;RAND_MAX] and right side of multiplication stands for the sign of number (+/-)
  }
}

static void create_order(double *arr, int len){ //procedure for creating an array that is sorted in non-decreasing order
  create_random(arr, len); //creating a random array in address of a
  qsort(arr, len, sizeof(double), cmp); //sorting of the array in direct order
}


static void create_reverse(double *arr, int len){ //procedure for creating an array that is sorted in non-increasing order
  create_random(arr, len); //creating a random array in address of a
  qsort(arr, len, sizeof(double), anticmp); //sorting of the array in reverse order
}

static void arrcpy(double *src, double *dest, int len){ //procedure for copying one array into another
  for (int i = 0; i < len; i++){
    dest[i] = src[i];
  }
}

static void bubblesort(double *arr, int len){ //procedure for bubble sort
  int i, j;
  double temp;
  for (i = 0; i < len - 1; i++){ //the outer loop runs from 0 to n - 1, iterating through each element of the array
    for (j = len - 1; j > i; j--){ //the inner loop that starts from the last element of the array and goes backwards towards i
      bubble_comp_count++;
      if (fabs(arr[j - 1]) > fabs(arr[j])){ //swapping elements if they are in the wrong order
        bubble_swap_count++;
        temp = arr[j - 1];
        arr[j - 1] = arr[j];
        arr[j] = temp;
      }
    }
  }
}

static void sort(double *arr, int left, int right){ //recursive procedure for quicksort
  int i = left, j = right;
  double pivot, temp;
  pivot = fabs(arr[(left + right) / 2]); //choosing pivot element
  do {
    quick_comp_count++;
    while (fabs(arr[i]) < pivot){ //looking for the first element in left subarray that need to be swapped
      quick_comp_count++;
      i++;
    }
    quick_comp_count++;
    while (pivot < fabs(arr[j])){ //looking for the first element in right subarray that need to be swapped
      quick_comp_count++;
      j--;
    }
    if (i <= j){ //swapping elements a[i] and a[j] based on their values in comparison to the pivot element
      if (i != j){
        quick_swap_count++;
      }
      temp = arr[i];
      arr[i] = arr[j];
      arr[j] = temp;
      i++;
      j--;
    }
  } while (i < j);
  if (left < j){ //repeat the procedure if we didn't reach the beginning of the array [sorting of subarray]
    sort(arr, left, j);
  }
  if (i < right){ //repeat the procedure if we didn't reach the end of the array [sorting of subarray]
    sort(arr, i, right);
  }
}

static void quicksort(double *arr, int len){ //supportive procedure for starting quicksort algorithm
  sort(arr, 0, len - 1); //choosing left border as 0 and right border as n - 1
}

static void is_sorted(double *arr_to_check, double *orig_arr, int len){ //procedure for checking the correctness of the sorting
  double *ref_arr_sorted = malloc(len * sizeof(double));
  arrcpy(orig_arr, ref_arr_sorted, len);
  qsort(ref_arr_sorted, len, sizeof(double), cmp); //sorting of the refference array "ref_arr_sorted". it will be used as the basis of checking

  double *ref_arr_elem = malloc(len * sizeof(double));
  arrcpy(orig_arr, ref_arr_elem, len);
  qsort(ref_arr_elem, len, sizeof(double), is_sorted_cmp); //sorting of the refference array "ref_arr_elem". it will be used as the basis of checking

  double *arr_to_check_sorted = malloc(len * sizeof(double));
  arrcpy(arr_to_check, arr_to_check_sorted, len);
  qsort(arr_to_check_sorted, len, sizeof(double), cmp); //sorting of the checking array "arr_to_check_sorted"

  double *arr_to_check_elem = malloc(len * sizeof(double));
  arrcpy(arr_to_check, arr_to_check_elem, len);
  qsort(arr_to_check_elem, len, sizeof(double), is_sorted_cmp); //sorting of the refference array "arr_to_check_elem"

  char flag = 1; //is_sorted flag. 1 - sorted, 0 - not sorted

  for (int i = 0; i < len; i++){
    if (arr_to_check_elem[i] != ref_arr_elem[i]){ //dropping the flag as soon as we come across an discrepancy
      flag = 0;
      break;
    }
  }

  free(arr_to_check_elem);
  free(ref_arr_elem);

  if (flag){
    for (int i = 0; i < len; i++){
      if (fabs(arr_to_check_sorted[i]) != fabs(ref_arr_sorted[i])){ //dropping the flag as soon as we come across an discrepancy
        flag = 0;
        break;
      }
    }
  }

  free(arr_to_check_sorted);
  free(ref_arr_sorted);

  if (flag){
    printf("Массив успешно отсортирован\n");
  }
  else {
    printf("Ошибка сортировки массива\n");
  }
}

int main(void){
  int n;
  if (!scanf("%d", &n) || n < 1){ //reading the length of the source array
    printf("Ошибка чтения длины массива!\n");
    return -1;
  }

  double **arr = malloc(4 * sizeof(double *)); //creating an "array of arrays" for more comfort
  double **arr_bubble = malloc(4 * sizeof(double *)); //"array of arrays" for bubble sort 
  double **arr_quick = malloc(4 * sizeof(double *)); //"array of arrays" for quicksort

  printf("Длина массива - %d\n", n);

  for (int i = 0; i < 4; i++){
    bubble_comp_count = bubble_swap_count = quick_comp_count = quick_swap_count = 0;
    arr[i] = malloc(n * sizeof(double)); //the source array
    arr_bubble[i] = malloc(n * sizeof(double)); //bubble sorted array
    arr_quick[i] = malloc(n * sizeof(double)); //quicksorted array

    printf("\nМассив %d - элементы ", i + 1);
    switch(i){ //switch for types of array due to the task conditions
      case 0:
        printf("упорядочены в прямом порядке\n");
        create_order(arr[i], n);
        break;
      case 1:
        printf("упорядочены в обратном порядке\n");
        create_reverse(arr[i], n);
        break;
      default:
        printf("расставлены случайно\n");
        create_random(arr[i], n);
    }

    arrcpy(arr[i], arr_bubble[i], n); //copying of the source array for bubblesort
    arrcpy(arr[i], arr_quick[i], n); //copying of the source array for quicksort

    bubblesort(arr_bubble[i], n);
    quicksort(arr_quick[i], n);

    printf("Bubblesort:\n");
    is_sorted(arr_bubble[i], arr[i], n);
    printf("Количество сравнений: %d\n", bubble_comp_count);
    printf("Количество перемещений: %d\n", bubble_swap_count);

    printf("Quicksort:\n");
    is_sorted(arr_quick[i], arr[i], n);
    printf("Количество сравнений: %d\n", quick_comp_count);
    printf("Количество перемещений: %d\n", quick_swap_count);

    free(arr[i]);
    free(arr_bubble[i]);
    free(arr_quick[i]);
  }

  free(arr);
  free(arr_bubble);
  free(arr_quick);

  return 0;
}
