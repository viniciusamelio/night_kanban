import 'package:flutter/material.dart';
import 'package:night_kanban/modules/boards/controller/board-add-controller.dart';
import 'package:night_kanban/modules/boards/repositories/board-repository.dart';
import 'package:night_kanban/shared/services/http_client/custom-dio.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:night_kanban/shared/widgets/gradient-button.dart';
import 'package:night_kanban/shared/widgets/layout.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BoardAddPage extends StatefulWidget {
  static String route = "/board/add";
  @override
  _BoardAddPageState createState() => _BoardAddPageState();
}

class _BoardAddPageState extends State<BoardAddPage> {
  BoardAddController _boardAddController;

  @override
  void initState() {
    _boardAddController = BoardAddController(
      BoardRepository(
        HttpClient(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      pageTitle: "Novo Board",
      body: Center(
        child: RxBuilder(builder: (_) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: darkGrey,
            ),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onSaved: (e) {
                      _boardAddController.board.title = e;
                    },
                    decoration:
                        InputDecoration(labelText: 'Título', fillColor: grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (e) {
                      _boardAddController.board.title = e;
                    },
                    decoration: InputDecoration(
                        labelText: 'Descrição', fillColor: grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        "Cor",
                        style: TextStyle(
                          color: Color.fromRGBO(133, 132, 132, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildColorSelect(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                    label: "Salvar",
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _buildColorSelect() {
    List<GestureDetector> colorPickers = [];
    for (var color in _boardAddController.colors) {
      colorPickers.add(GestureDetector(
        onTap: () {
          _boardAddController.selectedColor.value = color;
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(
                color: _boardAddController.selectedColor.value == color
                    ? Colors.white.withOpacity(0.85)
                    : Colors.transparent,
                width: 2),
          ),
        ),
      ));
    }
    return colorPickers;
  }
}

class StatusIndicator extends StatelessWidget {
  final String selectedStatus;
  final String label;
  final BoardAddController controller;

  const StatusIndicator(
      {Key key, this.selectedStatus, this.label, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.selectedStatus.value = label;
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: lightGrey, width: 3),
                color: selectedStatus == label ? green : lightGrey,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: lightGrey,
            ),
          )
        ],
      ),
    );
  }
}
