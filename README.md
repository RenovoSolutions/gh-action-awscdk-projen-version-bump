# gh-action-awscdk-projen-version-bump
## Get latest AWS CDK release and update projen docker actions

This action gets the latest AWS CDK release version for a given major version of the AWS CDK and then updates the projects [projen](https://github.com/projen/projen) configuration to use this new version.

## Inputs

## `major-version`

**Required** The major version to get releases for.

## Outputs

## `build_conclusion`

`success` or `failure` for the build after upgrade

## `patch_created`

`true` if changes were made and a patch was created

## `previous_version`
The version of AWS CDK the projen file contained before this action was run.

## `new_version`
The version of AWS CDK the upgrade script changes the projen file to during this action.

## `patch_name`
The name of the patch created if a patch is created.

**Always** `.repo.patch`

## Example usage

```
uses: renovosolutions/gh-action-awscdk-projen-version-bump@v2
with:
  major-version: 2
```

## Notes

Be sure to run something like [`shellcheck`](https://github.com/koalaman/shellcheck) on the script when making changes.
