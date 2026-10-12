import 'package:evently/models/event_model.dart';
import 'package:evently/presentation/home/tabs/home_tab/home_tab_provider/home_tab_provider.dart';
import 'package:evently/presentation/home/widgets/event_card.dart';
import 'package:evently/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventsProvider>(context, listen: false).getFavEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    EventsProvider provider = Provider.of<EventsProvider>(context);

    if (provider.isLoadingFav) {
      return Center(child: CircularProgressIndicator());
    }
    if (provider.errorMessageFav != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    List<EventModel> events = provider.favEvent;
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<EventsProvider>(context, listen: false).getFavEvent();
      },
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => EventCard(eventModel: events[index]),
      ),
    );
  }
}
