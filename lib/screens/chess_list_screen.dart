import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chess_provider.dart';
import '../models/chess_piece.dart';
import 'chess_edit_screen.dart';

class ChessListScreen extends StatefulWidget {
  static const routeName = '/chess-list';

  const ChessListScreen({super.key});

  @override
  State<ChessListScreen> createState() => _ChessListScreenState();
}

class _ChessListScreenState extends State<ChessListScreen> {
  late Future<void> _fetchFuture;
  String _searchQuery = '';
  String _sortBy = 'name'; // ตัวเลือกเริ่มต้น

  @override
  void initState() {
    super.initState();
    _fetchFuture =
        Provider.of<ChessProvider>(context, listen: false).fetchPieces();
  }

  String getChessSymbol(String type) {
    switch (type.toLowerCase()) {
      case 'king':
        return '♔';
      case 'queen':
        return '♕';
      case 'rook':
        return '♖';
      case 'bishop':
        return '♗';
      case 'knight':
        return '♘';
      case 'pawn':
        return '♙';
      default:
        return '♟';
    }
  }

  List<ChessPiece> _filterAndSort(List<ChessPiece> pieces) {
    // กรองด้วย search
    List<ChessPiece> filtered = pieces
        .where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    // เรียงลำดับ
    switch (_sortBy) {
      case 'name':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'value':
        filtered.sort((a, b) => b.value.compareTo(a.value));
        break;
      case 'type':
        filtered.sort((a, b) => a.type.compareTo(b.type));
        break;
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChessProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Chess Collection',
          style: TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _fetchFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
            );
          }

          if (provider.pieces.isEmpty) {
            return const Center(
              child: Text(
                'ยังไม่มีหมากรุกในคลัง',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            );
          }

          // ใช้ฟังก์ชันกรอง + เรียงลำดับ
          final filteredPieces = _filterAndSort(provider.pieces);

          return Column(
            children: [
              // 🔍 ช่องค้นหา
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ค้นหาหมากรุก...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFFD4AF37)),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFFD4AF37), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),

              // 🔽 Sort By Dropdown
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Sort by:',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _sortBy,
                      dropdownColor: Colors.black87,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color(0xFFD4AF37)),
                      underline: Container(
                        height: 1,
                        color: const Color(0xFFD4AF37),
                      ),
                      style: const TextStyle(color: Color(0xFFD4AF37)),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _sortBy = value;
                          });
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                            value: 'name', child: Text('ชื่อ (Name)')),
                        DropdownMenuItem(
                            value: 'value', child: Text('ค่า (Value)')),
                        DropdownMenuItem(
                            value: 'type', child: Text('ประเภท (Type)')),
                      ],
                    ),
                  ],
                ),
              ),

              // 🧱 รายการหมากรุก
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredPieces.length,
                  itemBuilder: (ctx, i) {
                    final ChessPiece piece = filteredPieces[i];
                    final symbol = getChessSymbol(piece.type);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFFD4AF37), width: 0.8),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFFD4AF37).withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        leading: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37).withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD4AF37).withOpacity(0.8),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            symbol,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Color(0xFFD4AF37),
                            ),
                          ),
                        ),
                        title: Text(
                          piece.name,
                          style: const TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          '${piece.type} • ${piece.color} (${piece.value})',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent),
                          onPressed: () => provider.deletePiece(piece.id!),
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          ChessEditScreen.routeName,
                          arguments: piece,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD4AF37),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () async {
          await Navigator.pushNamed(context, ChessEditScreen.routeName);
          setState(() {
            _fetchFuture = provider.fetchPieces(); // รีเฟรชหลังเพิ่ม/แก้ไข
          });
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
