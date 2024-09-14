import '../../../core/imports/core_imports.dart';
import 'raw_toast.dart';

/// Enum for snackbar positions
enum ToastPosition { top, bottom }

/// The gap between stack of cards
int gapBetweenCard = 15;

/// calculate position of old cards based on current position
double calculatePosition(List<ToastBar> toastBars, ToastBar self) {
  if (toastBars.isNotEmpty && self != toastBars.last) {
    final box = self.info.key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      return gapBetweenCard * (toastBars.length - toastBars.indexOf(self) - 1);
    }
  }
  return 0;
}

/// rescale the old cards based on its position
double calculateScaleFactor(List<ToastBar> toastBars, ToastBar current) {
  int index = toastBars.indexOf(current);
  int indexValFromLast = toastBars.length - 1 - index;
  double factor = indexValFromLast / 25;
  double res = 0.97 - factor;
  return res < 0 ? 0 : res;
}

List<ToastBar> _toastBars = [];

/// Toast core class
class ToastBar {
  /// Duration of toast when autoDismiss is true
  final Duration toastDuration;

  /// Position of toast
  final ToastPosition position;

  /// Set true to dismiss toast automatically based on snackbarDuration
  final bool autoDismiss;

  /// Pass the widget inside builder context
  final WidgetBuilder builder;

  /// Duration of animated transitions
  final Duration animationDuration;

  /// Animation Curve
  final Curve? animationCurve;

  /// Info on each snackbar
  late final SnackBarInfo info;

  /// Initialise Toastbar with required parameters
  ToastBar({
    this.toastDuration = const Duration(milliseconds: 5000),
    this.position = ToastPosition.bottom,
    required this.builder,
    this.animationDuration = const Duration(milliseconds: 700),
    this.autoDismiss = false,
    this.animationCurve,
  }) : assert(toastDuration.inMilliseconds > animationDuration.inMilliseconds);

  /// Remove individual toasbars on dismiss
  void remove() {
    info.entry.remove();
    _toastBars.removeWhere((element) => element == this);
  }

  /// Push the snackbar in current context
  void show(BuildContext context) {
    OverlayState overlayState = Navigator.of(context).overlay!;
    info = SnackBarInfo(
      key: GlobalKey<RawToastState>(),
      createdAt: DateTime.now(),
    );
    info.entry = OverlayEntry(
      builder: (_) => RawToast(
        key: info.key,
        animationDuration: animationDuration,
        toastPosition: position,
        animationCurve: animationCurve,
        autoDismiss: autoDismiss,
        getPosition: () => calculatePosition(_toastBars, this),
        getscaleFactor: () => calculateScaleFactor(_toastBars, this),
        snackbarDuration: toastDuration,
        onRemove: remove,
        child: builder.call(context),
      ),
    );

    _toastBars.add(this);
    overlayState.insert(info.entry);
  }

  /// Remove all the snackbar in the context
  static void removeAll() {
    for (int i = 0; i < _toastBars.length; i++) {
      _toastBars[i].info.entry.remove();
    }
    _toastBars.removeWhere((element) => true);
  }
}

/// Snackbar info class
class SnackBarInfo {
  late final OverlayEntry entry;
  final GlobalKey<RawToastState> key;
  final DateTime createdAt;

  SnackBarInfo({required this.key, required this.createdAt});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SnackBarInfo &&
        other.entry == entry &&
        other.key == key &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => entry.hashCode ^ key.hashCode ^ createdAt.hashCode;
}

/// Get all the toastbars which currenlty on context
extension Cleaner on List<ToastBar> {
  /// clean function to iterate over toastbars which are in context
  List<ToastBar> clean() {
    return where((element) => element.info.key.currentState != null).toList();
  }
}
