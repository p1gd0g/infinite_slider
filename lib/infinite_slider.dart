import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteSliderData {
  InfiniteSliderData(this.value);

  int value;
  var sliderValue = 0.5.obs;

  int min() {
    if (value <= 0) {
      return 0;
    }

    var min = (value * 0.3).round();
    if (min == value) {
      min = value - 1;
    }
    return min;
  }

  int max() {
    if (value <= 0) {
      return 1;
    }
    var max = (value * 1.7).round();
    if (max == value) {
      max = value + 1;
    }
    return max;
  }

  int current() {
    return (sliderValue.value * (max() - min()) + min()).round();
  }
}

class InfiniteSliderV1 extends StatelessWidget {
  const InfiniteSliderV1(this.data, {super.key, this.titleFormater});

  final InfiniteSliderData data;
  final String? Function(String?)? titleFormater;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleFormater?.call(data.current().toString()) ??
                  data.current().toString(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.min().toString()),
                ),
                Expanded(
                  child: Slider(
                    onChanged: (value) {
                      data.sliderValue.value = value;
                    },
                    onChangeEnd: (value) {
                      data.value = data.current();
                      data.sliderValue.value = 0.5;
                    },
                    value: data.sliderValue.value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.max().toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
