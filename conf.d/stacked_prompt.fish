# Stacked Prompt initialization
# This file is automatically loaded when Fish starts

# Initialize stacked prompt variables
set -g _stacked_prompt_initialized true

# Set up default colors for the stacked prompt
# These can be overridden by the user after installation
if not set -q STACKED_PROMPT_PATH_ROOT_COLOR
    set -gx STACKED_PROMPT_PATH_ROOT_COLOR magenta
end

if not set -q STACKED_PROMPT_PATH_RELATIVE_COLOR
    set -gx STACKED_PROMPT_PATH_RELATIVE_COLOR white
end

if not set -q STACKED_PROMPT_BRANCH_COLOR
    set -gx STACKED_PROMPT_BRANCH_COLOR green
end

if not set -q STACKED_PROMPT_TECH_COLOR_MODS
    set -gx STACKED_PROMPT_TECH_COLOR_MODS brblack
end

if not set -q STACKED_PROMPT_TECH_COLOR_LANGS
    set -gx STACKED_PROMPT_TECH_COLOR_LANGS brblack
end

if not set -q STACKED_PROMPT_BATTERY_COLOR
    set -gx STACKED_PROMPT_BATTERY_COLOR brred
end

if not set -q STACKED_PROMPT_BOX_COLOR
    set -gx STACKED_PROMPT_BOX_COLOR brblack
end

if not set -q STACKED_PROMPT_ORDER
    set -gx STACKED_PROMPT_ORDER "path,git,tech_stack_langs,tech_stack_mods"
end
