local assert = require('assert')
local magic = require('libmagic')

local testfuncs = {}
local testcase = setmetatable({}, {
    __newindex = function(_, name, func)
        if type(func) ~= 'function' then
            error(string.format('testcase.%s must be function'), 2)
        elseif testfuncs[name] then
            error(string.format('testcase.%s already defined'), 2)
        end
        testfuncs[name] = true
        testfuncs[#testfuncs + 1] = {
            name = name,
            func = func,
        }
    end,
})

function testcase.getpath()
    -- test that returns a default path string
    local pathname = assert(magic.getpath())
    assert.is_string(pathname)
    assert.not_equal(pathname, '')
end

function testcase.open()
    -- test that returns instance of magic
    local m = assert(magic.open())
    assert.match(tostring(m), '^libmagic: ', false)

    -- test that throws an error with invalid argument
    local err = assert.throws(function()
        magic.open('foo')
    end)
    assert.match(err, '#1 .+ [(]number expected, got string', false)
end

function testcase.load()
    local m = assert(magic.open())

    -- test that load default magic file
    assert(m:load())

    -- test that throws an error with invalid argument
    local err = assert.throws(function()
        m:load({})
    end)
    assert.match(err, '#1 .+ [(]string expected, got table', false)
end

function testcase.file()
    local m = assert(magic.open(magic.MIME_TYPE))
    assert(m:load())

    -- test that returns a textual description of the contents of the filename
    local res = assert(m:file('./test/libmagic_test.lua'))
    assert.equal(res, 'text/plain')

    -- test that returns a textual description of the contents of the filename
    res = assert(m:file('./test/noent.lua'))
    assert.match(res, 'cannot open')

    -- test that throws an error with invalid a
    local err = assert.throws(function()
        m:file({})
    end)
    assert.match(err, '#1 .+ [(]string expected, got table', false)
end

function testcase.buffer()
    local m = assert(magic.open(magic.MIME_TYPE))
    assert(m:load())
    local f = assert(io.open('./test/libmagic_test.lua', 'r'))
    local b = assert(f:read('*a'))
    f:close()

    -- test that returns a textual description of the contents of the filename
    local res = assert(m:buffer(b))
    assert.equal(res, 'text/plain')

    -- test that throws an error with invalid a
    local err = assert.throws(function()
        print(m:buffer({}))
    end)
    assert.match(err, '#1 .+ [(]string expected, got table', false)
end

function testcase.filehandle()
    local m = assert(magic.open(magic.MIME_TYPE))
    assert(m:load())
    local f = assert(io.open('./test/libmagic_test.lua', 'r'))

    -- test that returns a textual description of the contents of the filename
    local res = assert(m:filehandle(f))
    assert.equal(res, 'text/plain')

    -- test that throws an error with invalid a
    local err = assert.throws(function()
        m:filehandle({})
    end)
    assert.match(err, '#1 .+ [(]FILE%* expected, got table', false)

    f:close()
end

local success = 0
local failure = 0
print(string.format('run %d testcases', #testfuncs))
for _, v in ipairs(testfuncs) do
    local ok, err = xpcall(v.func, debug.traceback)
    if ok then
        success = success + 1
        print(string.format('- %s ... ok', v.name))
    else
        failure = failure + 1
        print(string.format('- %s ... failed', v.name))
        print(err)
    end
end
print('')
print(string.format([[
%d success, %d failure
]], success, failure))
os.exit(failure)
