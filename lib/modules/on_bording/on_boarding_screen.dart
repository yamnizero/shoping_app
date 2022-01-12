import 'package:flutter/material.dart';
import 'package:shoping_app/modules/shopping_app/login/shop_login.dart';
import 'package:shoping_app/shared/color/colors.dart';
import 'package:shoping_app/shared/components/compones.dart';
import 'package:shoping_app/shared/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardModel
{
  final String image;
  final String title;
  final String body;

  BoardModel({required this.image, required this.title, required this.body});
}
class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
 late  List<BoardModel> list ;

  @override
  void initState()
  {
    super.initState();

    list =
    [
      BoardModel(
        image: 'assets/images/onboard1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body',
      ),
      BoardModel(
        image: 'assets/images/onboard1.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body',
      ),
      BoardModel(
        image: 'assets/images/onboard1.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body',
      ),
    ];
  }

  var isLast = false;
  final controller = PageController();

  void submit()
  {
    CacheHelper.saveData(
      key: 'onBoarding', value: true,
    ).then((value) {
      if(value){
        navigateAndFinish(
          context,
          const ShopLoginScreen(),
        );
      }
    });

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip'
          ,)
        ],
      ),
      body: Column(
        children: <Widget>
        [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i)
                {
                  if (i == (list.length - 1) && !isLast)
                    setState(() => isLast = true);
                  else if (isLast) setState(() => isLast = false);
                },
                controller: controller,
                itemCount: list.length,
                itemBuilder: (ctx, i) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Image(
                        image: AssetImage(
                          list[i].image,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      list[i].title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: defaultColor,
                      ),
                    ),
                    const  SizedBox(height: 15.0),
                    Text(
                      list[i].body,
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: defaultColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SmoothPageIndicator(
                  controller: controller,
                  effect:const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: list.length,
                ),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if (isLast)
                    {
                      submit();
                    } else
                       controller.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

