import 'package:app/common/widgets/custom_GNav.dart';
import 'package:app/config/config.dart';
import 'package:app/utils/Product.dart';
import 'package:app/views/home/screens/notification.dart';
import 'package:app/views/home/screens/userProfile.dart';
import 'package:app/views/home/widgets/List_of_products.dart';
import 'package:app/views/home/widgets/widget_home_categories.dart';
import 'package:app/views/home/widgets/widget_home_products.dart';
import 'package:app/views/upload/screens/uploagPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/globalvariable.dart';
import '../widgets/ProductCard.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homepage-screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GlobalVariables().init(context);
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          Config.appName,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Notifications.routeName, (route) => false);
              },
              icon: SvgPicture.asset('assets/images/Notification.svg'))
        ],
      ),

      body: ListView(
        children: [
          const HomeCategoriesWidget(),
          const HomeProductsWidget(),
          SizedBox(height: getProportionateScreenWidth(10)),
          SectionTitle(
            name: 'Stationary',
          ),
          SizedBox(height: getProportionateScreenWidth(10)),
          const ListOfProducts(),
          SectionTitle(name: 'Clothing'),
          SizedBox(height: getProportionateScreenWidth(10)),
          const ListOfProducts(),
        ],
      ),

      // body: const PostCard(
      //   username: 'username',
      //   profile_img: 'assets/images/kinmell_2.png',
      //   product_img: 'assets/images/Old Sterio.jpeg',
      //   price: 'Price',
      //   description: 'Here goes some description of the product',
      // ),

      // This is the bottom navigation bar
      bottomNavigationBar: const CustomGNavBar(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Material(
        color: GlobalVariables.backgroundColor,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                        const UserProfile() // Go to user profile page
                    )));
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(children: const [
              CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage('assets/images/kinmell_2.png'),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Name',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Text(
                'Address',
                style: TextStyle(fontSize: 16, color: Colors.white),
              )
            ]),
          ),
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.upload_rounded),
              title: const Text('Upload'),
              onTap: () {
                Navigator.pushNamed(context, '/uploadpage-screen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login-screen', (route) => false);
              },
            ),
          ],
        ),
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    GlobalVariables().init(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(18)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$name",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
