import 'package:flutter/foundation.dart';
import '../db/chess_database.dart';
import '../models/chess_piece.dart';

class ChessProvider with ChangeNotifier {
  List<ChessPiece> _pieces = [];

  List<ChessPiece> get pieces => [..._pieces];

  // โหลดข้อมูลจาก database
  Future<void> fetchPieces() async {
    _pieces = await ChessDatabase.instance.getPieces();
    notifyListeners();
  }

  // เพิ่มหมาก
  Future<void> addPiece(ChessPiece piece) async {
    await ChessDatabase.instance.insertPiece(piece);
    await fetchPieces();
  }

  // แก้ไขหมาก
  Future<void> updatePiece(ChessPiece piece) async {
    await ChessDatabase.instance.updatePiece(piece);
    await fetchPieces();
  }

  // ลบหมาก
  Future<void> deletePiece(int id) async {
    await ChessDatabase.instance.deletePiece(id);
    await fetchPieces();
  }
}
