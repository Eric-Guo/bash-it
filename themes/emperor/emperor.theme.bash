# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

SCM_THEME_PROMPT_DIRTY=" ${red?}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green?}|"

GIT_THEME_PROMPT_DIRTY=" ${red?}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
GIT_THEME_PROMPT_PREFIX=" ${green?}|"
GIT_THEME_PROMPT_SUFFIX="${green?}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

function get_hour_color {
	hour_color=${red?}
	min=$(date +%M)
	if [ "$min" -lt "15" ]; then
		hour_color=${white?}
	elif [ "$min" -lt "30" ]; then
		hour_color=${green?}
	elif [ "$min" -lt "45" ]; then
		hour_color=${yellow?}
	else
		hour_color=${red?}
	fi
	echo "$hour_color"
}

__emperor_clock() {
	THEME_CLOCK_COLOR=$(get_hour_color)
	clock_prompt
}

function prompt_command() {
	PS1="\n$(__emperor_clock)${purple?}\h ${reset_color?}in ${prompt_color?}\w\n${bold_cyan?}$(scm_char)${green?}$(scm_prompt_info) ${green?}→${reset_color?} "
}

THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%H "}

safe_append_prompt_command prompt_command
