package = {
    -- base info
    name = "xpackage",
    description = "XIM Package File Template",

    authors = "sunrisepeak",
    license = "Apache-2.0",
    repo = "https://github.com/d2learn/xim-pkgindex",

    -- xim pkg info
    type = "package",

    xpm = {
        windows = {
            ["0.0.0"] = { },
        },
        linux = {
            ["0.0.0"] = { },
        },
        ubuntu = { ref = "linux" },
        archlinux = { ref = "linux" },
        manjaro = { ref = "linux" },
    },
}

import("xim.base.runtime")

local pkginfo = runtime.get_pkginfo()

function installed()
    return os.iorun("xvm list xpackage")
end

function install()
    print("install xpackage...")

    -- your install implementation
    -- ...

    return true
end

function config()
    -- your config implementation
    -- ...

    -- config xvm
    os.exec(format(
        [[xvm add xpackage %s --alias "echo hello-xpackage"]],
        pkginfo.version
    ))
    return true
end

function uninstall()
    os.exec("xvm remove xpackage " .. pkginfo.version)

    -- your uninstall implementation
    -- ...

    return true
end