import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts/newpage.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  //menuliskan semua variable yang diperlukan
  String? _selectedJenisBarang;
  DateTime? _selectedTglMasuk;
  String? _formattedTglMasuk = '';
  
  //menampilkan datepicker 
  Future<void> _selectTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedTglMasuk ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _selectedTglMasuk = picked;
        _formattedTglMasuk = DateFormat('dd-MM-yyyy').format(picked);
      });
  }
  //untuk radiobutton jenis barang
  void _pilihJenis(String? value) {
    setState(() {
      _selectedJenisBarang = value;
    });
  }
  //kirim data 
  void kirimData() {
    int parseHargaBarang= int.tryParse(controllerHargaBarang.text)?? 0;
    int parseStokBarang = int.tryParse(controllerStokBarang.text) ?? 0;
    // Check if any field is empty or not selected
    if (controllerKodeBarang.text.isEmpty ||
        controllerNamaBarang.text.isEmpty ||
        controllerHargaBarang.text.isEmpty ||
        controllerStokBarang.text.isEmpty ||
        _selectedJenisBarang == null ||
        _formattedTglMasuk == '') {
      // Show alert dialog if any validation fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Isi semua informasi terlebih dahulu.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewPage(
            kodeBarang: controllerKodeBarang.text,
            namaBarang: controllerNamaBarang.text,
            jenisBarang: _selectedJenisBarang,
            hargaBarang: parseHargaBarang,
            stokBarang: parseStokBarang,
            tglMasuk: _formattedTglMasuk,
            onOkPressed: () {
              _resetForm(); // Callback untuk mereset form
      }, 
          ),
        ),
      );
    }
  }
  //pada tombol reset
  void _resetForm() {
    setState(() {
      // Reset all the controllers
      controllerKodeBarang.clear();
      controllerNamaBarang.clear();
      controllerHargaBarang.clear();
      controllerStokBarang.clear();
      
      // Reset all the state variables
      _selectedJenisBarang = null;
      _formattedTglMasuk = '';
  });
  }
  //menuliskan semua controller yg diperlukan
  TextEditingController controllerKodeBarang= new TextEditingController();
  TextEditingController controllerNamaBarang= new TextEditingController();
  TextEditingController controllerHargaBarang= new TextEditingController();
  TextEditingController controllerStokBarang= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text("Form Tambah Data Barang"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //text berawal dari sebelah kiri
              children: <Widget>[
                //kode Barang
                Text("Kode barang :"),
                TextField(
                  controller: controllerKodeBarang,
                  decoration: InputDecoration(
                    hintText: "Kode Barang",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Padding(padding:EdgeInsets.only(top: 20)),

                //Nama Barang
                Text("Nama barang :"),
                TextField(
                  controller: controllerNamaBarang,
                  decoration: InputDecoration(
                    hintText: "Nama Barang",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Padding(padding:EdgeInsets.only(top: 20)),
                //Jenis Barang
                Text("Jenis Barang"),
                RadioListTile<String>(
                  value: "Sembako",
                  title: Text("Sembako"),
                  groupValue: _selectedJenisBarang,
                  onChanged: (value) => _pilihJenis(value),
                ),
                RadioListTile<String>(
                  value: "Makanan & Minuman",
                  title: Text("Makanan & Minuman"),
                  groupValue: _selectedJenisBarang,
                  onChanged: (value) => _pilihJenis(value),
                ),
                RadioListTile<String>(
                  value: "Sabun",
                  title: Text("Sabun"),
                  groupValue: _selectedJenisBarang,
                  onChanged: (value) => _pilihJenis(value),
                ),
                RadioListTile<String>(
                  value: "Lainnya",
                  title: Text("Lainnya"),
                  groupValue: _selectedJenisBarang,
                  onChanged: (value) => _pilihJenis(value),
                ),
                Padding(padding:EdgeInsets.only(top: 20)),
                //Harga Satuan
                Text("Harga Barang Per Item"),
                TextField(
                  controller: controllerHargaBarang,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Harga Barang Per Item",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Padding(padding:EdgeInsets.only(top: 20)),
                //Stok Barang
                Text("Stok Barang"),
                TextField(
                  controller: controllerStokBarang,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Stok Barang",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Padding(padding:EdgeInsets.only(top: 20)),
                //Tgl Masuk Barang (using Datepicker)
                Text("Tanggal Masuk Barang"),
                TextField(
                  controller: TextEditingController(text: _formattedTglMasuk),
                  readOnly: true, // Makes the TextField not editable
                  decoration: InputDecoration(
                    hintText: "Tanggal Masuk",
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onTap: () => _selectTanggal(context),
                ),
                //untuk send data and reset
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // This centers the buttons horizontally
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        kirimData();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Button color
                        backgroundColor: Colors.blue, // Text color
                      ),
                      child: Text('Kirim'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _resetForm();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Text color
                        backgroundColor: Colors.red, // Button color
                      ),
                      child: Text('Reset'),
                    ),
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }
  
}