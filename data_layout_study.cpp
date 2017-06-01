#include <cstdint>
#include <iostream>

using std::cout;

struct EightBools
{
  bool one;
  bool two;
  bool three;
  bool four;
  bool five;
  bool six;
  bool seven;
  bool eight;
};

struct DanglingEnd
{
  uint32_t first;
  uint8_t end;
};
struct Sandwich
{
  uint32_t first;
  uint8_t middle;
  uint32_t end;
};

int main()
{
  cout << "data layout study start" << '\n';
  cout << "size of eight bools = " << sizeof(EightBools) << '\n'; 
  cout << "size of dangling end = " << sizeof(DanglingEnd) << '\n'; 
  cout << "size of sandwich= " << sizeof(Sandwich) << '\n'; 
  cout << "data layout study end" << '\n';
  return EXIT_SUCCESS;
}

