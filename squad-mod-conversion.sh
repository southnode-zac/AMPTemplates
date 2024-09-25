#!/bin/bash
fix_windows_only_mods() {
    local mods_dir="./squad-dedicated-server/403240/steamapps/workshop/content/393380"

    for mod_id in $1; do
        pak_dir=$(find "$mods_dir/$mod_id" -type d -path "*/Content/Paks" -print -quit)

        if [ -z "$pak_dir" ]; then
            echo "[fix_windows_only_mods:$mod_id] Couldn't find Content/Paks dir for windows mod"
        else
            echo "[fix_windows_only_mods:$mod_id] Found the following Content/Paks directory: $pak_dir"

            windows_dir="$pak_dir/WindowsNoEditor"
            linux_dir="$pak_dir/LinuxServer"

            if [ -d "$windows_dir" ]; then
                if [ -d "$linux_dir" ]; then
                    rm -rf $linux_dir
                fi

                mv $windows_dir $linux_dir

                echo "[fix_windows_only_mods:$mod_id] patched successfully"
            fi
        fi
    done
}
