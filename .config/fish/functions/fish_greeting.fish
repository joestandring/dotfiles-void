function fish_greeting
	fortune -e
    printf "\n"
    curl -s wttr.in/peterborough | sed -ne '3,7p'
    printf "\n"
end
