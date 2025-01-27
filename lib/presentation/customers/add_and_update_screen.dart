import 'package:fideos_web/common/common_dropdown.dart';
import 'package:fideos_web/model/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_button.dart';
import '../../common/common_textfield.dart';
import '../../controller/customer_controller.dart';

class AddUpdateCustomer extends StatefulWidget {
  const AddUpdateCustomer({super.key, required this.update});

  /* logic - is the update is true then this screen will act as update
    if the update is false this screen will act as the add category screen  */
  final bool update;

  @override
  State<AddUpdateCustomer> createState() => _AddUpdateCustomerState();
}

class _AddUpdateCustomerState extends State<AddUpdateCustomer> {
  /* importing customer controller */
  final controller = Get.put(CustomerController());

  @override
  void initState() {
    super.initState();
    if (widget.update) {
      /* when this screen is a update screen */
      /* selected customer */
      final customer = controller.selectedCustomer.value;

      /* prefilling all the controllers */
      controller.customerName.text = customer.name ?? "";
      controller.customerEmail.text = customer.email ?? "";
      controller.customerPhone.text = customer.phone ?? "";
      controller.customerEnabled.value = customer.enable ?? false;
      controller.selectedCustomerGender.value = customer.gender ?? "Male";
    } else {
      /* when this screen is a add screen */
      controller.customerName.clear();
      controller.customerEmail.clear();
      controller.customerPhone.clear();
      controller.customerEnabled.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: AppBar(
          backgroundColor: AppColor.primary,
          title: Text(
            "Fideos Admin Panel - ${widget.update ? "Update" : "Add"} Customer",
            style: TextStyle(
              color: AppColor.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              CommonTextField(
                  controller: controller.customerName, hint: "Customer Name"),
              const SizedBox(height: 20),
              CommonTextField(
                  controller: controller.customerEmail, hint: "Customer Email"),
              const SizedBox(height: 20),
              CommonTextField(
                  controller: controller.customerPhone,
                  hint: "Customer Phone No"),
              const SizedBox(height: 20),
              Obx(() => CommonDropdown(
                    hint: "Customer Gender",
                    value: controller.selectedCustomerGender.value,
                    items: controller.genderOptions,
                    onChanged: (gender) {
                      controller.selectedCustomerGender.value = gender;
                    },
                  )),
              if (widget.update)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(children: [
                      const SizedBox(
                          width: 200, child: Text("Customer Enable")),
                      const SizedBox(width: 15),
                      Obx(() => CupertinoSwitch(
                            value: controller.customerEnabled.value,
                            activeColor: AppColor.primary,
                            onChanged: (value) {
                              controller.customerEnabled(
                                  !controller.customerEnabled.value);
                            },
                          ))
                    ]),
                  ],
                ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.addingCustomer.value) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  );
                } else {
                  return CommonButton(
                      title: widget.update ? "Update Customer" : "Add Customer",
                      onPressed: () {
                        if (widget.update) {
                          controller.updateCustomer;
                        } else {
                          controller.addCustomer;
                        }
                      });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
