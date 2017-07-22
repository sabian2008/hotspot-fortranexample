# hotspot-fortrantest
Simple program to test/showcase hotspot functionality when reading a `.data` file generated from a Fortran binary.

The program in this example computes the matrix product of two variable-length pseudorandom matrices using a simple straightforward algorithm with different compiler optimizations (`-O`, `-O1`, `-O2`, `-O3`). Finally, error-checking is carried out comparing against the standard `MATMUL` intrinsic function.

## Dependencies
This test requires the following binaries
- `gfortran` (or any other Fortran compiler) with Fortran 95+ support,
- `perf` (available in most GNU/Linux distributions' repositories),
- `hotspot` (download and build instructions [here](https://github.com/KDAB/hotspot)).

## Usage
With all the dependencies resolved, usage is straight forward. Download this repository (or clone it using `git clone URL`).

The next step is to build the test binary. This can be easily done with
```
cd hotspot-fortrantest
gfortran -c -O standard_mult.f90
for i in {O,O1,O2,O3}; do gfortran -c -$i $i\_mult.f90; done
gfortran *.o test.f90 -o test
```

Now it's time to record a `.data` file using the `perf` tool. This can be done with the command `perf record --call-graph dwarf ./test N` (where N is the size of the matrices, depending on your system a value between 500 and 1000 should be a reasonable choice for showcasing purposes).

Finally, to analyze the that using hotspot, simply run `hotspot perf.data`.

## Some screenshots
![](img/summary.png?raw=true)

![](img/bottom-up.png?raw=true)

![](img/flame-graph.png?raw=true)

## Troubleshooting
It's likely that, by default, you don't have permissions to record performance data. If you have `root` access, this can be fixed (at least in Debian-based distributions) by creating a `sysctl` configuration file (`profiling.conf` seems a sensible name to use) under the `/etc/sysctl.d/` directory with the following contents
```
kernel.perf_event_paranoid = 0
```
and rebooting. If you don't want to reboot, you may alternatively run
```
echo 0 > /proc/sys/kernel/perf_event_paranoid
```
however, without a `.conf` file, changes will be lost upon reboot.
