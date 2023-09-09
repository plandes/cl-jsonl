# Efficient JSON File Iteration

[![Build Status][build-badge]][build-link]

Lazy read JSONL files with each line a separate definition.  JSONL files are
files with newline delimited JSON blobs and typically very large.  This package
provides a generator that allows a line by line parse reducing memory
complexity for large data demand projects such as those for training deep
learning models.


## Usage

```lisp
;; load libraries and import dependency symbols to the current system
(ql:quickload :cl-jsonl :silent t)
(ql:quickload :gtwiwtg :silent t)
(use-package :cl-jsonl)
(use-package :gtwiwtg)

;; parse the first line of JSON in file `test.json'
(with-json-reader (g #p"test.json")
  (format t "~S~%" (take 1 g)))
```


## Obtaining

The easiest way to install is using [quicklisp]:
```lisp
(ql:quickload :cl-jsonl)
```


## Changelog

An extensive changelog is available [here](CHANGELOG.md).


## License

[GPL 3.0 License](LICENSE.md)

Copyright (c) 2023 Paul Landes


<!-- links -->

[quicklisp]: https://www.quicklisp.org/beta/
[MIT License]: https://opensource.org/licenses/MIT
[build-badge]: https://github.com/plandes/cl-jsonl/workflows/CI/badge.svg
[build-link]: https://github.com/plandes/cl-jsonl/actions
