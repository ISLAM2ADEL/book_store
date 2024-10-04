import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../book space cubit/admin cubit/dashboard cubit/dash_cubit.dart';
import '../../../const.dart';
import '../admin app bar/admin_app_bar.dart';
import '../admin bottom nav bar/admin_nav_bar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashCubit>();

    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: const AdminNavBar(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AdminAppBar(),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DashCubit, DashState>(
          builder: (context, state) {
            if (state is DashLoading) {
              return Transform.translate(
                offset: const Offset(0, 330),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Column(
              children: [
                _percentageIndicator(
                  text: "Number of books in Book Space:",
                  colors: Colors.green,
                  number: cubit.bookCounters().toString(),
                  percentage: cubit.bookCounters(),
                  totalBooks: bookStore,
                ),
                _percentageIndicator(
                  text: "Number of paid books in Book Space:",
                  colors: Colors.orange,
                  number: cubit.paidBookCounters().toString(),
                  percentage: cubit.paidBookCounters(),
                  totalBooks: bookStore,
                ),
                _percentageIndicator(
                  text: "Number of free books in Book Space:",
                  colors: Colors.blue,
                  number: cubit.freeBookCounters().toString(),
                  percentage: cubit.freeBookCounters(),
                  totalBooks: bookStore,
                ),
                _percentageIndicator(
                  text: "Number of categories in Book Space:",
                  colors: Colors.red,
                  number: cubit.categoryCounters().toString(),
                  percentage: cubit.categoryCounters(),
                  totalBooks: categoryCount,
                ),
                _percentageIndicator(
                  text: "Number of authors in Book Space:",
                  colors: Colors.purple,
                  number: cubit.authorsCounters().toString(),
                  percentage: cubit.authorsCounters(),
                  totalBooks: authorCount,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _percentageIndicator({
    required String text,
    required Color colors,
    required String number,
    required int percentage,
    required int totalBooks,
  }) {
    // Ensure totalBooks is not zero to avoid division by zero
    double percentValue = totalBooks > 0 ? (percentage / totalBooks) : 0.0;

    // Clamp the value to be between 0.0 and 1.0
    percentValue = percentValue.clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          CircularPercentIndicator(
            animation: true,
            radius: 42.0,
            lineWidth: 7.0,
            percent: percentValue,
            center: Text(number),
            animationDuration: 1200,
            progressColor: colors,
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
