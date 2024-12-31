import 'package:asset_tracker_app/localization/strings.dart';

enum CurrencyType {
  ALTIN,
  USDPURE,
  USDTRY,
  ONS,
  EURTRY,
  USDKG,
  EURUSD,
  EURKG,
  AYAR22,
  GBPTRY,
  CHFTRY,
  KULCEALTIN,
  AUDTRY,
  XAUXAG,
  CEYREK_YENI,
  CADTRY,
  CEYREK_ESKI,
  SARTRY,
  YARIM_YENI,
  YARIM_ESKI,
  JPYTRY,
  AUDUSD,
  TEK_YENI,
  TEK_ESKI,
  SEKTRY,
  ATA_YENI,
  DKKTRY,
  ATA_ESKI,
  NOKTRY,
  ATA5_YENI,
  USDJPY,
  ATA5_ESKI,
  GREMESE_YENI,
  GREMESE_ESKI,
  AYAR14,
  GUMUSTRY,
  XAGUSD,
  GUMUSUSD;

  String get displayName {
    switch (this) {
      case CurrencyType.ALTIN:
        return LocalStrings.altin;
      case CurrencyType.USDPURE:
        return LocalStrings.usdPure;
      case CurrencyType.USDTRY:
        return LocalStrings.usdTry;
      case CurrencyType.ONS:
        return LocalStrings.ons;
      case CurrencyType.EURTRY:
        return LocalStrings.eurTry;
      case CurrencyType.USDKG:
        return LocalStrings.usdKg;
      case CurrencyType.EURUSD:
        return LocalStrings.eurUsd;
      case CurrencyType.EURKG:
        return LocalStrings.eurKg;
      case CurrencyType.AYAR22:
        return LocalStrings.ayar22;
      case CurrencyType.GBPTRY:
        return LocalStrings.gbpTry;
      case CurrencyType.CHFTRY:
        return LocalStrings.chfTry;
      case CurrencyType.KULCEALTIN:
        return LocalStrings.kulceAltin;
      case CurrencyType.AUDTRY:
        return LocalStrings.audTry;
      case CurrencyType.XAUXAG:
        return LocalStrings.xauXag;
      case CurrencyType.CEYREK_YENI:
        return LocalStrings.ceyrekYeni;
      case CurrencyType.CADTRY:
        return LocalStrings.cadTry;
      case CurrencyType.CEYREK_ESKI:
        return LocalStrings.ceyrekEski;
      case CurrencyType.SARTRY:
        return LocalStrings.sarTry;
      case CurrencyType.YARIM_YENI:
        return LocalStrings.yarimYeni;
      case CurrencyType.YARIM_ESKI:
        return LocalStrings.yarimEski;
      case CurrencyType.JPYTRY:
        return LocalStrings.jpyTry;
      case CurrencyType.AUDUSD:
        return LocalStrings.audUsd;
      case CurrencyType.TEK_YENI:
        return LocalStrings.tekYeni;
      case CurrencyType.TEK_ESKI:
        return LocalStrings.tekEski;
      case CurrencyType.SEKTRY:
        return LocalStrings.sekTry;
      case CurrencyType.ATA_YENI:
        return LocalStrings.ataYeni;
      case CurrencyType.DKKTRY:
        return LocalStrings.dkkTry;
      case CurrencyType.ATA_ESKI:
        return LocalStrings.ataEski;
      case CurrencyType.NOKTRY:
        return LocalStrings.nokTry;
      case CurrencyType.ATA5_YENI:
        return LocalStrings.ata5Yeni;
      case CurrencyType.USDJPY:
        return LocalStrings.usdJpy;
      case CurrencyType.ATA5_ESKI:
        return LocalStrings.ata5Eski;
      case CurrencyType.GREMESE_YENI:
        return LocalStrings.gremeseYeni;
      case CurrencyType.GREMESE_ESKI:
        return LocalStrings.gremeseEski;
      case CurrencyType.AYAR14:
        return LocalStrings.ayar14;
      case CurrencyType.GUMUSTRY:
        return LocalStrings.gumusTry;
      case CurrencyType.XAGUSD:
        return LocalStrings.xagUsd;
      case CurrencyType.GUMUSUSD:
        return LocalStrings.gumusUsd;
    }
  }

  String get symbol {
    switch (this) {
      case CurrencyType.USDTRY:
      case CurrencyType.USDPURE:
      case CurrencyType.USDKG:
      case CurrencyType.AUDUSD:
      case CurrencyType.GUMUSUSD:
        return '\$';
      case CurrencyType.EURTRY:
      case CurrencyType.EURUSD:
      case CurrencyType.EURKG:
        return '€';
      case CurrencyType.GBPTRY:
        return '£';
      case CurrencyType.JPYTRY:
      case CurrencyType.USDJPY:
        return '¥';
      default:
        return '₺';
    }
  }

  bool get isGold {
    return [
      CurrencyType.ALTIN,
      CurrencyType.KULCEALTIN,
      CurrencyType.CEYREK_YENI,
      CurrencyType.CEYREK_ESKI,
      CurrencyType.YARIM_YENI,
      CurrencyType.YARIM_ESKI,
      CurrencyType.TEK_YENI,
      CurrencyType.TEK_ESKI,
      CurrencyType.ATA_YENI,
      CurrencyType.ATA_ESKI,
      CurrencyType.ATA5_YENI,
      CurrencyType.ATA5_ESKI,
      CurrencyType.GREMESE_YENI,
      CurrencyType.GREMESE_ESKI,
      CurrencyType.AYAR14,
      CurrencyType.AYAR22,
    ].contains(this);
  }
}
