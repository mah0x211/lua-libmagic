lua-libmagic
=========

[![test](https://github.com/mah0x211/lua-libmagic/actions/workflows/test.yml/badge.svg)](https://github.com/mah0x211/lua-libmagic/actions/workflows/test.yml)


`libmagic` binding for lua.  
see `man libmagic` for more details.

***

## Dependencies

- libmagic: https://github.com/file/file


## Installation

```sh
luarocks install libmagic
```


## Usage

```lua
local libmagic = require('libmagic')
local m = libmagic.open( libmagic.MIME_TYPE, libmagic.NO_CHECK_COMPRESS )
assert(m:load()) -- load the default database

print(m:file('README.md'))  -- output "text/plain"
```

## Constants

`libmagic` module has the following constants.

- libmagic.VERSION
- libmagic.NONE
- libmagic.DEBUG
- libmagic.SYMLINK
- libmagic.COMPRESS
- libmagic.DEVICES
- libmagic.MIME_TYPE
- libmagic.CONTINUE
- libmagic.CHECK
- libmagic.PRESERVE_ATIME
- libmagic.RAW
- libmagic.ERROR
- libmagic.MIME_ENCODING
- libmagic.MIME
- libmagic.APPLE
- libmagic.EXTENSION
- libmagic.COMPRESS_TRANSP
- libmagic.NODESC
- libmagic.NO_CHECK_COMPRESS
- libmagic.NO_CHECK_TAR
- libmagic.NO_CHECK_SOFT
- libmagic.NO_CHECK_APPTYPE
- libmagic.NO_CHECK_ELF
- libmagic.NO_CHECK_TEXT
- libmagic.NO_CHECK_CDF
- libmagic.NO_CHECK_TOKENS
- libmagic.NO_CHECK_ENCODING
- libmagic.NO_CHECK_JSON
- libmagic.NO_CHECK_ASCII
- libmagic.NO_CHECK_FORTRAN
- libmagic.NO_CHECK_TROFF


## Create an instance of libmagic

```lua
local libmagic = require('libmagic')
local m = libmagic.open(libmagic.MIME_TYPE)
```

## Methods

### str, err = m:file( pathname )

returns a textual description of the contents of the file.

**Parameters**

- `pathname:string`: pathname of the file.

**Returns**

- `str:string`: a textual description.
- `err:string`: error string.


### str, err = m:descriptor( fd )

returns a textual description of the contents of the file descriptor.

**Parameters**

- `fd:integer`: file descriptor.

**Returns**

- `str:string`: a textual description.
- `err:string`: error string.


### str, err = m:filehandle( fh )

returns a textual description of the contents of the filehandle.

**Parameters**

- `fh:filehandle`: lua filehandle.

**Returns**

- `str:string`: a textual description.
- `err:string`: error string.


### str, err= m:buffer( buf:string )

returns a textual description of the contents of the buffer.

**Parameters**

- `buf:string`: buffer string.

**Returns**

- `str:string`: a textual description.
- `err:string`: error string.


### err = m:error()

returns a textual explanation of the last error.

**Returns**

- `err:string`: error string.


### ok = m:setflags( [flag, ...] )

set flags.

**Returns**

- `ok:boolean`: `true` on success.


### ok, err = m:load( [pathnames:string] )

loads the database files from the colon separated list of database files.

**Parameters**

- `pathnames:string`: the colon separated list of database files.

**Returns**

- `ok:boolean`: `true` on success.
- `err:string`: error string.


### ok, err = m:compile( pathnames:string )

compile the colon separated list of database files.

**Parameters**

- `pathnames:string`: the colon separated list of database files.

**Returns**

- `ok:boolean`: `true` on success.
- `err:string`: error string.


### ok, err = m:check( [pathnames:string] )

check the validity of entries in the colon separated database files.

**Parameters**

- `pathnames:string`: the colon separated list of database files.

**Returns**

- `ok:boolean`: `true` on success.
- `err:string`: error string.


### ok, err = m:list( [pathnames:string] )

dumps all magic entries in a human readable format

**Returns**

- `ok:boolean`: `true` on success.
- `err:string`: error string.


### errno = m:errno()

returns the last operating system error number.

**Returns**

- `errno:integer`: system error number (`errno`).

