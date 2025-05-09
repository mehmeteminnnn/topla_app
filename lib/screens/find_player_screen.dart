import 'package:flutter/material.dart';

class Player {
  final String name;
  final int age;
  final String position;
  final String photoUrl;
  final double height;
  final double weight;
  final String city;

  Player({
    required this.name,
    required this.age,
    required this.position,
    required this.photoUrl,
    required this.height,
    required this.weight,
    required this.city,
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
      city: "İstanbul",
    ),
    Player(
      name: "Mehmet Demir",
      age: 28,
      position: "Orta Saha",
      photoUrl: "https://randomuser.me/api/portraits/men/2.jpg",
      height: 1.82,
      weight: 78,
      city: "Ankara",
    ),
    Player(
      name: "Ali Kaya",
      age: 23,
      position: "Defans",
      photoUrl: "https://randomuser.me/api/portraits/men/3.jpg",
      height: 1.85,
      weight: 80,
      city: "İzmir",
    ),
    Player(
      name: "Can Özkan",
      age: 30,
      position: "Kaleci",
      photoUrl: "https://randomuser.me/api/portraits/men/4.jpg",
      height: 1.90,
      weight: 85,
      city: "Bursa",
    ),
    Player(
      name: "Burak Şahin",
      age: 26,
      position: "Forvet",
      photoUrl: "https://randomuser.me/api/portraits/men/5.jpg",
      height: 1.80,
      weight: 77,
      city: "Antalya",
    ),
  ];

  String _selectedPosition = "Tümü";
  String _selectedCity = "Tümü";
  String _sortBy = "Yaş";
  List<String> _positions = ["Tümü", "Forvet", "Orta Saha", "Defans", "Kaleci"];
  List<String> _cities = [
    "Tümü",
    "İstanbul",
    "Ankara",
    "İzmir",
    "Bursa",
    "Antalya"
  ];
  List<String> _sortOptions = ["Yaş", "Boy", "Kilo"];

  List<Player> get _filteredPlayers {
    var filtered = _players;

    if (_selectedPosition != "Tümü") {
      filtered = filtered
          .where((player) => player.position == _selectedPosition)
          .toList();
    }

    if (_selectedCity != "Tümü") {
      filtered =
          filtered.where((player) => player.city == _selectedCity).toList();
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
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedPosition,
                          decoration: const InputDecoration(
                            labelText: 'Pozisyon',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
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
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedCity,
                          decoration: const InputDecoration(
                            labelText: 'Şehir',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                          items: _cities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedCity = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _sortBy,
                    decoration: const InputDecoration(
                      labelText: 'Sırala',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
              padding: const EdgeInsets.all(16),
              itemCount: _filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = _filteredPlayers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(player.photoUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                player.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    player.city,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.sports_soccer,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    player.position,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.person,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${player.age} yaş, ${player.height}m, ${player.weight}kg',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
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
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Mesaj Gönder'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('İletişime Geç'),
                        ),
                      ],
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
