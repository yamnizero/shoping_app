import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shoping_app/model/favorites/fav_model.dart';
import 'package:shoping_app/modules/shopping_app/login/shop_login.dart';
import 'package:shoping_app/shared/color/colors.dart';
import 'package:shoping_app/shared/local/cache_helper.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 10.0,
  required String text,
  bool isUpper = true,
  Color background = Colors.blue,
  required Function() function,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: FlatButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) => TextButton(
    onPressed: function,
    child:  Text(text)
);


Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  required String? Function(String?)? validation,
  bool isPassword = false,
  required String label,
  required IconData prefix,
   IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validation ,
      onFieldSubmitted: (s)
      {
        onSubmit!(s);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,

        suffixIcon:IconButton(
          onPressed:suffixPressed,
          icon: Icon(
            suffix,
          ),
        ),
        prefixIcon: Icon(
          prefix,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

Widget buildSeparator() => Container(
  height: 1.0,
  width: double.infinity,
  color: Colors.grey[300],
);

void showToast({
  required String text,
  required ToastStates states,
}) =>  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(states),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARING}

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARING:
      color = Colors.amber;
      break;
  }
  return color;
}

void singOut(context){
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

Widget buildListProduct(model,context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120.0,
    child: Row(
      children:  [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              width: 120.0,
              height: 120.0,
            ),
            if(model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: const  TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(width: 5.0,),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                      //print(model.id);
                    },
                    icon:  CircleAvatar(
                      radius: 15,
                      backgroundColor:
                      ShopCubit.get(context).favorites[model.id]!
                          ? Colors.red
                          : Colors.grey,
                      child: const  Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

