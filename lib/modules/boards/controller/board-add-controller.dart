import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_kanban/modules/boards/dto/board-dto.dart';
import 'package:night_kanban/modules/boards/interfaces/interface-board-repository.dart';
import 'package:night_kanban/shared/dto/default-success-dto.dart';
import 'package:night_kanban/shared/styles/colors.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BoardAddController {
  final InterfaceBoardRepository _boardRepository;

  BoardAddController(this._boardRepository);

  RxFuture<DefaultSuccessDto> createRequest =
      RxFuture.of(Future.value(null).asRx());

  List<String> status = ['Todo', 'Progress', 'Done'];

  List<Color> colors = [darkPurple, green, Colors.blue[400]];

  RxNotifier<Color> selectedColor = RxNotifier<Color>(null);

  RxNotifier<String> selectedStatus = RxNotifier<String>('Todo');

  BoardDto board = BoardDto();

  createAction() {
    createRequest.value = _boardRepository.create(board).asRx();
  }
}
