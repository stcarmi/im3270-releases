# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in IM3270, please report it privately:

- **Email:** security@infomanta.com
- **GitHub:** [Open a private security advisory](https://github.com/Infomanta/im3270-releases/security/advisories/new)

We aim to acknowledge reports within **3 business days** and to provide a remediation plan or fix within **30 days** for confirmed issues, depending on severity.

Please **do not** report security issues via public GitHub Issues, support tickets, or social media until we have published a fix.

## Verifying Releases

Every release in this repository is published with:

- `SHA256SUMS` — SHA-256 checksums for all release assets
- `SHA256SUMS.asc` — GPG detached signature of `SHA256SUMS`

The signing key is the **IM3270 Release Signing Key** (`4E7EEAFA0DA1939EF2A629CF71D341D31DEF7FFA`). Import it from:

- https://im3270.infomanta.com/keys/im3270-release.asc

Verification:

```bash
# Import the public key once
curl -sL https://im3270.infomanta.com/keys/im3270-release.asc | gpg --import

# Verify checksums
gpg --verify SHA256SUMS.asc SHA256SUMS

# Verify your downloaded files
sha256sum -c SHA256SUMS --ignore-missing
```

Do not install or run a release whose `SHA256SUMS.asc` does not verify, or whose files do not match `SHA256SUMS`.

## Supported Versions

Security fixes are issued for the **latest released minor version**. Older minor versions are best-effort. The current supported version is published at the top of [the releases page](https://github.com/Infomanta/im3270-releases/releases).

## Disclosure

We follow coordinated disclosure. Once a fix is released, we publish a [GitHub Security Advisory](https://github.com/Infomanta/im3270-releases/security/advisories) with credit (if you wish), affected versions, mitigations, and the fixed version.
