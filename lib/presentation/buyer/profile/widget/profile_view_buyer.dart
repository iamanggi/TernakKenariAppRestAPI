import 'package:canary/data/model/response/buyer/buyer_profile_response_model.dart';
import 'package:canary/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:canary/presentation/buyer/profile/widget/profile_buyer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBuyer extends StatefulWidget {
  final Data profile;
  const ProfileViewBuyer({super.key, required this.profile});

  @override
  State<ProfileViewBuyer> createState() => _ProfileViewBuyerState();
}

class _ProfileViewBuyerState extends State<ProfileViewBuyer> {
  @override
  initState() {
    super.initState();
    // Ambil profil pembeli saat halaman dimuat
    context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Pembeli")),
      body: BlocListener<ProfileBuyerBloc, ProfileBuyerState>(
        listener: (context, state) {
          if (state is ProfileBuyerAdded) {
            // Refresh profil setelah tambah
            context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profil berhasil ditambahkan")),
            );
          }
        },
        child: BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
          builder: (context, state) {
            if (state is ProfileBuyerLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProfileBuyerLoaded &&
                state.profile.data.name.isNotEmpty) {
              final profile = state.profile.data;
              return ProfileViewBuyer(profile: profile);
            }

            // Default ke form jika tidak ada data atau error
            return ProfileBuyerInputForm();
          },
        ),
      ),
    );
  }
}