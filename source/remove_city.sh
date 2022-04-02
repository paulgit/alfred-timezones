source includes.sh

#Split previous argument
city=$1
region=$2
country=$3

cat "$timezone_file" | grep -v "$city|$region|$country" > /tmp/zonelist.tmp

mv /tmp/zonelist.tmp "$timezone_file"

if [[ "$city" == "$region" ]] || [[ -z $region ]]; then
    echo -n "$city, $country has been removed from your TimeZone list."
else
    echo -n "$city, $region, $country has been removed from your TimeZone list."
fi
