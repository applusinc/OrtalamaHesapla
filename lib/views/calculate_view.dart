import 'package:flutter/material.dart';
import 'package:ortalamahesapla/constants/app_colors.dart';
import 'package:ortalamahesapla/constants/app_fonts.dart';
import 'package:ortalamahesapla/constants/app_strings.dart';
import 'package:ortalamahesapla/constants/app_styles.dart';
import 'package:ortalamahesapla/data/app_lessons.dart';
import 'package:ortalamahesapla/model/lesson.dart';
import 'package:ortalamahesapla/views/widgets/lesson_list_view.dart';
import 'package:ortalamahesapla/views/widgets/show_average.dart';

class CalculateView extends StatefulWidget {
  const CalculateView({super.key});

  @override
  State<CalculateView> createState() => _CalculateViewState();
}

class _CalculateViewState extends State<CalculateView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  String? dersPuani = null;
  String? dersSaati = null;
  String? dersAdi = null;
  double ortalama = 0.0;
  int dersSayisi = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          AppStrings.appBarText,
          style: AppFonts.titleFont,
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: buildForm(),
            ),
            Expanded(
              flex: 1,
              child: ShowAverage(
                  lessonNum: AppLessons.derslerList.length, ortalama: ortalama),
            )
          ],
        ),
        Expanded(
          child: lessonListView(),
        )
      ]),
    );
  }

  buildForm() {
    return Form(
      key: formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buildTextFormField(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(flex: 2, child: buildLessonNames()),
            Expanded(flex: 1, child: buildLessonHours())
          ],
        )
      ]),
    );
  }

  buildTextFormField() {
    return TextFormField(
      controller: textController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "Puan",
          suffixIcon: IconButton(
            icon: Icon(
              Icons.add,
              color: AppColors.primaryColor,
            ),
            iconSize: 30,
            onPressed: () {
              addLessonCalcu();
            },
          ),
          border: OutlineInputBorder(borderRadius: AppStyles.inputRadius),
          filled: true,
          fillColor: AppColors.primaryColor.shade100.withOpacity(0.3)),
    );
  }

  buildLessonNames() {
    return Container(
      margin: AppStyles.marginDrop,
      padding: AppStyles.marginDrop,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.shade100.withOpacity(0.3),
        borderRadius: AppStyles.inputRadius,
      ),
      child: DropdownButton<String>(
        hint: Text("Bir Ders Seç"),
        underline: Container(),
        value: dersAdi,
        elevation: 16,
        iconEnabledColor: AppColors.primaryColor.shade200,
        items: AppLessons.ddListItem(),
        onChanged: (String? value) {
          setState(() {
            dersAdi = value!;
          });
        },
      ),
    );
  }

  buildLessonHours() {
    return Container(
      margin: AppStyles.marginDrop,
      padding: AppStyles.marginDrop,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.shade100.withOpacity(0.3),
        borderRadius: AppStyles.inputRadius,
      ),
      child: DropdownButton<String>(
        hint: Text("Seç"),
        underline: Container(),
        value: dersSaati,
        elevation: 16,
        iconEnabledColor: AppColors.primaryColor.shade200,
        items: AppLessons.dhListItem(),
        onChanged: (String? value) {
          setState(() {
            dersSaati = value!;
          });
        },
      ),
    );
  }

  void addLessonCalcu() {
    if (textController.text.isEmpty || dersAdi == null || dersSaati == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Boş Bırakmayınız")));
    } else {
      dersPuani = textController.text;
      var eklenecekDers = Lesson(
          lessonName: dersAdi!,
          lessonHour: int.parse(dersSaati!),
          lessonScore: int.parse(dersPuani!));
      AppLessons.dersEkle(eklenecekDers);
      setState(() {
        ortalama = AppLessons.ortalamaHesapla();
      });

      if (formKey.currentState != null) {
        formKey.currentState!.reset();
        textController.text = "";
        dersAdi = null;
        dersPuani = null;
        dersSaati = null;
      }
    }
  }

  lessonListView() {
    return AppLessons.derslerList.length > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  AppLessons.derslerList.removeAt(index);

                  setState(() {
                    ortalama = AppLessons.ortalamaHesapla();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(AppLessons.derslerList[index].lessonName),
                      leading: CircleAvatar(
                        child: Text(AppLessons.derslerList[index].lessonScore
                            .toString()),
                      ),
                      subtitle: Text(
                          "Ders Ağırlığı: ${AppLessons.derslerList[index].lessonHour.toString()}"),
                    ),
                  ),
                ),
              );
            },
            itemCount: AppLessons.derslerList.length,
          )
        : Expanded(
            child: Center(
              child: Text(
                "Ders Eklemelisiniz",
                style: AppFonts.titleFont,
              ),
            ),
          );
  }
}
