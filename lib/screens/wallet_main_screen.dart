import 'package:MetaBit/helpers/shared_value_helper.dart';
import 'package:MetaBit/my_theme.dart';
import 'package:MetaBit/screens/wallet.dart';
import 'package:MetaBit/screens/wishlist/widgets/page_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletMainScreen extends StatelessWidget {
  const WalletMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                app_language_rtl.$!
                    ? CupertinoIcons.arrow_right
                    : CupertinoIcons.arrow_left,
                color: MyTheme.dark_font_grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.my_wallet_ucf,
            style: TextStyle(
              fontSize: 16,
              color: MyTheme.dark_font_grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          titleSpacing: 0,
        ),
        body: Column(
          children: [
            TabBar(
              labelColor: Color(0xff1574B4),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xff1574B4),
              tabs: [
                CustomTab(icon: Icons.wallet, title: 'Dollars Wallets'),
                CustomTab(
                  icon: Icons.wallet_membership,
                  title: 'Electronic Wallet',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Physical Coins List
                  CoinsListView(
                    coins: [
                      Coin(
                        imageUrl: 'https://pngimg.com/d/dollar_sign_PNG3.png',
                        title: 'Dollar Coin',
                        description: 'United States Dollar Coin',
                        balance: '\$150',
                        lastRecharge: '\$50',
                      ),
                      Coin(
                        imageUrl:
                            'https://uxwing.com/wp-content/themes/uxwing/download/e-commerce-currency-shopping/brazil-real-coin-solid-icon.png', // Replace with real URL
                        title: 'Real Coin',
                        description: 'Brazilian Real Coin',
                        balance: 'R\$200',
                        lastRecharge: 'R\$100',
                      ),
                    ],
                  ),
                  // Digital Coins List
                  CoinsListView(
                    coins: [
                      Coin(
                        imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png', // Replace with real URL
                        title: 'Bitcoin',
                        description: 'Popular cryptocurrency',
                        balance: '0.05 BTC',
                        lastRecharge: '0.01 BTC',
                      ),
                      Coin(
                        imageUrl:
                            'https://img.money.com/2022/01/Explainer-What-Is-Ethereum.jpg', // Replace with real URL
                        title: 'Ethereum',
                        description: 'Second most popular cryptocurrency',
                        balance: '2 ETH',
                        lastRecharge: '0.5 ETH',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Coin Model
class Coin {
  final String imageUrl;
  final String title;
  final String description;
  final String balance;
  final String lastRecharge;

  Coin({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.balance,
    required this.lastRecharge,
  });
}

// Coins ListView Widget
class CoinsListView extends StatelessWidget {
  final List<Coin> coins;
  const CoinsListView({required this.coins, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(context, PageAnimation.fadeRoute(Wallet()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Coin Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        coin.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Coin Details
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coin.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 230,
                            child: Text(
                              coin.description,
                              style: TextStyle(
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            coin.balance,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            coin.lastRecharge,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 25),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
