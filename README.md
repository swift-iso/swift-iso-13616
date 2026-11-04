# swift-iso-13616

Use this package when you need to check that an IBAN is well formed before you store it or send it on. Start from `ISO_13616.IBAN`. A value that passes is a valid IBAN, not proof that the account exists.

## Laws

- Input is either the electronic format, with no spaces, or the paper format: groups of four separated by single spaces, with a last group of one to four characters. Any other spacing is refused, including a trailing space.
- Only upper-case ASCII letters, digits and spaces are accepted. Lower-case text such as `nl91abna0417164300` is refused, not upper-cased.
- `ISO_13616.IBAN.value` always holds the electronic format, so the paper and electronic forms of one IBAN give equal values. `ISO_13616.IBAN.description` is the electronic format too, and `ISO_13616.IBAN.paper` regroups it in fours.
- The country must be one of the 89 in the package's registry table. That table fixes the length and the run of digits, letters or alphanumerics in the BBAN for each country.
- Check digits must be `02` to `98`. `00`, `01` and `99` are refused even when the MOD 97-10 sum would accept them.
- The checksum is ISO 7064 MOD 97-10 over the BBAN followed by the first four characters. It catches a changed digit and two transposed digits.
- Checks run in a fixed order: characters, spacing, country, length, check digits, BBAN structure, checksum. An IBAN with a correct checksum still fails if its length or BBAN structure is wrong for its country.
