# date_range_merger

## Exercise: Implementing and Testing `mergeDateRanges` Method

### Objective
The goal of this exercise is to implement the `mergeDateRanges` method in the `TimeRangePickerHelper` class. This method should merge overlapping or consecutive time ranges from a given list of `TimeRange` objects.

### Description
The `mergeDateRanges` method takes a list of `TimeRange` objects and returns a new list where overlapping or consecutive time ranges are merged into single time ranges. The method should handle the following scenarios:
1. **No Overlap**: If there are no overlapping or consecutive time ranges, the method should return the original list.
2. **Consecutive Ranges**: If two or more time ranges are consecutive, they should be merged into a single time range.
3. **Overlapping Ranges**: If two or more time ranges overlap, they should be merged into a single time range.
4. **24-Hour Boundary**: The method should correctly handle merging time ranges that overlap the 24-hour boundary (e.g., from 23:00 to 01:00).

### Steps
1. **Sort the Time Ranges**: Start by sorting the list of `TimeRange` objects by their `startTime`.
2. **Merge Ranges**: Iterate through the sorted list and merge overlapping or consecutive time ranges.
3. **Return the Result**: Return the list of merged time ranges.

### Example
Given the following list of `TimeRange` objects:
- `TimeRange(startTime: TimeOfDay(hour: 0, minute: 0), endTime: TimeOfDay(hour: 1, minute: 0))`
- `TimeRange(startTime: TimeOfDay(hour: 1, minute: 0), endTime: TimeOfDay(hour: 2, minute: 0))`
- `TimeRange(startTime: TimeOfDay(hour: 3, minute: 0), endTime: TimeOfDay(hour: 4, minute: 0))`

The `mergeDateRanges` method should return:
- `TimeRange(startTime: TimeOfDay(hour: 0, minute: 0), endTime: TimeOfDay(hour: 2, minute: 0))`
- `TimeRange(startTime: TimeOfDay(hour: 3, minute: 0), endTime: TimeOfDay(hour: 4, minute: 0))`
