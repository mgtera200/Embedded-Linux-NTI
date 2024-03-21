#include <stdio.h>
int binary_search(int * ptr,int size,int key){
int left =0;
int right = size -1 ;
int mid =0;
while(left <= right)
{
mid = left + (right-left)/2;

if(ptr[mid] == key)
{
return mid;

}
else if(key < ptr[mid])
{
right = mid-1;
}

else if(key > ptr[mid])
{
left = mid+1;
}

return -1;


}

}


int main(){
int arr[] = {10,20,30,50,60};
int key = 40;
int result = binary_search(arr,5,key);
printf("Index of the key is %d",result);



}
