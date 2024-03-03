#include <stdio.h>
#include <math.h>
#include "../Codes.h/addition.h"
#include "../Codes.h/subtraction.h"

int main() {
    char operator;
    float num1, num2;
    double result;

    printf("Enter operator (+, -, *, /, %%):\n");
    scanf("%c", &operator);

    printf("Enter two numbers:\n");
    scanf("%f %f", &num1, &num2);

    switch(operator) {
        case '+':
           result = add(num1,num2);
            break;
        case '-':
            result = sub(num1,num2);
            break;
        case '*':
            // Implement Code Please <3
            break;
        case '/':
            // Implement Code Please <3
            break;
        case '%':
            // Implement Code Please <3
        default:
            printf("Error! Invalid operator.\n");
            return 1; 
    }

    printf("Result: %.2lf\n", result);
    
    return 0;
}
