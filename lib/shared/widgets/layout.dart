import 'package:flutter/material.dart';
import 'package:night_kanban/shared/services/navigator/navigator.dart';

class Layout extends StatelessWidget {
  final Widget body;
  final List<Widget> actions;
  final String pageTitle;
  final Widget floatingActionButton;
  const Layout(
      {Key key,
      @required this.body,
      this.floatingActionButton,
      this.pageTitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(173, 122, 239, 1),
            Color.fromRGBO(99, 97, 227, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    if (ModalRoute.of(context).canPop) {
                      pop();
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  pageTitle ?? '',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                actions: actions,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: body)
            ],
          ),
        ),
      ),
    );
  }
}
