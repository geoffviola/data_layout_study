#include <cstdint>
#include <iostream>

using std::cout;

#if defined(__llvm__) || defined(__GNUC__)
#define PACK( __Declaration__ ) __Declaration__ __attribute__((__packed__))
#else
#define PACK( __Declaration__ ) __pragma( pack(push, 1) ) __Declaration__ __pragma( pack(pop) )
#endif

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


PACK(
struct EightBoolsPacked
{
  bool one;
  bool two;
  bool three;
  bool four;
  bool five;
  bool six;
  bool seven;
  bool eight;
});

PACK(
struct DanglingEndPacked
{
  uint32_t first;
  uint8_t end;
});

PACK(
struct SandwichPacked
{
  uint32_t first;
  uint8_t middle;
  uint32_t end;
});

static bool is_little_endian()
{
  uint16_t one = 1;
  return 1U == *reinterpret_cast<uint8_t*>(&one);
}

int main()
{
  cout << "data layout study start" << '\n';
  cout << "unpacked" << '\n';
  cout << "size of eight bools = " << sizeof(EightBools) << '\n'; 
  cout << "size of dangling end = " << sizeof(DanglingEnd) << '\n'; 
  cout << "size of sandwich= " << sizeof(Sandwich) << '\n'; 
  cout << "size of eight bools = " << sizeof(EightBoolsPacked) << '\n'; 
  cout << "size of dangling end = " << sizeof(DanglingEndPacked) << '\n'; 
  cout << "size of sandwich= " << sizeof(SandwichPacked) << '\n'; 
  cout << "endianness is " << (is_little_endian() ? "little" : "big") << '\n'; 
  cout << "data layout study end" << '\n';
  return EXIT_SUCCESS;
}

