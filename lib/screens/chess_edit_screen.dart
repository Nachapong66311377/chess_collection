// lib/screens/chess_edit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chess_piece.dart';
import '../providers/chess_provider.dart';

class ChessEditScreen extends StatefulWidget {
  static const routeName = '/chess- edit';
  const ChessEditScreen({super.key});

  @override
  State<ChessEditScreen> createState() => _ChessEditScreenState();
}

class _ChessEditScreenState extends State<ChessEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _color;
  double? _value;
  int? _id;

  final List<String> pieceTypes = ['King', 'Queen', 'Rook', 'Bishop', 'Knight', 'Pawn'];
  final List<String> colors = ['White', 'Black'];

  @override
  void didChangeDependencies() {
    final ChessPiece? existingPiece = ModalRoute.of(context)!.settings.arguments as ChessPiece?;
    if (existingPiece != null && _id == null) {
      _id = existingPiece.id;
      _name = existingPiece.name;
      _type = existingPiece.type;
      _color = existingPiece.color;
      _value = existingPiece.value;
    }
    super.didChangeDependencies();
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final newPiece = ChessPiece(
      id: _id,
      name: _name!,
      type: _type!,
      color: _color!,
      value: _value ?? 0,
    );

    final provider = Provider.of<ChessProvider>(context, listen: false);
    if (_id == null) {
      provider.addPiece(newPiece);
    } else {
      provider.updatePiece(newPiece);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_id == null ? 'เพิ่มหมากรุก' : 'แก้ไขหมากรุก'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.check, color: Color(0xFFD4AF37)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'ชื่อหมากรุก'),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อ' : null,
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'ประเภทหมาก'),
                items: pieceTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (value) => setState(() => _type = value),
                validator: (value) => value == null ? 'เลือกประเภทหมาก' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _color,
                decoration: const InputDecoration(labelText: 'สีหมาก'),
                items: colors.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (value) => setState(() => _color = value),
                validator: (value) => value == null ? 'เลือกสีหมาก' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _value?.toString(),
                decoration: const InputDecoration(labelText: 'มูลค่า (คะแนน)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _value = double.tryParse(value ?? '0') ?? 0,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.save, color: Colors.black),
                label: const Text(
                  'บันทึก',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
