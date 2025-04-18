class LocalStrings {
  //onBoard view Screens
//1
  static const trackAssetsTitle = 'Track Your Assets';
  static const trackAssetsDescription =
      'Easily manage and track all your assets in one place';

//2
  static const realTimeTitle = 'Real-time Display';
  static const realTimeDescription =
      'View the status of your assets and how much profit or loss you have made';

//3
  static const analyticsTitle = 'Detailed Analytics';
  static const analyticsDescription =
      'View comprehensive reports and analytics';

//onBoard view button
  static const getStartedButton = 'Get Started';
  static const nextButton = 'Next';

//login screen
  static const enterPassword = 'Please enter your password';
  static const atLeast6characters = 'Password must be at least 6 characters';
  static const passwordLabel = 'Password';
  static const enterEmail = 'Please enter your email address.';
  static const enterValidEmail = 'Enter a valid email address.';
  static const emailLabel = 'Email';
  static const welcome = 'Welcome';
  static const signIn = 'Sign In';
  static const signUp = 'Sign Up';
  static const alreadyHaveAcc = 'Already have an account? Sign In';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const pleaseEnterYourName = 'Please enter your name';
  static const nameAtLeast2Characters = 'Name must be at least 2 characters';
  static const dontHaveAcc = 'Don\'t have an account? Sign Up';

  //splash screen
  static const appLabel = 'Asset Tracker';

  //firebase errors
  static const userNotFound = 'No users registered with this email.';
  static const wrongPassword = 'You entered an incorrect password.';
  static const userDisabled = 'This account has been deactivated.';
  static const invalidEmail = 'Invalid email address.';
  static const invalidCredential = 'Email or password incorrect.';
  static const tooManyRequests =
      'You have made too many failed login attempts. Please try again later.';
  static const defaultError = 'An error occurred: ';
  static const loginError = 'There was an error logging in. Please try again.';
  static const signupError =
      'There was an error during signup. Please try again.';
  static const weakPassword =
      'The password is too weak. Use at least 6 characters.';
  static const emailAlreadyinUse = 'This email address is already in use.';
  static const operationNotAllowed = 'Email/password login is not active.';

  //home screen
  static const homeLabelNavBar = 'Home';
  static const profileLabelNavBar = 'Profile';
  static const haremAltinTableSatis = 'Satis';
  static const lastUpdate = 'Last Update: ';
  static const searchFieldHintText = 'Search assets...';
  static const buy = 'Alış';
  static const sell = 'Satış';

  //WebSocketErrors
  static const webSocketStreamError = 'WebSocket stream error: ';
  static const webSocketConnectionClosed = 'WebSocket connection closed';
  static const webSocketConnectionError = 'WebSocket connection error: ';
  static const webSocketMaxReconnectionAttempts =
      'Maximum reconnection attempts reached';
  static const webSocketReconnectDelay = 'Reconnect delay: ';
  static const webSocketReconnectAttempts =
      'Attempting to reconnect... Attempt: ';

  //harem_altin_bloc error
  static const haremAltinDataConversionError = 'Veri dönüşüm hatası: ';

  //harem_altin CurrencyTypes

  static const altin = 'Altın';
  static const usdPure = 'Ham Dolar';
  static const usdTry = 'Dolar';
  static const ons = 'Ons';
  static const eurTry = 'Euro';
  static const usdKg = 'Dolar/KG';
  static const eurUsd = 'Euro/Dolar';
  static const eurKg = 'Euro/KG';
  static const ayar22 = '22 Ayar Bilezik';
  static const gbpTry = 'Sterlin';
  static const chfTry = 'İsviçre Frangı';
  static const kulceAltin = 'Külçe Altın';
  static const audTry = 'Avustralya Doları';
  static const xauXag = 'Altın/Gümüş Oranı';
  static const ceyrekYeni = 'Çeyrek Altın (Yeni)';
  static const cadTry = 'Kanada Doları';
  static const ceyrekEski = 'Çeyrek Altın (Eski)';
  static const sarTry = 'Suudi Arabistan Riyali';
  static const yarimYeni = 'Yarım Altın (Yeni)';
  static const yarimEski = 'Yarım Altın (Eski)';
  static const jpyTry = 'Japon Yeni';
  static const audUsd = 'Avustralya Doları/Dolar';
  static const tekYeni = 'Tam Altın (Yeni)';
  static const tekEski = 'Tam Altın (Eski)';
  static const sekTry = 'İsveç Kronu';
  static const ataYeni = 'Ata Altın (Yeni)';
  static const dkkTry = 'Danimarka Kronu';
  static const ataEski = 'Ata Altın (Eski)';
  static const nokTry = 'Norveç Kronu';
  static const ata5Yeni = '5\'li Ata Altın (Yeni)';
  static const usdJpy = 'Dolar/Japon Yeni';
  static const ata5Eski = '5\'li Ata Altın (Eski)';
  static const gremeseYeni = 'Gremese Altın (Yeni)';
  static const gremeseEski = 'Gremese Altın (Eski)';
  static const ayar14 = '14 Ayar Altın';
  static const gumusTry = 'Gümüş';
  static const xagUsd = 'Gümüş/Dolar';
  static const gumusUsd = 'Gümüş USD';

  //profile_view
  static const transactionHistoryLabel = 'Transaction History';
  static const profileLabel = 'Profile';
  static const addAssetError = 'Varlık eklenirken hata oluştu: ';
  static const deleteAssetError = 'Varlık silinirken hata oluştu: ';
  static const totalAssetValue = 'Toplam Varlık Değeri';
  static const assetDistribution = 'Varlık Dağılımı';
  static const myAssets = 'Varlıklarım';
  static const pieChartTitle = 'Varlık Dağılımı (Pasta Grafik)';
  static const barChartTitle = 'Varlık Değerleri (Çubuk Grafik)';
  static const totalValue = 'Toplam Değer:';
  static const piece = 'adet';
  static const details = 'Detaylar';
  static const retry = 'Tekrar Dene';
  static const historyTooltip = 'İşlem Geçmişi';
  static const logoutTooltip = 'Çıkış Yap';
  static const currentlyLabel = 'Şimdi:';
  static const purchaseLabel = 'Alış:';
  static const noUserFoundError =
      'Oturum açmış kullanıcı bulunamadı. Lütfen yeniden giriş yapın.';
  static const close = 'Kapat';
  static const logoutConfirmation = 'Çıkış yapmak istediğinizden emin misiniz?';
  static const logoutSuccess = 'Başarıyla çıkış yapıldı';
  static const logoutError = 'Çıkış yapma hatası: ';
  static const logoutGeneralError = 'Çıkış yaparken bir hata oluştu: ';

  //add_asset_form
  static const assetType = 'Varlık Tipi';
  static const assetAmount = 'Miktar';
  static const enterAmount = 'Lütfen miktar girin';
  static const enterValidAmount = 'Geçerli bir miktar girin';
  static const selectType = 'Lütfen bir varlık tipi seçin';
  static const assetPurchasePrice = 'Alış Fiyatı';
  static const enterAssetPrice = 'Lütfen alış fiyatı girin';
  static const enterValidAssetPrice = 'Geçerli bir fiyat girin';
  static const purchaseDate = 'Alım Tarihi';
  static const selectDate = 'Tarih Seçin';
  static const add = 'Ekle';
  static const pleaseSelectDate = 'Lütfen bir tarih seçin';
  static const assetAddedSuccessfully = 'Varlık başarıyla eklendi';
  static const errorOccurred = 'Hata oluştu: ';
  static const smthWentWrongError =
      "Bir şeyler yanlış gitti. Lütfen daha sonra tekrar deneyin.";
  static const unableToLoadAssetsError =
      "Varlıklar yüklenemiyor. Lütfen tekrar deneyin.";
  static const noAssetsAddedYet = 'Henüz varlık eklenmedi.';

  //my_assets_card
  static const amount = 'Miktar: ';
  static const purchasePrice = 'Alış Fiyatı: ';
  static const purchaseDateLabel = 'Alım Tarihi: ';
  static const deleteAsset = 'Varlığı Sil';
  static const deleteAssetConfirmation =
      ' varlığını silmek istediğinize emin misiniz?';
  static const cancel = 'İptal';
  static const assetDeletedSuccessfully = 'Varlık başarıyla silindi';
  static const assetCurrentValue = "Güncel Değer: ";
  static const profitLoss = 'Kar/Zarar: ';
  static const deleteAssetFailed = 'Varlık silme başarısız: ';
  static const delete = 'Sil';
}
