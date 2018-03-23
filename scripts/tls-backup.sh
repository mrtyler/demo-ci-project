#!/bin/bash

domain_zone="flexeption.pw"
source=("ci" "registry" "charts" "staging" "production")
green="\e[1;32m"
no_color="\e[0m"
secret_file_name="secret-$(date '+%Y-%m-%d-%H-%M-%S').yaml"

for i in ${source[@]}
do
    echo "---" >> /project/live/prod/secrets/team1/${secret_file_name} \
    && kubectl get secret $i.$domain_zone-tls -o yaml >> /project/live/prod/secrets/team1/${secret_file_name} \
    && printf "${green}Secret $i.$domain_zone-tls has been saved to ./live/prod/secrets/team1/${secret_file_name} successfully!\n${no_color}"
done
