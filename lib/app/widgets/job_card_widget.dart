import 'package:flutter/material.dart';

Widget jobCard(BuildContext context, JobCardItem job) {
  final mq = MediaQuery.of(context).size;

  return Container(
    height: mq.height * 0.12,
    width: mq.width * 0.9,
    margin: EdgeInsets.all(mq.height * 0.01),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffc2c2c2),
          spreadRadius: 1,
          blurRadius: 1,
        )
      ],
    ),
    child: Row(
      children: [
        Center(
          child: Container(
            height: mq.height * 0.09,
            width: mq.height * 0.09,
            margin: EdgeInsets.all(mq.height * 0.01),
            decoration: BoxDecoration(
              color: const Color(0xfff4f3f1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffc2c2c2),
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  job.icon,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.jobRole,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  job.companyName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: Colors.grey[700]),
                    Text(
                      '\$${job.salary}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[700]),
                    Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}

class JobCardItem {
  final String icon;
  final String jobRole;
  final String companyName;
  final String location;
  final String salary;

  JobCardItem({
    required this.icon,
    required this.jobRole,
    required this.companyName,
    required this.location,
    required this.salary,
  });
}
