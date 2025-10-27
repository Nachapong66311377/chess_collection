import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChessLearningPage extends StatelessWidget {
  final List<Map<String, dynamic>> chessPieces = [
    {
      "name": "Pawn",
      "move": "เดินตรง 1 ช่อง (หากยังไม่เคยเดิน เดินได้ 2 ช่อง) และกินเฉียง 1 ช่อง",
      "power": "หมากเบาที่สุด แต่สามารถเลื่อนขั้นเป็น Queen ได้เมื่อถึงฝั่งตรงข้าม",
      "image": "assets/chess_pawn.png"
    },
    {
      "name": "Rook",
      "move": "เดินตรงแนวตั้งหรือแนวนอนกี่ช่องก็ได้",
      "power": "แข็งแกร่งในแนวตรง ใช้ร่วมกับ King เพื่อทำ Castling",
      "image": "assets/chess_rook.png"
    },
    {
      "name": "Knight",
      "move": "เดินรูปตัว L (2 ช่องตรง + 1 ช่องข้าง) กระโดดข้ามหมากได้",
      "power": "เป็นหมากเดียวที่กระโดดได้ เหมาะกับการเปิดเกม",
      "image": "assets/chess_knight.png"
    },
    {
      "name": "Bishop",
      "move": "เดินแนวทแยงได้กี่ช่องก็ได้",
      "power": "ผู้เชี่ยวชาญแห่งแนวทแยง ควบคุมพื้นที่อย่างแม่นยำและทรงพลัง",
      "image": "assets/chess_bishop.png"
    },
    {
      "name": "Queen",
      "move": "เดินได้ทั้งแนวตรงและทแยง ไม่จำกัดระยะ",
      "power": "หมากที่ทรงพลังที่สุดในกระดาน",
      "image": "assets/chess_queen.png"
    },
    {
      "name": "King",
      "move": "เดินได้ทุกทิศทาง ทีละ 1 ช่อง",
      "power": "หมากสำคัญที่สุด ถ้าโดน Checkmate เกมจบ!",
      "image": "assets/chess_king.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '♟️ Chess Learning Mode',
          style: GoogleFonts.cinzel(
            color: const Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: chessPieces.length,
        itemBuilder: (context, index) {
          final piece = chessPieces[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChessDetailPage(piece: piece),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(piece["image"], height: 80),
                  const SizedBox(height: 10),
                  Text(
                    piece["name"],
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFFD4AF37),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(Icons.touch_app, color: Colors.white38, size: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChessDetailPage extends StatelessWidget {
  final Map<String, dynamic> piece;

  const ChessDetailPage({required this.piece});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          piece["name"],
          style: GoogleFonts.cinzel(
            color: const Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: piece["image"],
              child: Image.asset(piece["image"], height: 140),
            ),
            const SizedBox(height: 24),
            Text(
              "🌀 วิธีการเดิน",
              style: GoogleFonts.cinzel(
                color: const Color(0xFFD4AF37),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              piece["move"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "⚔️ ความสามารถ",
              style: GoogleFonts.cinzel(
                color: const Color(0xFFD4AF37),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              piece["power"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
