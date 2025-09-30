function stacked_prompt --description 'Write out the stacked prompt with tech, git, and battery info'
    # Save the last command's exit status
    set -l last_status $status

    # Colors (configurable via environment variables)
    set -l path_root_color (set_color $STACKED_PROMPT_PATH_ROOT_COLOR)
    set -l path_relative_color (set_color $STACKED_PROMPT_PATH_RELATIVE_COLOR)
    set -l branch_color (set_color $STACKED_PROMPT_BRANCH_COLOR)
    set -l tech_color_mods (set_color $STACKED_PROMPT_TECH_COLOR_MODS)
    set -l tech_color_langs (set_color $STACKED_PROMPT_TECH_COLOR_LANGS)
    set -l battery_color (set_color $STACKED_PROMPT_BATTERY_COLOR)
    set -l box_color (set_color $STACKED_PROMPT_BOX_COLOR)
    set -l normal (set_color normal)

    # Start with a new line
    echo ""

    # Check if we're in a git repository
    if command git --no-optional-locks rev-parse --git-dir >/dev/null 2>&1
        # Git controlled folder - use box format

        # Get folder name from project root
        set -l folder_info ""
        set -l git_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)
        if test -n "$git_root"
            set -l relative_path (string replace $git_root "" $PWD)
            if test -z "$relative_path"
                set folder_info (basename $git_root)
            else
                set folder_info "$(basename $git_root)$normal $path_relative_color~$relative_path$normal"
            end
        end

        # Always run async functions
        _tech_stack_async
        _git_stack_async

        # Get stack order and display
        set -l stacks (string split ',' $STACKED_PROMPT_ORDER)

        for i in (seq (count $stacks))
            set -l stack $stacks[$i]

            # Box character based on position
            set -l box_char
            if test $i -eq 1
                set box_char "┌─ "
            else if test $i -eq (count $stacks)
                set box_char "└─ "
            else
                set box_char "├─ "
            end

            echo -n $box_color$box_char$normal

            # Display stack content
            switch $stack
                case path
                    test -n "$folder_info"; and echo "$path_root_color$folder_info$normal"; or echo
                case git
                    set -l branch (command git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || command git --no-optional-locks rev-parse --short HEAD 2>/dev/null)
                    set -l status_info (set -q $_git_stack_info; and test -n "$$_git_stack_info"; and echo " ($$_git_stack_info)")
                    echo "$branch_color$branch$normal$status_info"
                case tech_stack_langs
                    set -l tech_info (set -q $_tech_stack_langs; and test -n "$$_tech_stack_langs"; and echo "$$_tech_stack_langs"; or echo "no langs detected")
                    echo "$tech_color_langs$tech_info$normal"
                case tech_stack_mods
                    set -l tech_info (set -q $_tech_stack_mods; and test -n "$$_tech_stack_mods"; and echo "$$_tech_stack_mods"; or echo "no mods detected")
                    echo "$tech_color_mods$tech_info$normal"
            end
        end
    else
        # Normal folder - simple format
        echo $path_root_color(prompt_pwd)$normal
    end

    # Start async battery info detection
    _battery_stack_async

    # Build the final prompt line
    set -l prompt_color
    if test $last_status -eq 0
        set prompt_color (set_color bryellow)
    else
        set prompt_color (set_color brred)
    end

    # Combine battery info (if available) with prompt
    set -l final_prompt ""
    if set -q $_battery_stack_data
        set -l battery_display "$$_battery_stack_data"
        if test -n "$battery_display"
            set final_prompt "$battery_display "
        end
    end
    set final_prompt "$final_prompt$prompt_color❯ $normal"

    echo -n $final_prompt
end
