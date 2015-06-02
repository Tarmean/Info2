include<stdlib.h>
int main()
{
    int **matrix;
    matrix=malloc(3*sizeof(int*));
    if(matrix!=NULL){
        for(int i=0;i<3;i++){
            matrix[i]=malloc(3*sizeof(int));
        }
        /*ausgelassen:UeberprufungundetwasmitderMatrixtun*/
    }
    for(int i=0;i<3;i++){
        free(matrix[i]);
    }
    free(matrix);
}
