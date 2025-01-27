import 'package:fideos_web/common/common_scrollbar.dart';
import 'package:fideos_web/controller/customer_controller.dart';
import 'package:fideos_web/model/color.dart';
import 'package:fideos_web/presentation/customers/add_and_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_table.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  /* importing customer controller */
  final controller = Get.put(CustomerController());

  @override
  void initState() {
    super.initState();
    controller.fetchCustomers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addButton,
      body: Obx(
        () {
          if (controller.customersLoading.value) {
            return Center(
                child: CircularProgressIndicator(color: AppColor.primary));
          } else {
            return CommonScrollBar(
              child: CommonTable(
                data: controller.customers,
                titles: controller.titles,
                onPressed: (index) {
                  controller.selectedCustomer.value =
                      controller.customersParsed[index];
                  Get.to(
                    () => const AddUpdateCustomer(update: true),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  /* add button */
  Widget get addButton => FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Get.to(() => const AddUpdateCustomer(update: false));
        },
      );
}
