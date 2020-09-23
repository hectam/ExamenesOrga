#include <easm_crt.h>

int sum(int arr[], int size);

int main()
{
    int arr[] = {10, 43, 41, 5, 45, 50, 22, 86, 10, 20, 55, 52, 65};
    int size = sizeof(arr)/sizeof(arr[0]);

    int s = sum(arr, size);
    print_str("The sum of squares is: ");
    print_int(s);
    print_char('\n');
    
    return 0;
}

int sum(int arr[], int size)
{
    int sum = 0;
    for (int i = 0; i < size; i++)
        sum += arr[i] * arr[i];
    
    return sum;
}
