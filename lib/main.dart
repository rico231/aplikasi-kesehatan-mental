import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppointmentScreen(),
    );
  }
}

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? selectedDate;
  String? selectedTime;

  // List of available times
  List<String> availableTimes = [
    "9:15 AM",
    "9:30 AM",
    "9:45 AM",
    "10:00 AM",
    "1:00 PM",
    "1:15 PM",
    "1:30 PM",
    "1:45 PM"
  ];

  // Function to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Function to select a time
  void _selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Care'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 194),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor info
            const Text(
              'Dr. Carlly',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'psychiatrist',
              style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 178, 23, 95)),
            ),
            const SizedBox(height: 20),

            // Select Appointment Date
            const Text(
              'Select Appointment Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Choose a Date'
                          : "${selectedDate!.toLocal()}".split(' ')[0],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Select Available Time
            const Text(
              'Select Available Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              itemCount: availableTimes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _selectTime(availableTimes[index]),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedTime == availableTimes[index]
                          ? Colors.blue
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      availableTimes[index],
                      style: TextStyle(
                        color: selectedTime == availableTimes[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Reason for Visit
            const TextField(
              decoration: InputDecoration(
                labelText: 'Reason for Visit',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Book Appointment Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking logic here
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text('BOOK APPOINTMENT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

