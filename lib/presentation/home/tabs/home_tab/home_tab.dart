import 'package:evently/common/enums/categories_enum.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/presentation/home/tabs/home_tab/home_tab_provider/home_tab_provider.dart';
import 'package:evently/presentation/home/widgets/event_card.dart';
import 'package:evently/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    EventsProvider provider = Provider.of<EventsProvider>(context);

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    List<EventModel> events = provider.events;
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => EventCard(eventModel: events[index]),
    );
  }
}
