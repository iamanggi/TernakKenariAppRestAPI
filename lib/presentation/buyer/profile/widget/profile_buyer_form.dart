
import 'package:canary/data/model/request/buyer/buyer_profile_request_model.dart';
import 'package:canary/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBuyerInputForm extends StatefulWidget {
  const ProfileBuyerInputForm({super.key});

  @override
  State<ProfileBuyerInputForm> createState() => ProfileBuyerInputFormState();
}

class ProfileBuyerInputFormState extends State<ProfileBuyerInputForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
      builder: (context, state) {
        final isLoading = state is ProfileBuyerLoading;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Nama"),
                  validator: (value) =>
                      value!.isEmpty ? "Nama tidak boleh kosong" : null,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Alamat"),
                  validator: (value) =>
                      value!.isEmpty ? "Alamat tidak boleh kosong" : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: "No HP"),
                  validator: (value) =>
                      value!.isEmpty ? "Nomor HP tidak boleh kosong" : null,
                ),
                const SizedBox(height: 20),
                BlocConsumer<ProfileBuyerBloc, ProfileBuyerState>(
                  listener: (context, state) {
                    if (state is ProfileBuyerAdded) {
                      // Refresh profile after adding
                      context.read<ProfileBuyerBloc>().add(
                        GetProfileBuyerEvent(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.profile.message)),
                      );
                    } else if (state is ProfileBuyerError) {
                      // Tampilkan error ke debug console dan UI
                      print("ProfileBuyerError: ${state.message}");
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final request = BuyerProfileRequestModel(
                                  name: nameController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  photo: "",
                                );

                                // Tampilkan data yang dikirim di debug console
                                print("Mengirim data profil: ${request.toJson()}");

                                context.read<ProfileBuyerBloc>().add(
                                  AddProfileBuyerEvent(requestModel: request),
                                );
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                          : const Text("Simpan Profil"),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}