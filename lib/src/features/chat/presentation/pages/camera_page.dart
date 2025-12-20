import 'package:clone_whatsapp_round34/src/core/services/services.dart';
import 'package:clone_whatsapp_round34/src/features/chat/domain/repositories/camera_repository.dart';
import 'package:clone_whatsapp_round34/src/features/chat/domain/repositories/camera_repository_impl.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/camera_bloc.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/camera_event.dart';
import 'package:clone_whatsapp_round34/src/features/chat/presentation/bloc/camera_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final CameraBloc bloc;

  @override
  void initState() {
    super.initState();
    final CameraRepository repo = CameraRepositoryImpl();
    final perms = PermissionsService();
    bloc = CameraBloc(cameraRepository: repo, permissionsService: perms);
    bloc.add(InitCamerasEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text('Camera'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          body: BlocBuilder<CameraBloc, CameraState>(builder: (context, state) {
            if (state.controller == null ||
                !state.controller!.value.isInitialized) {
              return const Center(child: CircularProgressIndicator());
            }
            //TODO: Don't forget that method can not be null
            return Container();
          }),
        ));
  }
}
