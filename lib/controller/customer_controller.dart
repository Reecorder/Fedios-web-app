import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fideos_web/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  /* creating firestore collection for Customers */
  CollectionReference customerTable =
      FirebaseFirestore.instance.collection('customers');

  /* customer titles listS */
  List<String> titles = [
    "Customer Id",
    "Doc Id",
    "Enabled",
    "Customer Name",
    "Customer Email",
    "Customer Phone",
    "Customer Image"
  ];

  /* customer data */
  RxList<List<String>> customers = <List<String>>[].obs;

  /* customer data - customer model format */
  RxList<Customer> customersParsed = <Customer>[].obs;

  /* customers loading */
  RxBool customersLoading = false.obs;

  /* customer add or updating */
  RxBool customersAddUpdating = false.obs;

  /* selected customer */
  Rx<Customer> selectedCustomer = Customer().obs;

  /* textediting controllers */
  TextEditingController customerName = TextEditingController();
  TextEditingController customerEmail = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController customerDefaultAddress = TextEditingController();

  /* customer gender */
  List<String> genderOptions = ["Male", "Female", "Others"];

  /* selected customer gender */
  RxString selectedCustomerGender = "Male".obs;

  /* customer enabled */
  RxBool customerEnabled = false.obs;

  /* adding customer */
  RxBool addingCustomer = false.obs;

  /* fetch customers from firestore database */
  void get fetchCustomers async {
    /* customer loading started */
    customersLoading(true);

    /* clearing previous data */
    customers.clear();
    customersParsed.clear();

    try {
      /* fetching customers from firestore - query snapshot from customer table */
      QuerySnapshot querySnapshot = await customerTable.get();

      /* list of docs of customer table */
      final docs = querySnapshot.docs;

      /* looping through every docs and parsing data */
      for (var doc in docs) {
        /* changin the data type */
        final rawData = doc.data() as Map<String, dynamic>;

        /* parsing into customer object */
        Customer customer = Customer.fromJson(rawData);

        /* customer doc id */
        customer.docId = doc.id;

        /* adding customer into the parsed customer list */
        customersParsed.add(customer);

        /* adding customer into the table data */
        customers.add([
          customer.id.toString(),
          customer.docId.toString(),
          customer.enable.toString(),
          customer.name.toString(),
          customer.email.toString(),
          customer.phone.toString(),
          customer.image.toString(),
        ]);
      }
    } catch (e) {
      /* showing error */
      log(e.toString());
    }

    /* refresing the lists */
    customers.refresh();
    customersParsed.refresh();

    /* customer loading ended */
    customersLoading(false);
  }

  /* add customer to firestore database */
  void get addCustomer async {
    /* adding customer - button loading */
    addingCustomer(true);

    /* preparing a random customer id */
    final randomCustomerId = "Customer-${math.Random().nextInt(1000)}"; /*  */

    /* customer object */
    final customer = {
      "id": randomCustomerId.toString(),
      "name": customerName.text.toString(),
      "email": customerEmail.text.toString(),
      "phone": customerPhone.text.toString(),
      "gender": selectedCustomerGender.value.toString(),
      "enable": true
    };

    try {
      /* adding customer in database */
      await customerTable.add(customer);
      /* refreshing customer table & going back */
      fetchCustomers;
      Get.back();
    } catch (e) {
      log(e.toString());
    }

    /* adding customer - button loading end */
    addingCustomer(false);
  }

  /* update customer to firestore database */
  void get updateCustomer async {
    /* adding customer - button loading */
    addingCustomer(true);

    /* selected customer id */
    final customerDocId = selectedCustomer.value.docId;

    /* updated customer */
    final customer = {
      "name": customerName.text.toString(),
      "email": customerEmail.text.toString(),
      "phone": customerPhone.text.toString(),
      "gender": selectedCustomerGender.value.toString(),
      "enable": customerEnabled.value
    };

    try {
      /* updating customer */
      await customerTable.doc(customerDocId).update(customer);

      /* refreshing customer table & going back */
      fetchCustomers;

      Get.back();
    } catch (e) {
      /* logging error */
      log(e.toString());
    }

    /* adding customer - button loading end */
    addingCustomer(false);
  }
}
