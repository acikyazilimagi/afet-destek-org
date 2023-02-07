import 'package:deprem_destek/config/palette.dart';
import 'package:deprem_destek/widgets/custom_button.dart';
import 'package:deprem_destek/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Palette.backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SvgPicture.asset('Vector.svg'),
        ),
      ),
      endDrawer: Drawer(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.list),
                title: Text('item $index'),
                trailing: const Icon(Icons.done),
              );
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Giriş Yap',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 18),
            CustomTextField(
              hintText: 'Telefon Numarası',
              onChanged: (value) {},
            ),
            CustomTextField(
              onChanged: (value) {},
              hintText: 'Şifre',
            ),
            CustomButton(
              onPressed: () {},
              text: 'Giriş Yap',
              customButtonType: CustomButtonType.confirm,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginBottomButton(
                  onTap: () {},
                  text: 'Şifre Sıfırla',
                ),
                const Text(' ya da '),
                LoginBottomButton(
                  onTap: () {},
                  text: 'Kayıt Ol',
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class LoginBottomButton extends StatelessWidget {
  const LoginBottomButton({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
