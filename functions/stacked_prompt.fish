function stacked_prompt --description 'Write out the stacked prompt with tech, git, and battery info'
    # Save the last command's exit status
    set -l last_status $status

    # Colors (configurable via environment variables)
    set -l path_color (set_color $STACKED_PROMPT_PATH_COLOR)
    set -l branch_color (set_color $STACKED_PROMPT_BRANCH_COLOR)
    set -l tech_color (set_color $STACKED_PROMPT_TECH_COLOR)
    set -l battery_color (set_color $STACKED_PROMPT_BATTERY_COLOR)
    set -l box_color (set_color $STACKED_PROMPT_BOX_COLOR)
    set -l normal (set_color normal)

    # Start with a new line
    echo ""

    # Start async battery info detection
    _battery_stack_async

    # Display battery info if available and below 50%
    if set -q $_battery_stack_data
        set -l battery_display "$$_battery_stack_data"
        if test -n "$battery_display"
            echo $battery_display
        end
    end

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
                set folder_info (basename $git_root)(string replace -r "^/" "/" $relative_path)
            end
        end

        # First line: folder path
        echo -n $box_color"┌─ "$normal
        if test -n "$folder_info"
            echo $path_color$folder_info$normal
        else
            echo
        end

        # Always run async functions
        _tech_stack_async

        # Second line: git info
        echo -n $box_color"├─ "$normal
        _git_stack_async
        set -l branch_name (command git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || command git --no-optional-locks rev-parse --short HEAD 2>/dev/null)
        echo -n $branch_color"$branch_name"$normal

        if set -q $_git_stack_info
            set -l git_status "$$_git_stack_info"
            if test -n "$git_status"
                echo -n " ($git_status)"
            end
        end
        echo

        # Third line: tech info (now the last line)
        echo -n $box_color"└─ "$normal
        echo -n $tech_color"tech: "$normal
        if set -q $_tech_info_git
            set -l tech_info "$$_tech_info_git"
            if test -n "$tech_info"
                echo $tech_info
            else
                echo "not detected"
            end
        else
            echo "not detected"
        end
    else
        # Normal folder - simple format
        echo $path_color(prompt_pwd)$normal
    end

    # Prompt indicator
    set -l prompt_color
    if test $last_status -eq 0
        set prompt_color (set_color bryellow)
    else
        set prompt_color (set_color brred)
    end

    echo -n $prompt_color"❯ "$normal
end
