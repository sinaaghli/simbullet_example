#include <simbullet/simbullet.h>

int main(int argc, char *argv[]){
    simbullet a;
    a.cnt = 2;
    int b = a.dosth(a.cnt);
    a.run_example();
    return b;
}
