Ruby Gem with statically linked pdftotext binary from [poppler], so you don't
need to install the package in the container, dev environments, etc.

Note that poppler is GPL 2 or later.

Run `make.zsh` to build a new binary.

[popler]: https://poppler.freedesktop.org/

Usage
-----
In Gemfile:

    gem 'pdftotext_binary'

And get the path with:

    >> Gem.bin_path('pdftotext_binary', 'pdftotext')
    => "/home/martin/.gem/ruby/4.0.0/gems/pdftotext_binary-1.0.0/bin/pdftotext"

On unsupported architectures you will get something like:

    pdftotext_binary: unsupported platform FreeBSD/x86_64

You can set PDFTOTEXT_BIN for those cases, e.g.:

    export PDFTOTEXT_BIN=/bin/pdftotext
