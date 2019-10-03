#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Copyright 2019 Cray "rezb1t" Elliott

# You can download the latest version of this script from:
# https://github.com/MiSTer-LLAPI/blisSTer_flash

SCRIPT_PATH="/media/fat/Scripts"
CURL_RETRY="--connect-timeout 15 --max-time 120 --retry 3 --retry-delay 5"

if [ -f "${SCRIPT_PATH}/blisSTer_flash" ]
then
	rm "$SCRIPT_PATH/blisSTer_flash"
fi

curl $CURL_RETRY --insecure -L "https://github.com/MiSTer-LLAPI/blisSTer_flash/blob/master/release/blisSTer_flash?raw=true" -o "$SCRIPT_PATH/blisSTer_flash"

if [ -f "${SCRIPT_PATH}/latest.hex" ]
then
	rm "$SCRIPT_PATH/latest.hex"
fi

curl $CURL_RETRY --insecure -L "https://github.com/MiSTer-LLAPI/blisSTer_flash/blob/master/release/latest.hex?raw=true" -o "$SCRIPT_PATH/latest.hex"
read -rsn1 -p "Ready to update, hold one of the blisSTer reset buttons and then press any key to proceed. DO NOT LET GO OF THE RESET BUTTON UNTIL UPDATING HAS COMPLETED!!"
$SCRIPT_PATH/blisSTer_flash -r $SCRIPT_PATH/latest.hex 16d0 0a5f
read -rsn1 -p "Done! Press any key to exit the script"
