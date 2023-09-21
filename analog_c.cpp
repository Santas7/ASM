#include <iostream>
#include <vector>

int main() {
    std::cout << "Start program.." << std::endl;
    
    int array_len;
    std::cout << "Array length: ";
    std::cin >> array_len;

    // заполнение массива
    std::vector<int> array(array_len);
    std::cout << "Array fill:";
    for (size_t i = 0; i < array_len; ++i) 
        std::cin >> array[i];

    // сортировка пузырьком
    int n = array.size();
    bool swapped;
    do {
        swapped = false;
        for (size_t i = 0; i < n - 1; ++i) {
            if (array[i] > array[i + 1]) {
                std::swap(array[i], array[i + 1]);
                swapped = true;
            }
        }
    } while (swapped);
    
    // вывод отсортированного массива данных
    std::cout << "Sorted array:";
    for (int i = 0; i < n; ++i) 
        std::cout << array[i] << ", ";

    std::cout << std::endl << "Program end.." << std::endl;
    return 0;
}
