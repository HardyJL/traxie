import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [CircularProgressIndicator()],
            //   children: provider.pastPeriods.ignoreLast().map((e) {
            // return Padding(
            //   padding: const EdgeInsets.only(bottom: 32.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               e.periodLength.toString(),
            //               style: Theme.of(context).textTheme.headlineSmall,
            //             ),
            //             Text(
            //               e.cycleLength.toString(),
            //               style: Theme.of(context).textTheme.headlineSmall,
            //             ),
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 12,
            //       ),
            //       SizedBox(
            //         height: 24,
            //         width: MediaQuery.of(context).size.width / 33,
            //         child: LinearProgressIndicator(

            //             // value: e.periodLength / e.cycleLength,
            //             ),
            //       ),
            //     ],
            //   ),
            // );
            // }).toList()),
          ),
        ),
      ),
    );
  }
}
