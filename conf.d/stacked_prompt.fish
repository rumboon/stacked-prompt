# Stacked Prompt initialization
# This file is automatically loaded when Fish starts

# Initialize stacked prompt variables
set -g _stacked_prompt_initialized true

# Set up default colors for the stacked prompt
# These can be overridden by the user after installation
if not set -q STACKED_PROMPT_PATH_COLOR
    set -gx STACKED_PROMPT_PATH_COLOR brblue
end

if not set -q STACKED_PROMPT_BRANCH_COLOR
    set -gx STACKED_PROMPT_BRANCH_COLOR brgreen
end

if not set -q STACKED_PROMPT_TECH_COLOR
    set -gx STACKED_PROMPT_TECH_COLOR bryellow
end

if not set -q STACKED_PROMPT_BATTERY_COLOR
    set -gx STACKED_PROMPT_BATTERY_COLOR brred
end

if not set -q STACKED_PROMPT_BOX_COLOR
    set -gx STACKED_PROMPT_BOX_COLOR brwhite
end

if not set -q STACKED_PROMPT_ORDER
    set -gx STACKED_PROMPT_ORDER "path,git,tech"
end