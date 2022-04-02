source includes.sh

search_city=$1
search_region=$2
search_country=$3

tmp_timezone_file="${timezone_file}.tmp"

[[ -e "${tmp_timezone_file}" ]] && rm -rf "$tmp_timezone_file"

while IFS= read -r line
	do

	OIFS=$IFS
	IFS='|'		#Split stored line by delimiter
	data=($line)	#Create array
	city="${data[0]}"
    region="${data[1]}"
	country="${data[2]}"
	timezone="${data[3]}"
	country_code="${data[4]}"
	favourite="${data[5]}"

    if [[ -z "${favourite}" ]]; then
        favourite="1"
    fi

	if [[ "$city" == "$search_city" ]] && [[ "$region" == "$search_region" ]] && [[ "$country" == "$search_country" ]]; then
        if [[ "${favourite}" == "0" ]]; then
            favourite="1"
        else
            favourite="0"
        fi
        selected_city="$city"
        selected_region="$region"
        selected_country="$country"
        selected_fav="$favourite"
    fi

    echo "$city|$region|$country|$timezone|$country_code|$favourite" >> "${tmp_timezone_file}"

done < "$timezone_file"

if [[ "$selected_fav" == "1" ]]
then
    echo "$selected_city, $selected_region, $selected_country has been un-pinned to the top of your list!"
else
    echo "$selected_city, $selected_region, $selected_country has been pinned from the top of your list!"
fi

cat "${tmp_timezone_file}" > "${timezone_file}"

[[ -e "${tmp_timezone_file}" ]] && rm -rf "$tmp_timezone_file"
