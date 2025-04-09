# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

# Inretio theme for Bash-it
# Contact: bashit@inretio.eu

# Inspired by existing themes:
# - metal
# - bobby

# virtualenv prompts
VIRTUALENV_CHAR=" ⓔ"
VIRTUALENV_THEME_PROMPT_PREFIX=""
VIRTUALENV_THEME_PROMPT_SUFFIX=""

# SCM prompts
SCM_NONE_CHAR=""
SCM_GIT_CHAR="[±] "
SCM_GIT_BEHIND_CHAR="${red?}↓${normal?}"
SCM_GIT_AHEAD_CHAR="${bold_green?}↑${normal?}"
SCM_GIT_UNTRACKED_CHAR="⌀"
SCM_GIT_UNSTAGED_CHAR="${bold_yellow?}•${normal?}"
SCM_GIT_STAGED_CHAR="${bold_green?}+${normal?}"

SCM_THEME_PROMPT_DIRTY=""
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

# Git status prompts
GIT_THEME_PROMPT_DIRTY=" ${red?}✗${normal?}"
GIT_THEME_PROMPT_CLEAN=" ${bold_green?}✓${normal?}"
GIT_THEME_PROMPT_PREFIX=""
GIT_THEME_PROMPT_SUFFIX=""

# ICONS =======================================================================

icon_start="┌──"
icon_user=" 🐧 "
icon_host=" 💻 "
icon_directory=" 📂 "
icon_branch="🌵"
icon_end="└> "

# extra spaces ensure legiblity in prompt

# FUNCTIONS ===================================================================

# Display virtual environment info
function _virtualenv_prompt {
	VIRTUALENV_DETAILS=""
	VIRTUALENV_CHAR=""

	# $VIRTUAL_ENV is set and is non-zero length
	if [[ -n "$VIRTUAL_ENV" ]]; then
		# Check if Python 3 exists
		if command -v python3 > /dev/null 2>&1; then
			VIRTUALENV_DETAILS="$("$VIRTUAL_ENV/bin/python" --version | sed 's,Python ,,') on [$(basename "$VIRTUAL_ENV")]"
			VIRTUALENV_CHAR=" 🐍"
		else
			VIRTUALENV_DETAILS="[$(basename "$VIRTUAL_ENV")]"
			VIRTUALENV_CHAR=" ⓔ"
		fi
	fi

	echo "$VIRTUALENV_CHAR $VIRTUALENV_DETAILS"
}

# Rename tab
function tabname {
	printf "\e]1;%s\a" "$1"
}

# Rename window
function winname {
	printf "\e]2;%s\a" "$1"
}

_theme_clock() {
	printf '[%s]' "$(clock_prompt)"

	if [ "${THEME_SHOW_CLOCK_CHAR}" == "true" ]; then
		printf '%s' "$(clock_char) "
	fi
}
THEME_SHOW_CLOCK_CHAR=${THEME_SHOW_CLOCK_CHAR:-"false"}
THEME_CLOCK_CHAR_COLOR=${THEME_CLOCK_CHAR_COLOR:-"$red"}
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$normal"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%Y-%m-%d %H:%M:%S"}

# PROMPT OUTPUT ===============================================================

# Displays the current prompt
function prompt_command() {
	PS1="\n${icon_start}$(_theme_clock)${normal}${green?}$(_virtualenv_prompt)${normal}${icon_directory}${bold_purple?}\W${normal}\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on ${icon_branch} $(scm_prompt_info) \")${white?}${normal}\n${icon_end}"
	PS2="${icon_end}"
}

# Runs prompt (this bypasses bash_it $PROMPT setting)
safe_append_prompt_command prompt_command
