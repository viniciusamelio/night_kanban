import 'package:night_kanban/modules/boards/dto/board-dto.dart';

abstract class InterfaceBoardRepository {
  Future<List<BoardDto>> list(int userId);
}
