import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:aura/core/imports/core_imports.dart';
import 'package:aura/core/imports/packages_imports.dart';
import 'package:aura/helpers/ask_permission.dart';
import 'package:blobs/blobs.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceView extends StatefulHookConsumerWidget {
  final ValueNotifier<String?> recordedVoice;

  const VoiceView({super.key, required this.recordedVoice});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VoiceViewState();
}

class _VoiceViewState extends ConsumerState<VoiceView> {
  late RecorderController recorder;
  late PlayerController playerController;

  @override
  void initState() {
    recorder = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..bitRate = 48000
      ..recordedDuration = const Duration(seconds: 5)
      ..sampleRate = 44100;
    playerController = PlayerController();
    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = useState(false);

    void onRecord() async {
      final permission = await askPermission(
          name: 'Microphone', permission: Permission.microphone);

      if (permission) {
        if (isPlaying.value == true) {
          recorder.reset();

          final result = await recorder.stop(false);

          logSuccess('Recording Stopped with ${result ?? 'No audio found'}');
          widget.recordedVoice.value = result;
          isPlaying.value = false;

          await playerController.preparePlayer(
            path: result!,
            shouldExtractWaveform: true,
            noOfSamples: 100,
            volume: 1.0,
          );
          await playerController.startPlayer(finishMode: FinishMode.stop);
        } else {
          widget.recordedVoice.value = null;

          await recorder.record();
          isPlaying.value = true;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.recordedVoice.value != null
            ? AudioFileWaveforms(
                size: Size(context.width * 0.8, 120.0),
                playerController: playerController,
                enableSeekGesture: true,
                waveformType: WaveformType.long,
                playerWaveStyle: const PlayerWaveStyle(
                  fixedWaveColor: Colors.white54,
                  liveWaveColor: Colors.blueAccent,
                  spacing: 10,
                ),
              )
            : Blob.animatedRandom(
                size: context.height * 0.3,
                loop: true,
                duration: 1.seconds,
                styles: BlobStyles(
                  color: AppColors.customGrey,
                ),
                child: Center(
                  child: Lottie.asset(
                    AssetsManager.audioWavesAnimation,
                    animate: isPlaying.value,
                    width: context.width * 0.35,
                  ),
                ),
              )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2000.ms),
        GestureDetector(
          onTap: onRecord,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: isPlaying.value
                ? const Icon(
                    key: ValueKey('stop'),
                    IconsaxBold.stop_circle,
                    size: 70,
                  )
                : const Icon(
                    key: ValueKey('play'),
                    IconsaxBold.play_circle,
                    size: 70,
                  ),
          ),
        ),
      ],
    );
  }
}
