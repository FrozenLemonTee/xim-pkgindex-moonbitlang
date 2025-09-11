package = {
    -- base info
    homepage = "https://www.moonbitlang.com",

    name = "moonbit-installer",
    description = "MoonBit programming language installer",

    authors = "MoonBit Team",
    maintainers = "https://github.com/moonbitlang",
    licenses = "Apache-2.0",
    repo = "https://github.com/moonbitlang/moonbit",
    docs = "https://www.moonbitlang.com/docs",

    -- xim pkg info
    status = "stable",
    categories = {"moonbit", "installer" },
    keywords = {"moonbit", "installer", "lang"},
    type = "package",
    namespace = "moonbitlang",
    archs = {"x86_64"},
    programs = { "moonbit-installer" },

    xpm = {
        windows = { ["latest"] = { url = "https://cli.moonbitlang.cn/install/powershell.ps1" } },
        linux = { ["latest"] = { url = "https://cli.moonbitlang.cn/install/unix.sh" } },
        macosx = { ref = "linux" },
    },
}

import("xim.libxpkg.log")
import("xim.libxpkg.pkginfo")
import("xim.libxpkg.xvm")

local cmd_alias = {
    windows = [[powershell -NoProfile -ExecutionPolicy Bypass -File %s\powershell.ps1]],
    linux = "bash %s/unix.sh",
    macosx = "bash %s/unix.sh",
}

-- function installed() end -- use default impl (by xvm)

function install()
    log.info("install moonbit-installer...")
    os.trymv(pkginfo.install_file(), pkginfo.install_dir())
    return true
end

function config()
    log.info("register moonbit-installer...")
    local cmd_alias = string.format(cmd_alias[os.host()], pkginfo.install_dir())
    xvm.add("moonbit-installer", { alias = cmd_alias })
    return true
end

function uninstall()
    xvm.remove("moonbit-installer")
    return true
end