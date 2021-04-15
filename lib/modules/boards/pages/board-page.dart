import 'package:flutter/material.dart';
import 'package:night_kanban/modules/boards/controller/boards-controller.dart';
import 'package:night_kanban/modules/boards/pages/board-add-page.dart';
import 'package:night_kanban/modules/boards/repositories/board-repository.dart';
import 'package:night_kanban/shared/entities/user.dart';
import 'package:night_kanban/shared/services/http_client/custom-dio.dart';
import 'package:night_kanban/shared/services/navigator/navigator.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:night_kanban/shared/widgets/custom-card.dart';
import 'package:night_kanban/shared/widgets/empty-state.dart';
import 'package:night_kanban/shared/widgets/layout.dart';
import 'package:night_kanban/shared/widgets/request-error-widget.dart';
import 'package:provider/provider.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BoardPage extends StatefulWidget {
  static String route = "/board";

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  BoardsController _boardsController;
  User _user;
  @override
  void initState() {
    _boardsController = BoardsController(
      BoardRepository(
        HttpClient(),
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_user == null) {
      _user = Provider.of<User>(context);
      _boardsController.listAction(_user.data.id);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        pageTitle: "Boards",
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkPurple,
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(
            Icons.add_chart,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () => pushNamed(
            routeName: BoardAddPage.route,
          ),
        ),
        body: Center(
          child: RxBuilder(
            builder: (_) {
              if (_boardsController.listRequest.status ==
                  FutureStatus.pending) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_boardsController.listRequest.status ==
                  FutureStatus.rejected) {
                return RequestErrorFeedback();
              }

              if (_boardsController.listRequest.data.length > 0) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _boardsController.listRequest.data.length,
                  itemBuilder: (context, index) {
                    final item = _boardsController.listRequest.data[index];
                    return CustomCard(
                        title: item.title, description: item.description);
                  },
                );
              }

              return EmptyStateFeedback(
                  description:
                      "Sem boards adicionados até o momento. Clique no botão abaixo para adicionar!");
            },
          ),
        ));
  }
}
