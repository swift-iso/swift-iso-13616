# swift-iso-13616

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Swift implementation of ISO 13616, the international bank account number (IBAN).

## Overview

`ISO_13616.IBAN` has one initializer, and it validates: the country must be in the ISO 13616-2 registry, the account number (BBAN) must have the structure and length the registry fixes for that country, and the check digits must satisfy ISO 7064 MOD 97-10. Both the electronic format and the paper format (groups of four) are accepted; the value is kept in electronic format.

```swift
import ISO_13616

let iban = try ISO_13616.IBAN("NL91 ABNA 0417 1643 00")
iban.value    // "NL91ABNA0417164300"
iban.country  // "NL"
iban.bban     // "ABNA0417164300"
```

## The registry

The BBAN structures for the 89 registered countries were transcribed in October 2026 from two public copies of the registry SWIFT publishes as the ISO 13616 registration authority: Wikipedia's IBAN formats table and the php-iban registry. The copies agree for 85 countries. For `QA` they differ, and the looser structure is kept; `FK`, `LY`, `MN` and `SO` appear in one copy only. See issue #1 for checking the table against a cited registry release.

A well-formed IBAN is not necessarily an account that exists.

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
