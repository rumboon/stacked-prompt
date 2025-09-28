# Stacked Prompt

A modular Fish shell prompt that displays information in a clean, stacked format.

## Features

- Clean box-style layout for git repositories
- Simple path display for non-git directories
- Integrates with stack modules for enhanced functionality
- Color-coded prompt indicator based on exit status

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install rumboon/stacked-prompt
```

## Optional Stack Modules

For enhanced functionality, install these optional stack modules:

```fish
# Technology detection
fisher install rumboon/tech-stack

# Git status information
fisher install rumboon/git-stack

# Battery information
fisher install rumboon/battery-stack
```

## Layout

### Git Repository
```
[battery info if < 50%]

┌─ project-name/path
├─ main (✓)
└─ tech: Node.js 18.0.0, TypeScript 4.8.0
❯
```

### Regular Directory
```
[battery info if < 50%]
~/path/to/directory
❯
```

## Functions

- `stacked_prompt` - Main prompt function
- `fish_prompt` - Fish shell integration wrapper

## Customization

The prompt uses standard Fish color variables and can be customized by modifying the color definitions in the `stacked_prompt` function.
