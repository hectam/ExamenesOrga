void quicksort(int number[], int first, int last)
{
   if (first < last) {
        int pivot = first;
        int i = first;
        int j = last;

        while (i<j) {
            while (number[i] <= number[pivot] && i < last)
                i++;
            while(number[j]>number[pivot])
                j--;
            
            if (i<j) {
                int temp = number[i];
                number[i] = number[j];
                number[j] = temp;
            }
        }

        int temp = number[pivot];
        number[pivot] = number[j];
        number[j] = temp;
        quicksort(number, first, j-1);
        quicksort(number, j+1, last);
   }
}
