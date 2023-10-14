#include <iostream>
#include <cmath>
#include <map>

struct CWFPU {
    bool UP = false;
    bool UE = false;
    // ... др регистры состояний 
};

double fpu87(float value, std::map<int, float> mode) {
    float AL = mode[1];
    AL = AL || 1;
    mode[1] = AL;

    float ST0 = value;
    ST0 = std::ceil(value);

    value = ST0;
    float RAX = value;

    mode[1] = 0;
    RAX = 0;

    return value;
}

double sse(float value, std::map<int, float> mode) {
    // ...
    return value;
}

int main() {
    float value = 2.2;
    std::map<int, float> mode;
    mode[0] = 0, mode[1] = 0; mode[2] = 0, mode[3] = 0; // 4 байт

    std::cout << fpu87(value, mode);
    std::cout << sse(value, mode);
    return 0;
}
