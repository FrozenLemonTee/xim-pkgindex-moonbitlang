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
        windows = { ["latest"] = { } },
        linux = { ["latest"] = { } },
        macosx = { ["latest"] = { } },
    },
}

import("xim.base.runtime")

local pkginfo = runtime.get_pkginfo()

function installed()
    local moon_installed = os.exec("moon version") == 0
    local moonc_installed = os.exec("moonc --v") == 0
    return moon_installed and moonc_installed
end

function install()
    print("install moonbit-cli...")
    if is_host("windows") then
        os.exec("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; irm https://cli.moonbitlang.cn/install/powershell.ps1 | iex")
    else
        os.exec("curl -fsSL https://cli.moonbitlang.cn/install/unix.sh | bash")
    end
    return true
end

function config()
    local moon_root = _get_moon_root()
    local moon_bin = path.join(moon_root, "bin")
    if is_host("windows") then
        local current_path = os.getenv("PATH") or ""
        if not current_path:find(moon_bin, 1, true) then
            os.setenv("PATH", moon_bin .. ";" .. current_path)
        end
    else
        -- Linux/macOS
        os.addenv("PATH", moon_bin)
    end
    return true
end

function uninstall()
    local moon_root = _get_moon_root()
    if is_host("windows") then
        os.exec("rmdir /s /q \"" .. moon_root .. "\"")
    else
        -- Linux/macOS
        os.exec("rm -rf \"" .. moon_root .. "\"")
    end
    print("Moon has been uninstalled successfully.")
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