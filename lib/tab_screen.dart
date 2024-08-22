import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SMK Negeri 4 - Mobile Apps'),
        ),
        body: TabBarView(
          children: [
            DashboardTab(),
            StudentsTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
            Tab(icon: Icon(Icons.people), text: 'Students'),
            Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.apartment,
      'label': 'Profil Sekolah',
      'route': '/profile_school'
    },
    {
      'icon': Icons.cast_for_education,
      'label': 'Program Keahlian',
      'route': '/program_keahlian'
    },
    {
      'icon': Icons.diversity_3,
      'label': 'Ekstrakurikuler',
      'route': '/ekstrakurikuler'
    },
    {'icon': Icons.today, 'label': 'Kegiatan', 'route': '/kegiatan'},
    {'icon': Icons.emoji_events, 'label': 'Prestasi', 'route': '/prestasi'},
    {
      'icon': Icons.corporate_fare,
      'label': 'Kerjasama Industri',
      'route': '/kerjasama_industri'
    },
    {
      'icon': Icons.work_outline,
      'label': 'Program PKL',
      'route': '/program_pkl'
    },
    {
      'icon': Icons.photo_camera,
      'label': 'Dokumentasi Kegiatan',
      'route': '/dokumentasi_kegiatan'
    },
    {
      'icon': Icons.local_library,
      'label': 'Perpustakaan',
      'route': '/perpustakaan'
    },
    {'icon': Icons.public, 'label': 'Sosial Media', 'route': '/sosial_media'},
    {'icon': Icons.tty, 'label': 'Kontak', 'route': '/kontak'},
    {'icon': Icons.chat, 'label': 'Saran & Masukan', 'route': '/saran_masukan'},
  ];

  void _handleMenuTap(BuildContext context, String route) {
    // Navigate to the corresponding route
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[100]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _handleMenuTap(context, item['route']),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 50.0, color: Colors.blue),
                    SizedBox(height: 8.0),
                    Text(
                      item['label'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StudentsTab extends StatelessWidget {
  Future<List<User>> fetchUsers() async {
    // Sample data; replace with actual API call if needed
    return [
      User(
          firstName: 'Siti Lutfiyah',
          email: 'siti.lutfiyah@gmail.com',
          className: '12 PPLG 1'),
      User(
          firstName: 'Siti Aisah',
          email: 'siti.aisah@gmail.com',
          className: '12 PPLG 1'),
      User(
          firstName: 'Nadia Nur Alifah',
          email: 'nadiaa@gmail.com',
          className: '12 PPLG 1'),
      User(
          firstName: 'Muhamad Yasir',
          email: 'yasir@gmail.com',
          className: '12 PPLG 1'),
      User(
          firstName: 'Afril Lestari',
          email: 'afril@gmail.com',
          className: '12 PPLG 1')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.firstName[0]),
                    ),
                    title: Text(user.firstName),
                    subtitle:
                        Text('Kelas: ${user.className}\nEmail: ${user.email}'),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('profile.jpeg'), // Path gambar profil
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'SITI LUTFIYAH',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Email: p123@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Biodata',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Nama Lengkap'),
            subtitle: Text('Siti Lutfiyah'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('Tanggal Lahir'),
            subtitle: Text('10 April 2007'),
          ),
        ],
      ),
    );
  }
}

class User {
  final String firstName;
  final String email;
  final String className; // Added className field

  User({required this.firstName, required this.email, required this.className});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      email: json['email'],
      className:
          json['class_name'], // Ensure the API response includes this field
    );
  }
}

// Class pada Icons Dashboard
void main() {
  runApp(MaterialApp(
    title: 'SMK Negeri 4 - Mobile Apps',
    initialRoute: '/',
    routes: {
      '/': (context) => TabScreen(),
      '/profile_school': (context) => ProfileSchoolScreen(),
      '/program_keahlian': (context) => ProgramKeahlianScreen(),
      '/ekstrakurikuler': (context) => EkstrakurikulerScreen(),
      '/kegiatan': (context) => KegiatanScreen(),
      '/prestasi': (context) => PrestasiScreen(),
      '/kerjasama_industri': (context) => KerjasamaIndustriScreen(),
      '/program_pkl': (context) => ProgramPKLScreen(),
      '/dokumentasi_kegiatan': (context) => DokumentasiKegiatanScreen(),
      '/perpustakaan': (context) => PerpustakaanScreen(),
      '/sosial_media': (context) => SosialMediaScreen(),
      '/kontak': (context) => KontakScreen(),
      '/saran_masukan': (context) => SaranMasukanScreen(),
    },
  ));
}

// Profil Sekolah
class ProfileSchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Sekolah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SMK Negeri 4',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Alamat: Jl. Pendidikan No. 4, Kota ABC',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Visi: Menjadi sekolah unggul yang menghasilkan lulusan berkarakter dan berkompeten.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Misi: Meningkatkan kualitas pendidikan melalui kurikulum yang adaptif dan inovatif.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Program Keahlian
class ProgramKeahlianScreen extends StatelessWidget {
  final List<String> programKeahlian = [
    'Rekayasa Perangkat Lunak',
    'Teknik Komputer dan Jaringan',
    'Multimedia',
    'Teknik Elektronika Industri',
    'Teknik Kendaraan Ringan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Keahlian'),
      ),
      body: ListView.builder(
        itemCount: programKeahlian.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.code),
            title: Text(programKeahlian[index]),
          );
        },
      ),
    );
  }
}

// Ekstrakurikuler
class EkstrakurikulerScreen extends StatelessWidget {
  final List<String> ekstrakurikuler = [
    'Pramuka',
    'Paskibra',
    'PMR',
    'OSIS',
    'KIR',
    'Tari Tradisional',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ekstrakurikuler'),
      ),
      body: ListView.builder(
        itemCount: ekstrakurikuler.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.sports_handball),
            title: Text(ekstrakurikuler[index]),
          );
        },
      ),
    );
  }
}

// Kegiatan
class KegiatanScreen extends StatelessWidget {
  final List<String> kegiatan = [
    'Penerimaan Siswa Baru',
    'Lomba Keterampilan Siswa',
    'Study Tour',
    'Pentas Seni',
    'Upacara Hari Kemerdekaan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Sekolah'),
      ),
      body: ListView.builder(
        itemCount: kegiatan.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.event),
            title: Text(kegiatan[index]),
          );
        },
      ),
    );
  }
}

class PrestasiScreen extends StatelessWidget {
  final List<String> prestasi = [
    'Juara 1 LKS Nasional Bidang RPL',
    'Juara 2 Olimpiade Sains Tingkat Provinsi',
    'Juara 1 Futsal Tingkat Kota',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prestasi Sekolah'),
      ),
      body: ListView.builder(
        itemCount: prestasi.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.emoji_events),
            title: Text(prestasi[index]),
          );
        },
      ),
    );
  }
}

class KerjasamaIndustriScreen extends StatelessWidget {
  final List<String> kerjasamaIndustri = [
    'PT. ABC',
    'PT. XYZ',
    'CV. Tech Innovator',
    'PT. Kreatif Media',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kerjasama Industri'),
      ),
      body: ListView.builder(
        itemCount: kerjasamaIndustri.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.business),
            title: Text(kerjasamaIndustri[index]),
          );
        },
      ),
    );
  }
}

class ProgramPKLScreen extends StatelessWidget {
  final List<String> programPKL = [
    'Magang di PT. ABC',
    'Magang di PT. XYZ',
    'Magang di CV. Tech Innovator',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program PKL'),
      ),
      body: ListView.builder(
        itemCount: programPKL.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.work),
            title: Text(programPKL[index]),
          );
        },
      ),
    );
  }
}

class DokumentasiKegiatanScreen extends StatelessWidget {
  final List<String> dokumentasi = [
    'Penerimaan Siswa Baru 2023',
    'LKS Nasional 2023',
    'Pentas Seni 2023',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dokumentasi Kegiatan'),
      ),
      body: ListView.builder(
        itemCount: dokumentasi.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.photo_album),
            title: Text(dokumentasi[index]),
          );
        },
      ),
    );
  }
}

class PerpustakaanScreen extends StatelessWidget {
  final List<String> perpustakaan = [
    'Koleksi Buku Teknik',
    'Koleksi Buku Sains',
    'Koleksi Buku Fiksi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perpustakaan'),
      ),
      body: ListView.builder(
        itemCount: perpustakaan.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.library_books),
            title: Text(perpustakaan[index]),
          );
        },
      ),
    );
  }
}

class SosialMediaScreen extends StatelessWidget {
  final List<Map<String, dynamic>> sosialMedia = [
    {'platform': 'Facebook', 'link': 'facebook.com/smkn4'},
    {'platform': 'Instagram', 'link': 'instagram.com/smkn4'},
    {'platform': 'Twitter', 'link': 'twitter.com/smkn4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sosial Media'),
      ),
      body: ListView.builder(
        itemCount: sosialMedia.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.public),
            title: Text(sosialMedia[index]['platform']),
            subtitle: Text(sosialMedia[index]['link']),
          );
        },
      ),
    );
  }
}

class KontakScreen extends StatelessWidget {
  final List<Map<String, dynamic>> kontak = [
    {'type': 'Telepon', 'detail': '(021) 123456'},
    {'type': 'Email', 'detail': 'info@smkn4.com'},
    {'type': 'Alamat', 'detail': 'Jl. Pendidikan No. 4, Kota ABC'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontak'),
      ),
      body: ListView.builder(
        itemCount: kontak.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text(kontak[index]['type']),
            subtitle: Text(kontak[index]['detail']),
          );
        },
      ),
    );
  }
}

class SaranMasukanScreen extends StatefulWidget {
  @override
  _SaranMasukanScreenState createState() => _SaranMasukanScreenState();
}

class _SaranMasukanScreenState extends State<SaranMasukanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle the form submission
      String name = _nameController.text;
      String email = _emailController.text;
      String message = _messageController.text;

      // You can send this data to a server or save it locally
      print('Name: $name');
      print('Email: $email');
      print('Message: $message');

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terima kasih atas saran dan masukan Anda!')),
      );

      // Clear the form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran & Masukan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kami menghargai saran dan masukan Anda untuk kemajuan sekolah kami.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Masukkan email yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Pesan'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pesan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
