# Changelog
All notable changes to this project will be documented in this file.

Since version 2.0.0, the format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Fixed
### Removed

## 2.0.2 - 2024-09-25
- COVERAGE:  55.56% -- 55/99 lines in 6 files
- BRANCH COVERAGE:  23.53% -- 4/17 branches in 6 files
- 25.00% documented
### Added
- More Documentation
### Fixed
- Incorrect Documentation
- Markdown Formatting
### Changed
- Renamed gem back to original `open_id_authentication`

## 2.0.1 - 2024-09-16 (returned to `open_id_authentication`)
- COVERAGE:  55.56% -- 55/99 lines in 6 files
- BRANCH COVERAGE:  23.53% -- 4/17 branches in 6 branches
### Added
- More Documentation
### Changed
- Renamed gem back to original `open_id_authentication`

## 2.0.0 - 2024-09-05 (released as `open_id_authentication2`)
- COVERAGE:  55.56% -- 55/99 lines in 6 files
- BRANCH COVERAGE:  23.53% -- 4/17 branches in 6 branches
### Added
- More specs
- version_gem runtime dependency
- rubocop-lts development dependency (linting)
- kettle-soup-cover development dependency (code coverage)
- Gem signing certificate
### Changed
- Upgraded to RSpec v3
- Switched rack-openid => rack-openid2
- Renamed gem to `open_id_authentication2`
### Fixed
- Compatibility with Ruby 2.7+
### Removed
- Support for Ruby < 2.7
- Undeclared dependency on Rails.logger
