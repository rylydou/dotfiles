# Keep git-cloned custom plugins/themes up to date.
#
# `omz update` only refreshes Oh My Zsh itself, not the repos under
# $ZSH_CUSTOM. This mirrors OMZ's own reminder cadence: at most once every
# UPDATE_DAYS, in the background, so shell startup is never blocked.

() {
  setopt localoptions extended_glob
  local update_days=${UPDATE_ZSH_DAYS:-7}
  local stamp="${ZSH_CACHE_DIR:-$ZSH/cache}/.custom-plugin-update"

  [[ -d ${stamp:h} ]] || mkdir -p ${stamp:h}

  # Skip if the stamp file was touched within the last $update_days days.
  local -a recent=( $stamp(#qN.md-${update_days}) )
  (( $#recent )) && return
  touch $stamp

  {
    local repo
    for repo in $ZSH_CUSTOM/plugins/*/.git(N/) $ZSH_CUSTOM/themes/*/.git(N/); do
      git -C ${repo:h} pull --quiet --ff-only 2>/dev/null
    done
  } &!
}
