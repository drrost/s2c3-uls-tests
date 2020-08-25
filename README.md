# Unit tests for ULS project

## Terminology

* Test case - a test function. Must tart with `test_' to be picked by the
testing framework.
* Test suite - a set of test cases. Has it's own directory. The directory
must begin with `ts_'.
* Test run - a set of test suits. There are may be several test runs. From
PDF task, from the assessment and additional tests.

## Usage

Prepare the test project:

```
git clone --recursive git@github.com:drrost/s2c3-uls-tests.git
mv s2c3-uls-tests tests
```

The test project set up to run tests for a prepared ULS project. It await that ULS project
is located in a folder named `src`. The `src` folder **must** be on the same
level as the unit tests project folder:

```
src/
tests/
```

### Run all test cases
Jut navitate to the test project folder and run the main script:
```
cd tests
./run_all.sh
```
