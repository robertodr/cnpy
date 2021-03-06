# cnpy

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/robertodr/cnpy/master/LICENSE)
[![Build Status](https://img.shields.io/travis/robertodr/cnpy/master.svg?style=flat-square)](https://travis-ci.org/robertodr/cnpy)
[![AppVeyor branch](https://img.shields.io/appveyor/ci/robertodr/cnpy/master.svg?style=flat-square)](https://ci.appveyor.com/project/robertodr/cnpy/branch/master)

C++11 library to save/load arrays to/from NumPy binary format.

## Purpose

Numpy offers the save method for easy saving of arrays into .npy and savez for
zipping multiple .npy arrays together into a .npz file. cnpy lets you read and
write to these formats in C++. The motivation comes from scientific programming
where large amounts of data are generated in C++ and analyzed in Python.
Writing to .npy has the advantage of using low-level C++ I/O (fread and fwrite)
for speed and binary format for size. The .npy file header takes care of
specifying the size, shape, and data type of the array, so specifying the
format of the data is unnecessary.
Loading data written in numpy formats into C++ is equally simple, but requires
you to type-cast the loaded data to the type of your choice.

## Installation

`cnpy` depends on [Zlib](https://www.zlib.net/) and [CMake](https://cmake.org/).
The default installation directory is `/usr/local` but you can change that with
the `--prefix` option to the `setup.py` script.
```bash
>>> python setup.py  # Configure
>>> cd build
>>> make             # Build
>>> ctest            # Run tests
>>> make install
```
`make install` will also install CMake scripts to detect the library as a target
in other projects using a `find_package(cnpy)` command.
To enable this feature, set `-Dcnpy_DIR=${prefix}/share/cmake/cnpy` in the most
appropriate location.

## Using

To use, `#include "cnpy.h"` in your source code. Compile the source code `mycode.cpp` as

```
g++ -o mycode mycode.cpp -L/path/to/install/dir -lcnpy -lz
```

## Description

There are two functions for writing data: `npy_save`, `npz_save`.

There are 3 functions for reading. `npy_load` will load a .npy file.
`npz_load(fname)` will load a .npz and return a dictionary of `NpyArray`
structues. `npz_load(fname, varname)` will load and return the NpyArray for data
varname from the specified .npz file.

The data structure for loaded data is below. Data is accessed via the `data<T>()`
method, which returns a pointer of the specified type (which must match the
underlying datatype of the data). The array shape and word size are read from
the npy header.

```C++
struct NpyArray {
    std::vector<size_t> shape;
    size_t word_size;
    template<typename T> T* data();
};
```

See the sample tests for examples of how to use the library.
