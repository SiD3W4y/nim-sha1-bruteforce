# nim-sha1-bruteforce

Program finding the most prefixed zeros in a sha1 hash, calculated from a prefix + value.

Build with
```
./build.sh
```

and run with
```
./bruteforce <prefix> <number of worker threads>
```

With 3 threads on my computer I can get 1200kH/s, could be optimized further
