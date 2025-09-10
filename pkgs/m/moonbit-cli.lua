package = {
    -- base info
    homepage = "https://www.moonbitlang.com",

    name = "moonbit-cli",
    description = "MoonBit programming language command line tools",

    authors = "MoonBit Team",
    maintainers = "https://github.com/moonbitlang",
    licenses = "Apache-2.0",
    repo = "https://github.com/moonbitlang/moonbit",
    docs = "https://www.moonbitlang.com/docs",

    -- xim pkg info
    status = "stable",
    categories = {"plang", "compiler", "wasm", "cli"},
    keywords = {"Reliability", "Performance", "Productivity"},
    type = "package",
    namespace = "moonbitlang",
    archs = {"x86_64"},
    programs = { "moon", "moonc", "moonfmt", "moonrun" },

    xpm = {
        linux = {
            deps = { "moonbit-installer" },
            ["latest"] = { }
        },
        windows = { ref = "linux" },
        macosx = { ref = "linux" },
    },
}

import("xim.libxpkg.log")
import("xim.libxpkg.pkginfo")
import("xim.libxpkg.system")
import("xim.libxpkg.xvm")

function installed()
    return os.isfile(path.join(_get_moon_root(), "bin", "moon"))
end

function install()
    system.exec("moonbit-installer")
    return true
end

function config()
    local moon_root = _get_moon_root()
    local moon_bin = path.join(moon_root, "bin")
    os.addenv("PATH", moon_bin)

    xvm.add("moonbit-cli") -- only flag

    return true
end

function uninstall()
    local moon_root = _get_moon_root()
    if not os.tryrm(moon_root) then
        log.warn("Failed to remove Moon installation directory: %s", moon_root)
    else
        log.info("Moon has been uninstalled successfully.")
    end
    xvm.remove("moonbit-cli")
    return true
end

function _get_moon_root()
    local home
    if is_host("windows") then
        home = os.getenv("USERPROFILE")
    else
        -- Linux/macOS
        home = os.getenv("HOME")
    end
    return path.join(home, ".moon")
end