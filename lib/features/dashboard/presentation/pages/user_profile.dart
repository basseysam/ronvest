import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ronvest/core/constants/constants.dart';
import 'package:ronvest/core/core.dart';

import '../../../../app/styles/app_colors.dart';
import '../../../../app/views/widgets/touchables/touchable_opacity.dart';
import '../../../../core/injections/injection_container.dart';
import '../../../auth/presentation/provider/auth_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final res =  sl<AuthProvider>().userEntity;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text("User's Profile", style: TextStyle(
          fontSize: 18,
          fontFamily: AppFonts.nunitoSansRegular,
          fontStyle: FontStyle.italic,
        ),),
        leading: TouchableOpacity(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: AppColors.primaryColor,)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.37,
            width: MediaQuery.of(context).size.width,
            color: AppColors.secondaryColor,
            child: Column(
              children: [
                const Gap(20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl:
                    "${res!.user_info.avater}",
                    height: 100,
                    width: 100,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        SvgPicture.asset(
                          'assets/icons/ronvest.svg',
                          height: 100,
                          width: 100,
                        ),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset(
                          'assets/icons/ronvest.svg',
                          height: 100,
                          width: 100,
                        ),
                  ),
                ),

                const Gap(10),
                 Text(res!.user_info.full_name.capitalize, style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.nunitoSansRegular,
                  fontStyle: FontStyle.italic,
                ),),
                 Text("@${res!.user_info.username}", style: TextStyle(
                  fontSize: 16,
                  color: AppColors.iconGray,
                  fontFamily: AppFonts.nunitoSansRegular,
                  fontStyle: FontStyle.italic,
                ),),
                const Text("Member since Jan, 2022", style: TextStyle(
                  fontSize: 16,
                  color: AppColors.iconGray,
                  fontFamily: AppFonts.nunitoSansRegular,
                ),),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                    color: const Color(0xffD8E9F1),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                          children: const [
                              Text('4', style: TextStyle(
                                fontSize: 22,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff253E4A),
                                fontWeight: FontWeight.w700,
                              ),),
                              Text('Challenges started', textAlign: TextAlign.center ,style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff676767),
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),),
                          ],
                        ),
                            )),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                          children: const [
                              Text('1', style: TextStyle(
                                fontSize: 22,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff253E4A),
                                fontWeight: FontWeight.w700,
                              ),),
                              Text('Challenges won', style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff676767),
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),),
                          ],
                        ),
                            )),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                          children: const [
                              Text('1', style: TextStyle(
                                fontSize: 22,
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff253E4A),
                                fontWeight: FontWeight.w700,
                              ),),
                              Text('Active Plan', style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff676767),
                                fontFamily: AppFonts.nunitoSansRegular,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),),
                          ],
                        ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Gap(10),
                    const Text("Public challenges", style: TextStyle(
                      fontSize: 16,
                      color: AppColors.iconGray,
                      fontFamily: AppFonts.nunitoSansRegular,
                    ),),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor, width: 0.5)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/beach.png', width: 79, height: 88,),
                              const Gap(10),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Vacation savings', style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      Text('Let’s saving for a December vacation in Dubai.', style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      Gap(5),
                                      Text('Started by James A., 3 days ago.', style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ],
                                  )
                              )
                            ],
                          ),
                          Divider(
                            thickness: 0.5,
                            color: AppColors.textColor.withOpacity(0.2),
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Target Amount', style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffc3c3c3),
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      Text('₦ 10,000,000.00', style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Target date', style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffc3c3c3),
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      Text('21st December, 2022', style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ],
                                  )
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      const Text('Completed', style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffc3c3c3),
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 7,
                                            width: 100,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: LinearProgressIndicator(
                                                value: 0.56,
                                                minHeight: 10,
                                                color: AppColors.primaryColor,
                                                backgroundColor: AppColors.iconGray.withOpacity(0.3),
                                              ),
                                            ),
                                          ),
                                          const Gap(5),
                                          const Text('56%', style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                            fontFamily: AppFonts.nunitoSansRegular,
                                            fontWeight: FontWeight.w500,
                                          ),),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff585858).withOpacity(0.2),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('33 people joined', style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textColor,
                                    fontFamily: AppFonts.nunitoSansRegular,
                                    fontWeight: FontWeight.w500,
                                  ),),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.secondaryColor,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('+ Join this challenge', textAlign: TextAlign.center, style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.white,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ),
                                  ),
                              ),
                              const Gap(20),
                              Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.white,
                                      border: Border.all(width: 1, color: AppColors.primaryColor)
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Leadership', textAlign: TextAlign.center, style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFonts.nunitoSansRegular,
                                        fontWeight: FontWeight.w500,
                                      ),),
                                    ),
                                  ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
