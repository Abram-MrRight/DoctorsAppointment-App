import 'package:doctors_appt/res/components/custom_textfield.dart';

import '../../consts/consts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
       title: AppStyles.bold(title: "${AppStrings.welcome} User", size: AppSizes.size18.toDouble(),color: AppColors.whiteColor ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            color: AppColors.blueColor,
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: AppStrings.search,
                    borderColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                  ),
                ),
                10.widthBox,
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search,
                  color: AppColors.whiteColor,))
              ],
            ),
          ),
          20.heightBox,

         SizedBox(
           height: 100,
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: 6,
             itemBuilder: (BuildContext context, int index){
              return Container(
                padding: const EdgeInsets.all(12),
                margin: EdgeInsets.only(right: 8),
                color: Colors.red,
                child: Column(
                  children: [
                    Image.asset(
                        Appassets.ic_body,
                        width: 40,

                    ),
                    5.heightBox,
                    AppStyles.normal(title: "Body", color: AppColors.whiteColor),
                  ],
                ),
              );
           },
           ),
         ),
        ],
      ),
    );
  }
}
