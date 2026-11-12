import '../../features/auth/pages/login_page.dart';
import '../../features/cards/pages/cards_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/onboard/pages/onboard_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/statistics/pages/statistics_page.dart';
import '../../features/transactions/pages/transactions_page.dart';
import '../../features/transfer/pages/transfer_page.dart';

/// Single registry of every screen. Navigate with `Go.to(context, Pager.x)`.
class Pager {
  Pager._();

  static const splash = SplashPage();
  static const onboard = OnboardPage();
  static const login = LoginPage();
  static const main = MainPage();

  // Bottom nav tabs
  static const home = HomePage();
  static const cards = CardsPage();
  static const statistics = StatisticsPage();
  static const profile = ProfilePage();

  // Pushed screens
  static const transfer = TransferPage();
  static const transactions = TransactionsPage();
}
