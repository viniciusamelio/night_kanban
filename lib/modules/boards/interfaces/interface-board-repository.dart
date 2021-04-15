import 'dart:async';

import 'package:night_kanban/modules/boards/dto/board-dto.dart';
import 'package:night_kanban/shared/dto/default-success-dto.dart';

abstract class InterfaceBoardRepository {
  Future<List<BoardDto>> list(int userId);
  Future<DefaultSuccessDto> create(BoardDto dto);
}
