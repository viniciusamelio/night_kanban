import 'package:night_kanban/modules/boards/dto/board-dto.dart';
import 'package:night_kanban/modules/boards/interfaces/interface-board-repository.dart';
import 'package:rx_notifier/rx_notifier.dart';

class BoardsController {
  final InterfaceBoardRepository _boardRepository;

  BoardsController(this._boardRepository);

  RxFuture<List<BoardDto>> listRequest = RxFuture.of(Future.value(null).asRx());

  listAction(int userId) {
    listRequest.value = _boardRepository.list(userId).asRx();
  }
}
