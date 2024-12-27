# Upgrading Guide

This document describes how to upgrade this fork with upstream changes while maintaining your custom modifications.

## Prerequisites

Ensure your repository is configured with both remotes:

```bash
# Check current remotes
git remote -v

# If upstream is not set up, add it
git remote add upstream https://github.com/neutron-org/neutron
```

## Upgrade Process

Follow these steps whenever you want to incorporate upstream changes (e.g., when a new version is released):

1. Fetch the latest changes and tags from upstream:

   ```bash
   git fetch upstream --tags
   ```

2. Update your main branch with the upstream changes:

   ```bash
   # Switch to main branch
   git checkout main

   # If updating to a specific version tag (e.g., v5.0.6)
   git merge v5.0.6

   # OR if updating to latest main
   git merge upstream/main
   ```

3. Merge the changes into your feature branch:

   ```bash
   # Switch to your feature branch
   git checkout multiple_vals

   # Merge the updated main branch
   git merge main
   ```

4. Resolve any merge conflicts if they appear:

   - Open each conflicted file and resolve the conflicts
   - Look for sections marked with `<<<<<<`, `=======`, and `>>>>>>>`
   - After resolving each file:
     ```bash
     git add <resolved-file>
     ```
   - Once all conflicts are resolved:
     ```bash
     git merge --continue
     ```

5. Create a new tag for your custom version (optional):

   ```bash
   # If upstream released v5.0.6, you might want to create v5.0.6-mk
   git tag v5.0.6-mk
   ```

6. Push your changes:

   ```bash
   # Push your new tag
   git push origin v5.0.6-mk

   # Push your updated branch
   git push origin multiple_vals
   ```

## Troubleshooting

If something goes wrong during the merge process:

1. You can abort the merge and start over:

   ```bash
   git merge --abort
   ```

2. If you need to return to a previous state:

   ```bash
   # Create a backup branch before attempting the upgrade
   git branch backup-multiple-vals multiple_vals

   # If needed, return to backup
   git checkout backup-multiple-vals
   ```

## Notes

- Always make sure your working directory is clean before starting the upgrade process
- Consider creating a backup branch before major upgrades
- Keep track of which upstream versions you've merged with by maintaining a consistent tag naming scheme (e.g., `v5.0.6-mk`)
- If you encounter persistent issues, you can always check your branch's merge base with:
  ```bash
  git merge-base multiple_vals main
  ```

## Support

If you encounter any issues during the upgrade process:

1. Check the project's documentation
2. Review the git log to understand where divergence might have occurred:
   ```bash
   git log --graph --oneline --all
   ```
3. Reach out to the project maintainers if necessary
