import 'package:evently/common/app_text_styles.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/presentation/home/tabs/home_tab/home_tab_provider/home_tab_provider.dart';
import 'package:evently/services/events_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventModel});
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(eventModel.categoriesEnum.getImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${eventModel.dateValu.day}\n",
                    style: AppTextStyles.styleS20W700(color: Theme.of(context).colorScheme.primary),
                  ),
                  TextSpan(text: DateFormat("MMM").format(eventModel.dateValu)),
                ],
              ),
              style: AppTextStyles.styleS14W700(color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventModel.title,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),
                IconButton(
                  onPressed: () async {
                    if (eventModel.isFav) {
                      (eventModel.favorites ?? []).remove(FirebaseAuth.instance.currentUser?.uid);
                    } else {
                      eventModel.favorites = [
                        ...(eventModel.favorites ?? []),
                        FirebaseAuth.instance.currentUser?.uid ?? '',
                      ];
                    }

                    Provider.of<EventsProvider>(context, listen: false).updateEvent(eventModel);
                    await EventsService.updateFav(eventModel);
                  },
                  icon: Icon(
                    eventModel.isFav ? Icons.favorite : Icons.favorite_border_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
