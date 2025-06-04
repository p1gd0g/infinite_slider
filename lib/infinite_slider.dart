import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteSliderData {
  InfiniteSliderData(this.value);

  double value;
  var sliderValue = 0.5.obs;

  double min() {
    return value * 0.3;
  }

  double max() {
    if (value <= 0) {
      return 1;
    }
    return value * 1.7;
  }

  double current() {
    return sliderValue.value * (max() - min()) + min();
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
            Text(titleFormater?.call(data.current().round().toString()) ??
                data.current().round().toString()),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.min().round().toString()),
              ),
              Expanded(
                child: Slider(
                  onChanged: (value) {
                    data.sliderValue.value = value;
                  },
                  onChangeEnd: (value) {
                    data.value = data.current().round().toDouble();
                    data.sliderValue.value = 0.5;
                  },
                  value: data.sliderValue.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data.max().round().toString()),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
