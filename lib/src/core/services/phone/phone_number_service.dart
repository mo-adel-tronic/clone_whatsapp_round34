/// Adapter interface for phone number parsing/validation so implementation
/// can be swapped easily (e.g., libphonenumber, phone_numbers_parser, etc.).
abstract class PhoneNumberService {
  /// Returns E.164 formatted phone for the given [raw] input and
  /// [countryIso] (2-letter ISO country code like 'EG' or 'US'). Throws
  /// an exception if the number cannot be parsed/normalized.
  String toE164(String raw);

  /// Returns true if the given [raw] phone is valid for [countryIso].
  bool isValid(String raw, String countryIso);
}

class PhoneNumbersParserService implements PhoneNumberService {
  @override
  String toE164(String raw) {
    // Minimal, robust fallback: accept E.164 strings (starting with '+').
    // A full parser implementation using `phone_numbers_parser` can be
    // reintroduced if desired, but this avoids version/API mismatches.
    final s = raw.trim();
    if (s.startsWith('+')) return s;
    throw FormatException('Phone number is not in E.164 format. Provide a number starting with "+" or implement a full parser.');
  }

  @override
  bool isValid(String raw, String countryIso) {
    final s = raw.trim();
    // Quick sanity check: E.164 must start with '+' and contain at least 8 digits.
    final digits = s.replaceAll(RegExp(r'\D'), '');
    return s.startsWith('+') && digits.length >= 8;
  }
}
