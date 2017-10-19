# Semantic version check
---
Compares two values of [semantic versions](http://semver.org/) and returns and error if the first argument is greater or equal to the second. Inspired by [cloudflare/semver_bash](https://github.com/cloudflare/semver_bash)
For example:
```
$ ./semver.sh 2.0.1 1.0.2
ERROR: VERSION CANNOT BE SMALLER OR EQUAL TO THE CURRENT

$ ./semver.sh 2.10.2 2.0.20
ERROR: VERSION CANNOT BE SMALLER OR EQUAL TO THE CURRENT

$ ./semver.sh 1.0.0 1.0.0
ERROR: VERSION CANNOT BE SMALLER OR EQUAL TO THE CURRENT

$ ./semver.sh 1.0.0 1.0.1
```

# TODOs
- add tests
