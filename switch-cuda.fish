#!/usr/bin/env fish

# Copyright (c) 2018 Patrick Hohenecker, Orange Cheers
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# author:   Patrick Hohenecker <mail@paho.at>
# version:  2018.1
# date:     May 15, 2018

# author:   Orange Cheers <orange_cheers@outlook.com>
# version:  2024.5
# date:     May 14, 2024

if status --is-command-substitution
    echo "Please use 'source' to execute switch-cuda.fish!"
    return 1
end

set INSTALL_FOLDER "/usr/local"  
set TARGET_VERSION $argv[1]      


if test -z "$TARGET_VERSION"
    echo "The following CUDA installations have been found (in '$INSTALL_FOLDER'):"
    ls -l "$INSTALL_FOLDER" | string match -r 'cuda-[0-9]+\.[0-9]+$' | while read line
        echo "* $line"
    end
    return

else if not test -d "$INSTALL_FOLDER/cuda-$TARGET_VERSION"
    echo "No installation of CUDA $TARGET_VERSION has been found!"
    return
end


set cuda_path "$INSTALL_FOLDER/cuda-$TARGET_VERSION"


set -l path_elements (string split ':' $PATH)
set new_path "$cuda_path/bin"
for p in $path_elements
    if not string match -qr "^$INSTALL_FOLDER/cuda" -- $p
        set new_path "$new_path:$p"
    end
end


set -l ld_path_elements (string split ':' $LD_LIBRARY_PATH)
set new_ld_path "$cuda_path/lib64:$cuda_path/extras/CUPTI/lib64"
for p in $ld_path_elements
    if not string match -qr "^$INSTALL_FOLDER/cuda" -- $p
        set new_ld_path "$new_ld_path:$p"
    end
end


set -gx CUDA_HOME "$cuda_path"
set -gx CUDA_ROOT "$cuda_path"
set -gx LD_LIBRARY_PATH "$new_ld_path"
set -gx PATH "$new_path"

echo "Switched to CUDA $TARGET_VERSION."
