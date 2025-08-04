import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExamOptionCard extends ConsumerWidget {
  final String option;
  final bool isMultiChoice; // Parameter to define if it's multi-choice

  const ExamOptionCard({
    super.key,
    required this.option,
    this.isMultiChoice = false, // Default to single choice
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if the option is selected
    bool isSelected = isMultiChoice
        ? ref.watch(selectedOptionsProvider).contains(option)
        : ref.watch(selectedOptionProvider) == option;

    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (isMultiChoice) {
            // Handle multi-choice selection
            final currentSelections =
                ref.read(selectedOptionsProvider.notifier).state;
            if (currentSelections.contains(option)) {
              // Deselect the option
              ref.read(selectedOptionsProvider.notifier).state =
                  List.from(currentSelections)..remove(option);
            } else {
              // Select the option
              ref.read(selectedOptionsProvider.notifier).state =
                  List.from(currentSelections)..add(option);
            }
          } else {
            // Handle single-choice selection
            ref.read(selectedOptionProvider.notifier).state = option;
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : const Color(0xFFF6F6F6),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.grey,
                  disabledColor: Colors.grey,
                ),
                child: isMultiChoice
                    ? Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          if (value == true) {
                            ref.read(selectedOptionsProvider.notifier).state =
                                List.from(ref.read(selectedOptionsProvider))
                                  ..add(option);
                          } else {
                            ref.read(selectedOptionsProvider.notifier).state =
                                List.from(ref.read(selectedOptionsProvider))
                                  ..remove(option);
                          }
                        },
                      )
                    : Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        value: option,
                        groupValue: ref.watch(selectedOptionProvider),
                        onChanged: (value) {
                          ref.read(selectedOptionProvider.notifier).state =
                              value as String;
                        },
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  option[0].toUpperCase() + option.substring(1),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Providers for single and multi-choice
final selectedOptionProvider = StateProvider<String?>((ref) => null);
final selectedOptionsProvider = StateProvider<List<String>>((ref) => []);
