function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color red)'['(set_color brown)(date +%H)(set_color red)':'(set_color brown)(date +%M)(set_color red)':'(set_color brown)(date +%S)(set_color red)']'(set_color yellow)(whoami)(set_color green)'@'(set_color cyan)(prompt_hostname)(set_color blue) (prompt_pwd) (set_color purple)'❯' (set_color normal) 
end
