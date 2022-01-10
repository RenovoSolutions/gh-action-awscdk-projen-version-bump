# gh-action-awscdk-projen-version-bump
## Get latest AWS CDK release and update projen docker actions

This action gets the latest AWS CDK release version for a given major version of the AWS CDK and then updates the projects [projen](https://github.com/projen/projen) configuration to use this new version.

## Inputs

## `major-version`

**Required** The major version to get releases for.

## Example usage

```
uses: renovosolutions/gh-action-awscdk-projen-version-bump@v1
with:
  major-version: 2
```