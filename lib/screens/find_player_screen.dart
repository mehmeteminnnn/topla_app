import 'package:flutter/material.dart';

class Player {
  final String name;
  final int age;
  final String position;
  final String photoUrl;
  final double height;
  final double weight;

  Player({
    required this.name,
    required this.age,
    required this.position,
    required this.photoUrl,
    required this.height,
    required this.weight,
  });
}

class FindPlayerScreen extends StatefulWidget {
  const FindPlayerScreen({super.key});

  @override
  State<FindPlayerScreen> createState() => _FindPlayerScreenState();
}

class _FindPlayerScreenState extends State<FindPlayerScreen> {
  final List<Player> _players = [
    Player(
      name: "Ahmet Yılmaz",
      age: 25,
      position: "Forvet",
      photoUrl: "https://randomuser.me/api/portraits/men/1.jpg",
      height: 1.78,
      weight: 75,
    ),
    Player(
      name: "Mehmet Demir",
      age: 28,
      position: "Orta Saha",
      photoUrl: "https://randomuser.me/api/portraits/men/2.jpg",
      height: 1.82,
      weight: 78,
    ),
    Player(
      name: "Ali Kaya",
      age: 23,
      position: "Defans",
      photoUrl: "https://randomuser.me/api/portraits/men/3.jpg",
      height: 1.85,
      weight: 80,
    ),
    Player(
      name: "Can Özkan",
      age: 30,
      position: "Kaleci",
      photoUrl: "https://randomuser.me/api/portraits/men/4.jpg",
      height: 1.90,
      weight: 85,
    ),
    Player(
      name: "Burak Şahin",
      age: 26,
      position: "Forvet",
      photoUrl: "https://randomuser.me/api/portraits/men/5.jpg",
      height: 1.80,
      weight: 77,
    ),
  ];

  String _selectedPosition = "Tümü";
  String _sortBy = "Yaş";
  List<String> _positions = ["Tümü", "Forvet", "Orta Saha", "Defans", "Kaleci"];
  List<String> _sortOptions = ["Yaş", "Boy", "Kilo"];

  List<Player> get _filteredPlayers {
    var filtered = _players;

    if (_selectedPosition != "Tümü") {
      filtered = filtered
          .where((player) => player.position == _selectedPosition)
          .toList();
    }

    switch (_sortBy) {
      case "Yaş":
        filtered.sort((a, b) => a.age.compareTo(b.age));
        break;
      case "Boy":
        filtered.sort((a, b) => a.height.compareTo(b.height));
        break;
      case "Kilo":
        filtered.sort((a, b) => a.weight.compareTo(b.weight));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyuncu Bul'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPosition,
                    decoration: const InputDecoration(
                      labelText: 'Pozisyon',
                      border: OutlineInputBorder(),
                    ),
                    items: _positions.map((String position) {
                      return DropdownMenuItem<String>(
                        value: position,
                        child: Text(position),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedPosition = newValue;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _sortBy,
                    decoration: const InputDecoration(
                      labelText: 'Sırala',
                      border: OutlineInputBorder(),
                    ),
                    items: _sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _sortBy = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = _filteredPlayers[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(player.photoUrl),
                    ),
                    title: Text(player.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Yaş: ${player.age}'),
                        Text('Pozisyon: ${player.position}'),
                        Text('Boy: ${player.height}m'),
                        Text('Kilo: ${player.weight}kg'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('İletişime Geç'),
                            content: const Text(
                                'Oyuncu ile iletişime geçmek için mesaj gönderebilirsiniz.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('İptal'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Mesaj gönderme işlemi burada yapılacak
                                  Navigator.pop(context);
                                },
                                child: const Text('Mesaj Gönder'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('İletişime Geç'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
