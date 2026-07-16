function reset-worktree --description 'Reset a clean detached Git worktree to main'
    if not command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo 'error: not inside a Git worktree' >&2
        return 1
    end

    if command git symbolic-ref --quiet HEAD >/dev/null 2>&1
        echo 'error: HEAD is not detached' >&2
        return 1
    end

    set -l pending_changes (command git status --porcelain=v1 --untracked-files=all)
    if test $status -ne 0
        echo 'error: could not inspect worktree status' >&2
        return 1
    end

    if test -n "$pending_changes"
        echo 'error: worktree has pending changes' >&2
        return 1
    end

    command git reset --hard main
    or return $status

    command npm ci --prefer-offline --no-audit
end
