
# What's this

I gathered some example `.in` files from around the internet here.
I didn't write them, and I wouldn't even claim to know what they do,
mainly they are here to help validate that your SIMPSON is built
correctly, or at least the same way mine is.  Please report any
problems with these.  And it would be nice to extend these to
more situations for better test coverage.

# How can I use it

After building the parent directory, you can compare the example
output with the included "gold" output files:

```
make
./testall.sh ./numdiff/bin/numdiff || echo fail
```
