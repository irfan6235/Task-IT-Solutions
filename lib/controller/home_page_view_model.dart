import 'package:get/get.dart';
import 'dart:html' as html;

/// ViewModel for the Home Page, managing state and logic.
class HomePageViewModel extends GetxController {
  /// Observable variable holding the image URL.
  var imageUrl = ''.obs;

  /// Observable boolean indicating fullscreen mode status.
  var isFullscreen = false.obs;

  /// Observable boolean for menu visibility state.
  var isMenuVisible = false.obs;

  /// Loads an image from the provided URL.
  void loadImage(String url) {
    imageUrl.value = url;
  }

  /// Toggles fullscreen mode for the web application.
  void toggleFullscreen() {
    if (isFullscreen.value) {
      html.document.exitFullscreen();
    } else {
      html.document.documentElement?.requestFullscreen();
    }
    isFullscreen.toggle();
  }

  /// Toggles the visibility of the context menu.
  void toggleMenu() {
    isMenuVisible.toggle();
  }

  /// Closes the context menu.
  void closeMenu() {
    isMenuVisible.value = false;
  }
}
