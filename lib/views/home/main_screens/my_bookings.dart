import 'package:car_rental/constants/api_constants.dart';
import 'package:car_rental/constants/app_spacing.dart';
import 'package:car_rental/services/booking_services.dart';
import 'package:car_rental/views/home/main_screens/bookings_views/booking_details.dart';
import 'package:car_rental/widgets/app_cached_image.dart';
import 'package:car_rental/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

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

  Socket socket = io(
    ApiConstants.baseUrl,
    OptionBuilder().setTransports(["websocket"]).build(),
  );

  socketConnections() {
    socket.connect();
    socket.onConnect(
      (data) => debugPrint("connected"),
    );
    socket.onDisconnect(
      (data) => debugPrint("disconnected"),
    );
  }

  @override
  void initState() {
    getData();
    socketConnections();

    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _services.allBookings.isEmpty
                ? Center(
                    child: AppText(
                      text: "No Booking Found",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : ListView.builder(
                    itemCount: _services.allBookings.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              AppSpacing.heightSpace10,
                              AppCachedImage(
                                height: 100,
                                width: 200,
                                url: _services.allBookings[index].carData!.thumbnail.toString(),
                              ),
                              ListTile(
                                visualDensity: const VisualDensity(vertical: -3),
                                title: const AppText(
                                  text: "Car Name",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                trailing: AppText(
                                  text: _services.allBookings[index].carData!.carname.toString(),
                                ),
                              ),
                              ListTile(
                                visualDensity: const VisualDensity(vertical: -3),
                                title: const AppText(
                                  text: "Brand Name",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                trailing: AppText(
                                  text: _services.allBookings[index].brandData!.name.toString(),
                                ),
                              ),
                              ListTile(
                                visualDensity: const VisualDensity(vertical: -3),
                                title: const AppText(
                                  text: "Owner Name",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                trailing: AppText(
                                  text: "${_services.allBookings[index].ownerData!.firstname} ${_services.allBookings[index].ownerData!.lastname}",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => BookingDetails(
                                      bookingData: _services.allBookings[index],
                                    ),
                                  );
                                },
                                child: const AppText(
                                  text: "See Details",
                                ),
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
