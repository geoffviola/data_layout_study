# data\_layout\_study
A short study on how data is laid out for various compiler for various flags

# Results
Compiler | OS | CPU
---|---|---
clang-900.0.39.2 | 10.13.3 | x86_64

Test | Result |
---|---|
Eight bools | 8
dangling end | 8
sandwich | 12
eight bools packed | 8
dangling end packed | 5
sandwich packed | 9
endianness | little

---

Compiler | OS | CPU
---|---|---
g++ (Raspbian 4.9.2-10) 4.9.2 | Linux raspberrypi 4.4.38+ | RMv6-compatible processor rev 7 (v6l)

Test | Result |
---|---|
Eight bools | 8
dangling end | 8
sandwich | 12
Eight bools packed | 8
dangling end packed | 5
sandwich packed | 9
endianess little | little
