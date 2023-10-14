#include <iostream>
#include <cmath>

double seq(float a, float b, float x) {
    /* 
        log2(tg(x+a)) = b
        tg(x+a) = 2^b
        x = arctan(8) − 1.0
    */ 
    float ST0 = 2.0;
    for (size_t i = 1; i < b; i++)
        ST0 *= 2.0;
    float ST1 = ST0;
    ST1 = atan(ST0);
    ST0 = a;
    ST0 = ST1 - ST0;
    x = ST0;
    return x;
}

int main() {
    std::cout << seq(1.0, 3.0, 0.0);
    return 0;
}
