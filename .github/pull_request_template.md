# Pull Request

## Description
<!--
Please include a summary of the change and which issue is fixed. Please also include relevant motivation and context.
-->

## Type of Change
<!-- Please check the one that applies to this PR using "x". -->
- [ ] 🆕 New Terraform Module
- [ ] ⬆️ Module Update/Enhancement
- [ ] 🐛 Bug Fix
- [ ] 📚 Documentation Update
- [ ] 🔧 Breaking Change
- [ ] 🧪 Test Updates

## Module Details
<!-- Please complete the following section if this PR includes module changes -->

### Module Path
<!-- Which module(s) are being modified? -->
```
modules/...
```

### Terraform Version Compatibility
- Minimum Terraform version required: 
- Tested Terraform versions:

### Provider Version Requirements
<!-- List any provider version requirements that have changed -->
- [ ] No provider version changes
- [ ] Provider version changes (please list):
  ```hcl
  provider "xxx" {
    version = ">= X.Y.Z"
  }
  ```

## Testing Completed
<!-- Please check all that apply -->
- [ ] `terraform init` successful
- [ ] `terraform plan` shows expected changes
- [ ] `terraform apply` successful
- [ ] Tested with dependent modules/configurations
- [ ] Added/updated module examples
- [ ] Added/updated module documentation

## Breaking Changes
<!-- If this PR contains breaking changes, please describe them and any mitigation steps -->
- [ ] No breaking changes
- [ ] Breaking changes (please describe):

## Release Information
<!-- This section helps with release workflow automation -->
- [ ] This change requires a version bump
- [ ] Suggested semantic version bump: (major/minor/patch)
- [ ] Added to CHANGELOG.md
- [ ] Added release notes

### Release Notes
<!-- If this PR requires a new release, please describe the changes that should be included in release notes -->
```release-note
NOTES:

FEATURES:

ENHANCEMENTS:

BUG FIXES:

BREAKING CHANGES:
```

## Documentation
<!-- Please check all that apply -->
- [ ] README.md updated
- [ ] Variable descriptions updated
- [ ] Output descriptions updated
- [ ] Example configurations updated
- [ ] Module documentation generated/updated

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing tests pass locally with my changes
- [ ] Any dependent changes have been merged and published in downstream modules