import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/common/widgets/custom_text_form_field.dart';
import 'package:evently/common/widgets/snack_bar_widget.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/presentation/new_event/provider/new_event_provider.dart';
import 'package:evently/presentation/new_event/widgets/categories_section.dart';
import 'package:evently/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});
  static const String routeName = "/newEventScreen";

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewEventProvider(),
      child: Builder(
        builder: (ctx) {
          NewEventProvider provider = Provider.of<NewEventProvider>(ctx, listen: true);
          NewEventProvider provider2 = Provider.of<NewEventProvider>(ctx, listen: false);

          return Scaffold(
            appBar: AppBar(title: Text("Create Event")),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  CategoriesSection(),
                  CustomTextFormField(
                    controller: _titleController,
                    prefixIcon: Assets.icons.emailIcon,
                    hintText: "Event Title",
                    title: "Title",
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return "title is required";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: _descriptionController,
                    title: "Description",
                    maxLines: 5,
                    hintText: "Event Description",
                  ),

                  Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.date_range),
                      Text(
                        "Event Date",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2040),
                            initialDate: provider2.eventSelectedDate,
                          );
                          if (selectedDate != null) {
                            provider2.changeDate(selectedDate);
                          }
                        },
                        child: Text(
                          provider.eventSelectedDate != null
                              ? DateFormat.yMd().format(provider.eventSelectedDate!)
                              : ("Choose Date").toString(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Icon(Icons.watch_later_outlined),
                      Text(
                        "Event Time",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: provider2.eventSelectedTime ?? TimeOfDay.now(),
                          );
                          if (selectedTime != null) {
                            provider2.changeTime(selectedTime);
                          }
                        },
                        child: Text(
                          (provider.eventSelectedTime?.format(context) ?? "Choose Time").toString(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                    isLoading: provider.isLoading,
                    label: "Add Event",
                    onPressed: () async {
                      bool formState = _formKey.currentState!.validate();
                      if (formState) {
                        if (provider2.eventSelectedDate == null) {
                          SnackBarHelper.errorSnackBar(context, "Date is Required!!");
                          return;
                        }
                        if (provider2.eventSelectedTime == null) {
                          SnackBarHelper.errorSnackBar(context, "Time is Required!!");
                          return;
                        }

                        provider2.updateLading(true);

                        try {
                          EventModel eventModel = EventModel(
                            categoriesEnum: provider2.selectedCategory,
                            date: provider2.getFormattedDateTime(),
                            description: _descriptionController.text,
                            title: _titleController.text,
                          );
                          await EventsService.addEvent(eventModel);
                          if (context.mounted) {
                            SnackBarHelper.successSnackBar(context, "event was added!!");
                            Navigator.pop(context, true);
                          }
                        } on Exception catch (e) {
                          if (context.mounted) {
                            SnackBarHelper.errorSnackBar(context, e.toString());
                          }
                        }
                        provider2.updateLading(false);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
