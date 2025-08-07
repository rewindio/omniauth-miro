# Changelog

## [1.0.6]

- Update Ruby version to 3.4.5 to address security vulnerabilities

## [1.0.5]

- Address CVE-2025-49007
- Update dependencies

## [1.0.4]

- Address CVE-2025-27221 by updating uri to 1.0.3
- Update other dependencies to their respective latest minor versions

## [1.0.3]

- Remove overwritten callback_phase method that skipped refresh_token existence check

## [1.0.2]

- Update uid to use organization id id
- Added token response into omniauth hash
- Overwrite callback_phase method to not fail upon missing refresh token

## [1.0.1]

- Bugfix: added client secret to token params request
- Updated to full url for context endpoint

## [1.0.0]

- New omniauth-miro strategy for Miro OAuth 2.0
