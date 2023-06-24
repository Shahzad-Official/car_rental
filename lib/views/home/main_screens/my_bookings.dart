import 'package:car_rental/services/booking_services.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  final BookingServices _services = BookingServices();
  bool isLoading = false;
  getData() async {
    setState(() {
      isLoading = true;
    });
    await _services.getMyBookings();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: "My Bookings"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getData();
        },
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      height: 200,
                      width: double.maxFinite,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
