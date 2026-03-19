function git-handoff-main --description "Rebase current branch onto main, let Codex resolve conflicts, then fast-forward main"
    set -l main_branch main

    # Ensure we're inside a git repo.
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Not inside a Git repository." >&2
        return 1
    end

    # Ensure worktree is clean enough for rebase/checkout.
    if not git diff --quiet --ignore-submodules --cached
        echo "Staged changes detected. Please commit or stash them first." >&2
        return 1
    end

    if not git diff --quiet --ignore-submodules
        echo "Unstaged changes detected. Please commit or stash them first." >&2
        return 1
    end

    # Determine current branch and verify it's not main.
    set -l feature_branch (git branch --show-current)

    if test -z "$feature_branch"
        echo "Could not determine current branch (detached HEAD?)." >&2
        return 1
    end

    if test "$feature_branch" = "$main_branch"
        echo "You are already on '$main_branch'. Run this from a feature branch." >&2
        return 1
    end

    echo "Feature branch: $feature_branch"
    echo "Rebasing onto $main_branch..."

    git rebase $main_branch
    set -l rebase_status $status

    if test $rebase_status -ne 0
        if test -d .git/rebase-merge -o -d .git/rebase-apply
            echo
            echo "Rebase has conflicts. Handing off to Codex..."
            echo

            codex exec \
                --model gpt-5.4 \
                --config model_reasoning_effort='"high"' \
                "You are in a Git repository with an in-progress 'git rebase $main_branch' on branch '$feature_branch'.
Resolve the current rebase conflicts."

            set -l codex_status $status
            if test $codex_status -ne 0
                echo "Codex exited with status $codex_status." >&2
                return $codex_status
            end

            if test -d .git/rebase-merge -o -d .git/rebase-apply
                echo "Rebase is still in progress after Codex. Please inspect manually." >&2
                return 1
            end

            if not git diff --quiet --ignore-submodules --cached
                echo "There are still staged changes after Codex. Please inspect manually." >&2
                return 1
            end

            if not git diff --quiet --ignore-submodules
                echo "There are still unstaged changes after Codex. Please inspect manually." >&2
                return 1
            end
        else
            echo "git rebase failed, but no in-progress rebase was detected." >&2
            return $rebase_status
        end
    end

    echo
    echo "Switching to $main_branch..."
    git switch $main_branch
    or return $status

    echo "Fast-forward merging $feature_branch into $main_branch..."
    git merge --ff-only $feature_branch
    or return $status

    echo
    echo "'$main_branch' now fast-forwarded to '$feature_branch'."

    echo
    echo "Deleting feature branch '$feature_branch'..."
    git branch -d $feature_branch
    or begin
        echo "Could not delete branch '$feature_branch' (not fully merged?). Keeping it." >&2
        return 1
    end

    echo
    echo "Done."
end
