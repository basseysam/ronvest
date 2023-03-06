
import 'package:flutter/material.dart';
import 'package:ronvest/app/views/widgets/touchables/touchable_opacity.dart';

import '../../../core/constants/app_asset.dart';
import '../../styles/app_colors.dart';
import '../../styles/fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Navigator.canPop(context)
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TouchableOpacity(
                onTap: () => Navigator.pop(context),
                child: Center(
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Color(0xffededed),
                      shape: BoxShape.circle
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Center(
                        child: Icon(Icons.arrow_back_ios, size: 10, color: Color(0xff959595),),
                      ),
                    ),
                    /*child: Center(
                      child: Image.asset(
                        //AppAsset.arrowBackIcon,
                        width: 8,
                        height: 4,
                      ),
                    ),*/
                  ),
                ),
              ),
            )
          : const SizedBox(),
      title: title != null
          ? TextSemiBold(
              title!,
              fontSize: 16,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : const SizedBox(),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
