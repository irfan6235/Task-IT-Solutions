import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import '../controller/home_page_view_model.dart';

/// The Home Page widget of the application.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageViewModel controller = Get.put(HomePageViewModel());

    // Create an HTML image element for displaying images.
    html.ImageElement imageElement = html.ImageElement()
      ..style.width = '100%'
      ..style.height = 'auto'
      ..onDoubleClick.listen((event) {
        controller
            .toggleFullscreen(); // Toggle fullscreen mode on double click.
      });

    // Register the HTML element view factory for embedding it in Flutter.
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'image-view',
      (int viewId) => imageElement,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(() => controller.imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  const HtmlElementView(viewType: 'image-view'),
                            )
                          : const Center(child: Text('No image loaded'))),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(hintText: 'Image URL'),
                        onChanged: (value) {
                          controller.imageUrl.value = value;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.loadImage(controller.imageUrl.value);
                        imageElement.src = controller.imageUrl.value;
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
          Obx(() => controller.isMenuVisible.value
              ? GestureDetector(
                  onTap: controller.closeMenu,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                )
              : Container()),
          Obx(() => controller.isMenuVisible.value
              ? Positioned(
                  right: 16,
                  bottom: 80,
                  child: Material(
                    color: Colors.white,
                    elevation: 8,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              controller.toggleFullscreen();
                              controller.closeMenu();
                            },
                            child: Text(controller.isFullscreen.value
                                ? 'Exit fullscreen'
                                : 'Enter fullscreen'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.toggleMenu,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
