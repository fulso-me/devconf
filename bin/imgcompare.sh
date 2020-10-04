#!/bin/bash
# imgcompare.sh {dir:.} {cutoff:0.95}
# The application will recommend actions to take for duplicates.
# imgcompare.sh . 0.98 | vim -
# :%v/^r/d
# :%!bash
# :q!
################################################################################
# MIT License
# 
# Copyright (c) 2020 Brian Robertson
# https://fulsome.ca/blog/2020/07/21/imgcompare
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
################################################################################

dir=
cutoff=
files=()
images=()
images_len=0
props=()
aspects=()

# {{{ Get list of files
if [ -z "$1" ]; then
  dir="$PWD"
else
  dir="$1"
fi
if [ -z "$2" ]; then
  cutoff=0.98
else
  cutoff="$2"
fi

#files=$(find "$dir" -type f) # --max-depth=1
# '' is a null delimiter
readarray -d '' files < <(find "$dir" -maxdepth 1 -type f -print0)
# }}}

# {{{ Trim the files list into just a list of valid images.
files_len=${#files[@]}

for ((i = 0; i < files_len; i++)); do
  #  echo "$i - ${files[$i]}"
  if (identify -quiet -ping "${files[$i]}" > /dev/null); then
    images[$images_len]="${files[$i]}"
    ((images_len++))
  fi
done
# }}}

# {{{ Get image properties and generate tmp files
mkdir -p /tmp/imgcompare/"${dir##*/}"
tmpdir=/tmp/imgcompare/"${dir##*/}"

for ((i = 0; i < images_len; i++)); do
  props[$i]="$(identify -format '%w %h' "${images[$i]}")"
  aspects[$i]="$(echo "${props[$i]}" | awk '{printf("%0.2f", int( ($1/$2) * 100 )/100 );}')" # round to the nearest 2 decimals by truncating from an int
  convert "${images[$i]}" -trim +repage -resize '256x256^!' "$tmpdir/$i.mpc"
done
# }}}

# {{{ Compare images
for ((i = 0; i < files_len; i++)); do
  for ((j = i + 1; j < images_len; j++)); do
    if [ $i -ne $j ]; then
      # Only bother comparing if the aspects match
      if [ "${aspects[$i]}" == "${aspects[$j]}" ]; then
        # Compare the smaller mpc file for speed sake
        NCCsmall="$(compare -metric NCC "$tmpdir/$i.mpc" "$tmpdir/$j.mpc" null: 2>&1)"
        sizei="$(ls -l "${images[$i]}" | awk '{ printf("%i", $5); }')"
        sizej="$(ls -l "${images[$j]}" | awk '{ printf("%i", $5); }')"
        # If the small NCC matches then compare them again at full resolution
        if (($(echo "$NCCsmall >= $cutoff" | bc -l))); then
          NCC="$(compare -metric NCC "${images[$i]}" "${images[$j]}" null: 2>&1)"
          # Use awk because it's better
          awk -v ncc="$NCC" -v cutoff="$cutoff" \
            -v filei="${images[$i]}" -v filej="${images[$j]}" \
            -v sizei="$sizei" -v sizej="$sizej" 'BEGIN{
                  if ( ncc >= cutoff ) {
                    printf("  %f\n  %i - %s\n  %i - %s\n", ncc, sizei, filei, sizej, filej); 
                    if ( sizei == sizej ) {
                      if ( filei ~ /_$/ ) {
                        printf("  Recommended action (file ends in _):\nrm -v \"%s\"\n", filei);
                      }
                      else if (filej ~ /_$/ ) {
                        printf("  Recommended action (file ends in _):\nrm -v \"%s\"\n", filej);
                      }
                      else if (filei ~ /\([0-9]+\)$/ ) {
                        printf("  Recommended action (file ends in (d)):\nrm -v \"%s\"\n", filei);
                      }
                      else if (filej ~ /\([0-9]+\)$/ ) {
                        printf("  Recommended action (file ends in (d)):\nrm -v \"%s\"\n", filej);
                      }
                      else {
                        printf("  Recommended action (files are exactly the same):\nrm -v \"%s\"\n", filej);
                      }
                    }
                    else {
                      printf("  Recommended action (size difference):\nrm -v \"%s\"\n", (sizei < sizej)? filei : filej );
                    }
                  printf("\n");
                }
              }'
        fi
      fi
    fi
  done
done
# }}}

rm "$tmpdir"/*.mpc "$tmpdir"/*.cache

printf '\n\n  To execute recommended actions pipe to vim and execute the commands below\n  %s %s %s | vim -\n  :%%v/^r/d\n  :%%!bash\n  :q!\n\n' "$0" "$dir" "$cutoff"
