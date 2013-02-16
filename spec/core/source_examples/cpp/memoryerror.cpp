#include <iostream>

using namespace std;

struct LinkedElements {
    int v;
    LinkedElements* next;
} *start;

int main() {
    start = new LinkedElements();
    start->v = 0;

    while (true) {
        start->next = new LinkedElements();
        start->next->v = start->v + 1;
        start = start->next;
    }
    return 0;
}