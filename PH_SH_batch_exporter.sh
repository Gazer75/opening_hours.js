#!/bin/bash
## @license AGPLv3 <https://www.gnu.org/licenses/agpl-3.0.html>
## @author Copyright (C) 2015 Robin Schneider <ypid@riseup.net>
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU Affero General Public License as
## published by the Free Software Foundation, version 3 of the
## License.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Affero General Public License for more details.
##
## You should have received a copy of the GNU Affero General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

script_url="https://github.com/ypid/opening_hours.js/blob/master/PH_SH_batch_exporter.sh"

print_header()
{
    echo "# This file was generated by the script ${script_url}."
    echo "# Do not edit this file ;-)"
    echo "#"
    echo "# Diese Datei wurde durch das Skript ${script_url} erzeugt."
    echo "# Nicht von Hand editieren ;-)"
}

for state in bw by be bb hb hh he mv ni nw rp sn st sl sh th
do
    filepath="feiertage_${state}.conf"
    echo "Generating $filepath …"
    ./PH_SH_exporter.js /tmp/PH_SH_export.list --from 2013 --until 2042 --public-holidays --region $state
    (
        print_header
        cat /tmp/PH_SH_export.list
    ) > $filepath
done

## FIXME: Triggers a bug in opening_hours.js: sl sh th
for state in bw by be bb hb hh he mv ni nw rp sn st
do
    filepath="ferien_${state}.conf"
    echo "Generating $filepath …"
    ./PH_SH_exporter.js /tmp/PH_SH_export.list --from 2013 --until 2016 --school-holidays --region $state
    (
        print_header
        cat /tmp/PH_SH_export.list
    ) > $filepath
done