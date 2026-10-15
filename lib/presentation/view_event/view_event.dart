import 'package:evently/app_provider/app_provider.dart';
import 'package:evently/common/app_text_styles.dart';
import 'package:evently/common/theme/app_colors.dart';

import 'package:evently/models/event_model.dart';
import 'package:evently/presentation/view_event/edit_event.dart';
import 'package:evently/services/events_service.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewEvent extends StatelessWidget {
  const ViewEvent({super.key, required this.eventModel});
  static const String routeName = "/ViewEvent";
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Event details",
          style: AppTextStyles.styleS20W500(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 35,
            height: 35,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEvent(eventModel: eventModel),
                  ),
                );
              },
              icon: Icon(Icons.edit),
            ),
          ),
          SizedBox(width: 10),
         IconButton(
  icon: Icon(
    Icons.delete,
    color: AppColors.errorColor,
  ),
  onPressed: () async {
    // Ask for confirmation
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: const Text(
            'Are you sure you want to delete this event?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: AppColors.errorColor,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    final eventId = eventModel.id;

    if (eventId == null || eventId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot delete event: missing event ID'),
        ),
      );
      return;
    }

    try {
      await EventsService.deleteEvent(eventId);

      if (!context.mounted) return;

      // Return to the previous screen
      Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete event: $e'),
        ),
      );
    }
  },
),
        ],
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  eventModel.categoriesEnum.getImage(
                    context.watch<AppProvider>().themeMode,
                  ),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                eventModel.title,
                style: AppTextStyles.styleS22W500(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).splashColor,
                ),
                child: Row(
                  spacing: 20,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).cardColor,
                      size: 30,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${eventModel.dateValu.day} '
                                '${DateFormat("MMMM").format(eventModel.dateValu)}\n',
                            style: AppTextStyles.styleS20W500(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          TextSpan(
                            text: DateFormat(
                              "hh:mm a",
                            ).format(eventModel.dateValu),
                          ),
                        ],
                      ),
                      style: AppTextStyles.styleS14W500(
                        color: Theme.of(context).hintColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Text(
                "Description",
                style: AppTextStyles.styleS22W500(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 180),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).splashColor,
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: eventModel.description,
                        style: AppTextStyles.styleS14W500(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
