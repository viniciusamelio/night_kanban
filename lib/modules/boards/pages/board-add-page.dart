import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:night_kanban/modules/boards/controller/board-add-controller.dart';
import 'package:night_kanban/modules/boards/repositories/board-repository.dart';
import 'package:night_kanban/shared/entities/user.dart';
import 'package:night_kanban/shared/services/dialogs/awesome-dialog-service.dart';
import 'package:night_kanban/shared/services/dialogs/dto/dialog-dto.dart';
import 'package:night_kanban/shared/services/http_client/custom-dio.dart';
import 'package:night_kanban/shared/services/navigator/navigator.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:night_kanban/shared/utils/validators/convert/color-convert.dart';
import 'package:night_kanban/shared/utils/validators/string-validators.dart';
import 'package:night_kanban/shared/widgets/gradient-button.dart';
import 'package:night_kanban/shared/widgets/layout.dart';
import 'package:provider/provider.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BoardAddPage extends StatefulWidget {
  static String route = "/board/add";
  @override
  _BoardAddPageState createState() => _BoardAddPageState();
}

class _BoardAddPageState extends State<BoardAddPage> {
  BoardAddController _boardAddController;
  GlobalKey<FormState> _formKey;
  RxDisposer _boardAddDisposer;
  User _user;

  @override
  void initState() {
    _boardAddController = BoardAddController(
      BoardRepository(
        HttpClient(),
      ),
    );
    _formKey = GlobalKey<FormState>();
    _boardAddDisposer = rxObserver(
        () => _boardAddController.createRequest.status,
        filter: () =>
            _boardAddController.createRequest.status != FutureStatus.pending &&
            _boardAddController.createRequest.data != null,
        effect: (FutureStatus status) {
          final request = _boardAddController.createRequest;
          if (status == FutureStatus.rejected) {
            final error = request.error;
            final message = error[0].response.data['message'];
            return AwesomeDialogService().infoDialog(
              DialogDto(message: message, context: context),
            );
          }
          return AwesomeDialogService().successDialog(
            DialogDto(
              message: "Board criado",
              title: "Sucesso!",
              confirmButton: GradientButton(
                label: 'Beleza',
                onPressed: () => popUntillNamed(
                  routeName: '/board',
                ),
              ),
              context: context,
            ),
          );
        });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_user == null) {
      _user = Provider.of<User>(context);
    }
  }

  @override
  void dispose() {
    _boardAddDisposer();
    super.dispose();
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
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onSaved: (e) {
                      _boardAddController.board.title = e;
                    },
                    validator: (e) => stringSizeValidator(
                      string: e,
                      minLength: 4,
                      message: "Epa, o título precisa ter ao menos 4 letras",
                    ),
                    decoration:
                        InputDecoration(labelText: 'Título', fillColor: grey),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onSaved: (e) {
                      _boardAddController.board.description = e;
                    },
                    validator: (e) => stringSizeValidator(
                      string: e,
                      minLength: 4,
                      message: "Epa, a descrição precisa ter ao menos 4 letras",
                    ),
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
                  RxBuilder(
                    builder: (_) {
                      final status = _boardAddController.createRequest.status;

                      if (status != FutureStatus.pending) {
                        return GradientButton(
                          label: "Salvar",
                          onPressed: () => _formValidation(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset(
                          'assets/animations/loading.json',
                          width: 130,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _formValidation() {
    if (_formKey.currentState.validate()) {
      if (_boardAddController.selectedColor.value == null) {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          title: 'Opa',
          desc: 'Selecione uma cor antes de salvar seu board',
        );
      }
      _formKey.currentState.save();
      _boardAddController.board.userId = _user.data.id;
      _boardAddController.board.color =
          colorToHex(_boardAddController.selectedColor.value);
      _boardAddController.createAction();
    }
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
