package = {
    name = "moonbit-devtool",
    description = "MoonBit Development Helper Tools",

    licenses = "Apache-2.0",

    type = "script",
    namespace = "moonbitlang",
    status = "stable",
    categories = { "moonbit", "tools", "update", "helper"},
    keywords = { "moonbit", "configure", "update", "install"},

    programs = {
        "moonbit-devtool",
        "mbtool", -- alias
    },

    xpm = {
        linux = {
            ["latest"] = { ref = "0.0.1" },
            ["0.0.1"] = {}
        },
        macosx = { ref = "linux" },
        windows = { ref = "linux" },
    },
}

import("xim.libxpkg.log")
import("xim.libxpkg.utils")
import("xim.libxpkg.system")
import("xim.libxpkg.xvm")
import("xim.libxpkg.pkginfo")
import("xim.libxpkg.pkgmanager")

-- function install (default)

function config()
    -- add short alias
    xvm.add("mbtool", {
        alias = "moonbit-devtool",
        binding = "moonbit-devtool@" .. pkginfo.version(),
    })
    return true
end

function uninstall()
    xvm.remove("mbtool")
    xvm.remove("moonbit-devtool")
    return true
end

------ script

-- support auto-process input args
local __xscript_input = {
    ["--output"] = false,
}

local moonbit_homedir = path.join(os.getenv("HOME") or os.getenv("USERPROFILE"), ".moon")

function help()
    cprint("")
    cprint("\t${bright}MoonBit Development Helper Tools (mbtool)${clear} - 0.0.1")
    cprint("")
    cprint("Usage: ${bright cyan dim}mbtool <action> [options]")
    cprint("")
    cprint("${bright}Action${clear}:")
    cprint("  ${dim cyan}install${clear}        Install moonbit-cli package (if not installed)")
    cprint("  ${dim cyan}uninstall${clear}      Uninstall moonbit-cli package")
    cprint("  ${dim cyan}update${clear}         Update moonbit core to the latest version")
    cprint("")
    cprint("${bright}Options${clear}:")
    cprint("    --output=<file>   Specify output file (not used currently)")
    cprint("")
    cprint("Examples:")
    cprint("  ${cyan dim}mbtool install${clear}")
    cprint("  ${cyan dim}mbtool update${clear}")
    cprint("  ${cyan dim}mbtool uninstall${clear}")
    cprint("")
end

function update(cmds)

    -- update moonbit core
    local  moonbitlang_coredir = path.join(moonbit_homedir, "lib", "core")

    log.info("Removing old moonbit core dir: %s", moonbitlang_coredir)
    os.tryrm(moonbitlang_coredir)

    log.info("Re-installing moonbit core...")
    --local mb_code_git = "git@github.com:moonbitlang/core.git" -- need ssh
    local mb_code_git = "https://github.com/moonbitlang/core.git"
    system.exec(string.format("git clone %s %s", mb_code_git, moonbitlang_coredir))

    log.info("Building moonbit core...")
    os.cd(moonbitlang_coredir)
    system.exec("moon bundle --source-dir " .. moonbitlang_coredir)
    
    local bundled_file = path.join(
        moonbitlang_coredir,
        "target", "wasm-gc", "release", "bundle", "core.core"
    )
    
    log.info("Bundled file: ${green}%s", bundled_file)

    log.info("MoonBit core has been updated successfully.")
end

function xpkg_main(action, ...)

    local _, cmds = utils.input_args_process(__xscript_input, {...})

    if action == "install" then
        pkgmanager.install("moonbit-cli")
    elseif action == "uninstall" then
        pkgmanager.uninstall("moonbit-cli")
    elseif action == "update" then
        if not xvm.has("moonbit-cli", "") then
            log.warn("moonbit-cli may not be installed, please install it first.")
            cprint("")
            cprint("\t ${cyan}mbtool install${clear}")
            cprint("")
        end
        update(cmds)
    else
        help()
    end
end