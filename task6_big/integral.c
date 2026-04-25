#include <stdio.h>
#include <math.h>
#include <string.h>

extern double f1(double x); // f1 = 0.6 * x + 3
extern double f2(double x); // f2 = (x − 2) ^ 3 − 1
extern double f3(double x); // f3 = 3 / x

extern double df1(double x); // df1 = (f1)' = 0.6
extern double df2(double x); // df2 = (f2)' = 3 * (x - 2) ^ 2
extern double df3(double x); // df3 = (f3)' = -3 / (x ^ 2)

extern double g1(double x); //g1 = ln(x) - 15x^2 + 3.89

double g2(double x){ //g2 = 13x^3 - 12x^2 + 11x - 10
  return 13 * x * x * x - 12 * x * x + 11 * x - 10;
}

double g3(double x){ //g3 = 1/8x^2
  return 1 / (8 * x * x);
}

double dg1(double x){ //dg1 = 1 / x - 30x
  return 1 / x - 30 * x;
}

double dg2(double x){ //dg2 = 39x^2 - 24x + 11
  return 39 * x * x - 24 * x + 11;
}

double dg3(double x){ //dg3 = -1/4x^3
  return -1 / (4 * x * x * x);
}

static int iterations; // counter for iterations of actions to find the abscissa of the intersection point

double root(double f(double), double g(double), double df(double), double dg(double), double a, double b, double eps1){ // finding the root of the equation f(x) = g(x) for x ∈ [a;b] by using the hybrid method. Сalculation error < eps1
  iterations = 0;
  double delta_a = f(a) - g(a), delta_b = f(b) - g(b);
  double delta_db = df(b) - dg(b);
  if (delta_a == 0){ // a is the abscissa of the point of intersection
    return a;
  }
  if (delta_b == 0){ // b is the abscissa of the point of intersection
    return b;
  }

  while (fabs(b - a) >= eps1){ //looking for the abscissa of the point of intersection
    a -= (delta_a * (b - a)) / (delta_b - delta_a);
    b -= delta_b / delta_db;
    delta_a = f(a) - g(a);
    delta_b = f(b) - g(b);
    delta_db = df(b) - dg(b);
    iterations++;
  }

  return a; // the value of abscissa of the point of intersection
}

double integral(double f(double), double a, double b, double eps2){ // finding the definite integral of the function f(x) for x ∈ [a;b] by using the Simpson's rule with Runge rule. Calculation error < eps2
  int n2 = 2; // beginning of the first step of the Runge rule
  double h = (b - a) / n2;
  double I_n = (h / 3) * (f(a) + f(b) + 4 * f((b + a) / 2)); 
  h /= 2; 
  n2 *= 2;
  double I_2n = (h / 3) * (f(a) + f(b) + 2 * f((b + a) / 2) + 4 * (f(a + (b - a) * 1 / n2) + f(a + (b - a) * 3 / n2))); // end of the first step of the Runge rule

  while (fabs(I_n - I_2n) >= 15 * eps2){ //cheking according to the Runge rule
    I_n = I_2n; // beginning of the next step of the Runge rule
    h /= 2;
    n2 *= 2;
    I_2n = f(a) + f(b);

    for(int i = 2; i < n2; i += 2){
      I_2n += 2 * f(a + (b - a) * i / n2);
      I_2n += 4 * f(a + (b - a) * (i - 1) / n2);
    }
    I_2n += 4 * f(a + (b - a) * (n2 - 1) / n2);
    I_2n *= (h / 3); // end of the next step of the Runge rule
  }

  return I_2n; // the value of integral
}

void help(void){
  printf("This program was created to calculate the area of a flat figure bounded by graphs of three equations:\n");
  printf("f1(x) = 0.6x + 3\n");
  printf("f2(x) = (x − 2) ^ 3 − 1\n");
  printf("f3(x) = 3/x, x > 0\n");
  printf("Next you can see all valid keys. Just type:\n");
  printf("--help or -h - to print info about the program\n");
  printf("--root or -r - to print all abscissae of points of intersections of curves\n");
  printf("--iterations or -i - to print the number of iterations required to approximate the solution of the equations when searching for intersection points\n");
  printf("--test-root or -R with F1:F2:A:B:E:R - to test the root function. Remember that:\n");
  printf("F1, F2 - numbers of functions (F1 != F2)\n");
  printf("Functions, available for test:\n");
  printf("1 - g(x) = ln(x) - 15x^2 + 3.89; 2 - g(x) = 13x^3 - 12x^2 + 11x - 10; 3 - g(x) = 1/8x^2\n");
  printf("A, B - boundary points (0 < A <= B)\n");
  printf("E - epsilon\n");
  printf("R - correct answer (A <= R <= B)\n");
  printf("--test-integral or -I with F:A:B:E:R - to test the integral function. Remember that:\n");
  printf("F - number of function\n");
  printf("Functions, available for test:\n");
  printf("1 - g(x) = ln(x) - 15x^2 + 3.89; 2 - g(x) = 13x^3 - 12x^2 + 11x - 10; 3 - g(x) = 1/8x^2\n");
  printf("A, B - boundary points (A, B > 0)\n");
  printf("E - epsilon\n");
  printf("R - correct answer\n");
}

int main(int argc, char **argv){
  double a12 = 2.5, a13 = 0.5, a23 = 2.5, b12 = 4.0, b13 = 2.5, b23 = 4.0, eps1 = 0.00001, eps2 = 0.00001;
  double x12 = root(f1, f2, df1, df2, a12, b12, eps1);
  double x13 = root(f1, f3, df1, df3, b13, a13, eps1);
  double x23 = root(f2, f3, df2, df3, a23, b23, eps1);
  double s1, s2, s3, s;

  switch (argc){
    case (1): //There is one input parameters so the program starts to print the answer (area of a figure)
      s1 = integral(f1, x13, x12, eps2);
      s2 = integral(f2, x23, x12, eps2);
      s3 = integral(f3, x13, x23, eps2);
      s = s1 - s2 - s3;
      printf("Area of the figure = %lf\n", s);
      break;
    case (2): //There are two https://github.com/ovladisluvv/NASM-prac-2-2024.gitinput parameter so the program starts to print the help or all abscissae of points of intersection or number of iterations
      if (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0){ //printing the help
        help();
      }
      else if (strcmp(argv[1], "--root") == 0 || strcmp(argv[1], "-r") == 0){ //printing the all abscissae of points of intersection
        printf("0.6x + 3 - ((x - 2) ^ 3 - 1) = 0 - x = %lf\n", x12);
        printf("0.6x + 3 - (3 / x) = 0 - x = %lf\n", x13);
        printf("(x - 2) ^ 3 - 1 - (3 / x) = 0 - x = %lf\n", x23);
      }
      else if (strcmp(argv[1], "--iterations") == 0 || strcmp(argv[1], "-i") == 0){ //printing number of iterations
        x12 = root(f1, f2, df1, df2, a12, b12, eps1);
        printf("0.6x + 3 - ((x - 2) ^ 3 - 1) = 0 - iterations = %d\n", iterations);
        x13 = root(f1, f3, df1, df3, b13, a13, eps1);
        printf("0.6x + 3 - (3 / x) = 0 - iterations = %d\n", iterations);
        x23 = root(f2, f3, df2, df3, a23, b23, eps1);
        printf("(x - 2) ^ 3 - 1 - (3 / x) = 0 - iterations = %d\n", iterations);
      }
      else {
        printf("Error - invalid input\n type --help or -h to get info about the program\n");
      }
      break;
    case (3): //There are three input parameters so the program starts to test functions
      if (strcmp(argv[1], "--test-root") == 0 || strcmp(argv[1], "-R") == 0){ //testing the root function
        int F1, F2;
        double A, B, E, R, test_x, absolute_error, relative_error;
        double (*test_func_1)(double), (*test_func_2)(double), (*dtest_func_1)(double), (*dtest_func_2)(double);
        if (sscanf(argv[2], "%d:%d:%lf:%lf:%lf:%lf", &F1, &F2, &A, &B, &E, &R) == 6){
          switch(F1){ //initializing of first test functions
            case (1):
              test_func_1 = g1;
              dtest_func_1 = dg1;
              break;
            case (2):
              test_func_1 = g2;
              dtest_func_1 = dg2;
              break;
            case (3):
              test_func_1 = g3;
              dtest_func_1 = dg3;
              break;
            default:
              printf("Error - invalid input\n type --help or -h to get info about the program\n");
              return 0;
          }
          switch(F2){ //initializing of second test functions
            case (1):
              test_func_2 = g1;
              dtest_func_2 = dg1;
              break;
            case (2):
              test_func_2 = g2;
              dtest_func_2 = dg2;
              break;
            case (3):
              test_func_2 = g3;
              dtest_func_2 = dg3;
              break;
            default:
              printf("Error - invalid input\n type --help or -h to get info about the program\n");
              return 0;
          }
          if (F1 == F2){ //error if there are two identical functions
            printf("Error - invalid input\n type --help or -h to get info about the program\n");
            break;
          }
          if ((test_func_1(A) - test_func_2(A)) * (test_func_1(B) - test_func_2(B)) > 0){
            printf("Error - violation of the method application conditions\n type --help or -h to get info about the program\n");
            break;
          }
          if (A > B){
            printf("Error - left boundary is greater than right boundary\n type --help or -h to get info about the program\n");
            break;
          }
          if (A < 1e-10){
            printf("Error - left boundary value isn't positive\n type --help or -h to get info about the program\n");
            break;
          }
          if (A > R || B < R){
            printf("Error - the desired answer is not on the written segment\n type --help or -h to get info about the program\n");
            break;
          }
          test_x = (F1 + F2 == 4) ? root(test_func_1, test_func_2, dtest_func_1, dtest_func_2, B, A, E) : root(test_func_1, test_func_2, dtest_func_1, dtest_func_2, A, B, E); // if F1 == 1 and F2 == 3 or reverse, then we look for x by swapping the boundaries of a and b. That was done for the correct working of the program (due to the jokes with monotony of functions)
          absolute_error = fabs(test_x - R);
          relative_error = fabs(absolute_error / R);
          printf("%lf %lf %lf\n", test_x, absolute_error, relative_error);
        }
        else {
          printf("Error - invalid input\n type --help or -h to get info about the program\n");
        }
      }
      else if (strcmp(argv[1], "--test-integral") == 0 || strcmp(argv[1], "-I") == 0){ //testing the integral function
        int F;
        double A, B, E, R, test_x, absolute_error, relative_error;
        double (*test_func)(double);
        if (sscanf(argv[2], "%d:%lf:%lf:%lf:%lf", &F, &A, &B, &E, &R) == 5){
          switch (F){ // initializing of the test function
            case 1:
              test_func = g1;
              break;
            case 2:
              test_func = g2;
              break;
            case 3:
              test_func = g3;
              break;
            default:
              printf("Error - invalid input\n type --help or -h to get info about the program\n");
              return 0;
          }
          if (A < 1e-10){
            printf("Error - left boundary value isn't positive\n type --help or -h to get info about the program\n");
            break;
          }
          test_x = integral(test_func, A, B, E);
          absolute_error = fabs(test_x - R);
          relative_error = fabs(absolute_error / R);
          printf("%lf %lf %lf\n", test_x, absolute_error, relative_error);
        }
        else {
          printf("Error - invalid input\n type --help or -h to get info about the program\n");
        }
      }
      else {
        printf("Error - invalid input\n type --help or -h to get info about the program\n");
      }
      break;
    default: //invalid input 
      printf("Error - invalid input\n type --help or -h to get info about the program\n");
  }

  return 0;
}
