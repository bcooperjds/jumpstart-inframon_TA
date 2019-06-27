#!/bin/sh                                                                                                
# Copyright (C) 2019 Splunk Inc. All Rights Reserved.                                                                      
#                                                                                                        
#   Licensed under the Apache License, Version 2.0 (the "License");                                      
#   you may not use this file except in compliance with the License.                                     
#   You may obtain a copy of the License at                                                              
#                                                                                                        
#       http://www.apache.org/licenses/LICENSE-2.0                                                       
#                                                                                                        
#   Unless required by applicable law or agreed to in writing, software                                  
#   distributed under the License is distributed on an "AS IS" BASIS,                                    
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                             
#   See the License for the specific language governing permissions and                                  
#   limitations under the License.      
# Original by Splunk Inc.
# Modified By Brendan Cooper (brendan.cooper@jds.net.au) 09 March 2019

. `dirname $0`/common.sh

PRINTF='{printf "disk.filesystem=%s  disk.fstype=%s  disk.size=%s  disk.used=%s  disk.available=%s  disk.usedpct=%s disk.mountpoint=%s \n", $1, $2, $3, $4, $5, $6, $7}'

	assertHaveCommand df
	CMD='df -TPk'
	FILTER_POST='($2 ~ /^(devtmpfs|tmpfs)$/) {next}'

$CMD | tail -n +2 | tee $TEE_DEST | $AWK "$BEGIN $FILTER_PRE $MAP_FS_TO_TYPE $FORMAT $FILTER_POST $NORMALIZE $PRINTF" | tr -d '%' | sed -e 's/=\//=disk\//g' | sed -e 's/\//_/g' | sed -e 's/-/_/g' #header="$HEADER"
echo "Cmd = [$CMD];  | $AWK '$BEGIN $FILTER_PRE $MAP_FS_TO_TYPE $FORMAT $FILTER_POST $NORMALIZE $PRINTF' | tr -d '%' " >> $TEE_DEST
