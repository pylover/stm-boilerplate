# STM Boilerplate

This is a successful attempt to develop and debug `STM` `MCU`s firmware over 
the `Linux` terminal using `VIM`, `GDB`, `OpenOCD`, `SemiHosting`, etc.

The program entry-point is inside the `CMAKE_PROJECT_NAME/main.c`.
In this example the project name is defined at the second line of the 
`CMakeLists.txt`:
```cmake
cmake_minimum_required(VERSION 3.28.3)
project(foo
  VERSION 0.1.0
  LANGUAGES ASM C
)
```

So, the main entry point is inside the `foo/main.c`.


## Build

### Dependencies
```bash
sudo apt install \
  libusb-1.0-0-dev \
  cmake-curses-gui \
  openocd

wget http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.4-2ubuntu0.1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libncursesw5_6.4-2ubuntu0.1_amd64.deb
sudo dpkg -i libtinfo5_6.4-2ubuntu0.1_amd64.deb
sudo dpkg -i libncursesw5_6.4-2ubuntu0.1_amd64.deb 
rm libtinfo5_6.4-2ubuntu0.1_amd64.deb
rm libncursesw5_6.4-2ubuntu0.1_amd64.deb 
```


#### Latest ARM toolchain
```bash
scripts/install-toolchain.sh
```


#### STlink v2 firmware version
You may check the `STLINK/v2-1` version using:
```
st-info --probe
Found 1 stlink programmers
  version:    V2J45S30
  serial:     0xxxxxxxxxxxxxxxxxxxxxx0
  flash:      524288 (pagesize: 2048)
  sram:       65536
  chipid:     0x446
  dev-type:   STM32F302_F303_F398_HD
```

The, update your programmer's firmware using the `CubeProgrammer` if required.


### Lint
```bash
cd build
make lint
```


### Compile
```bash
scripts/rollup.sh
cd build
make menu
make clean all
```

## Flash the firmware
```bash
cd build
make flash
```


## Debug & Semihosting
```bash
cd build
make debug
```
