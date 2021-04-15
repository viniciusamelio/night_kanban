import 'dart:async';

import 'package:dio/dio.dart';
import 'package:night_kanban/modules/boards/dto/board-dto.dart';
import 'package:night_kanban/modules/boards/interfaces/interface-board-repository.dart';
import 'package:night_kanban/shared/dto/default-success-dto.dart';

class BoardRepository implements InterfaceBoardRepository {
  final Dio dio;

  BoardRepository(this.dio);

  Future<List<BoardDto>> list(int userId) async {
    try {
      final result = await dio.get('/board/user/$userId');
      final boards = <BoardDto>[];
      for (var board in result.data) {
        boards.add(BoardDto.fromMap(board));
      }
      return boards;
    } catch (e) {
      throw e;
    }
  }

  Future<DefaultSuccessDto> create(BoardDto board) async {
    try {
      final result = await dio.post('/board');
      return DefaultSuccessDto(
        result.data['message'],
      );
    } catch (e) {
      throw e;
    }
  }
}
