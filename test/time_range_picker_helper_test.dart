
import 'package:date_range_merger/helpers/time_range_picker_helper.dart';
import 'package:date_range_merger/models/time_range_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mergeDisabledTimes', () {
    test('Tests mergeDisabledTimes doesnt merge any dateranges when there is nothing to merge', (){
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
        TimeRange(
          startTime: TimeOfDay(hour: 2, minute: 0),
          endTime: TimeOfDay(hour: 3, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 2);
      expect(result[0], disabledTimes[0]);
      expect(result[1], disabledTimes[1]);
    });

    test('Test mergeDisabledTimes merges consecutive disabled times', () {
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
        // Merge with first one
        TimeRange(
          startTime: TimeOfDay(hour: 1, minute: 0),
          endTime: TimeOfDay(hour: 2, minute: 0),
        ),
        // Gap
        TimeRange(
          startTime: TimeOfDay(hour: 3, minute: 0),
          endTime: TimeOfDay(hour: 4, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 2);
      expect(result[0], TimeRange(
        startTime: TimeOfDay(hour: 0, minute: 0),
        endTime: TimeOfDay(hour: 2, minute: 0),
      ));
      expect(result[1], TimeRange(
        startTime: TimeOfDay(hour: 3, minute: 0),
        endTime: TimeOfDay(hour: 4, minute: 0),
      ));
    });

    test('Test mergeDisabledTimes does not merge first one and last one because they are not consecutive', () {
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
        TimeRange(
          startTime: TimeOfDay(hour: 2, minute: 0),
          endTime: TimeOfDay(hour: 3, minute: 0),
        ),
        TimeRange(
          startTime: TimeOfDay(hour: 3, minute: 0),
          endTime: TimeOfDay(hour: 4, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 2);
      expect(result[0], TimeRange(
        startTime: TimeOfDay(hour: 0, minute: 0),
        endTime: TimeOfDay(hour: 1, minute: 0),
      ));
      expect(result[1], TimeRange(
        startTime: TimeOfDay(hour: 2, minute: 0),
        endTime: TimeOfDay(hour: 4, minute: 0),
      ));
    });

    test('Test mergeDisabledTimes should merge 0 and 24 because they are consecutive.', () {
      // Arrange
      var disabledTimes = [
        // Merge with last one
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
        // gap
        TimeRange(
          startTime: TimeOfDay(hour: 2, minute: 0),
          endTime: TimeOfDay(hour: 3, minute: 0),
        ),
        // Merge this gap
        TimeRange(
          startTime: TimeOfDay(hour: 3, minute: 0),
          endTime: TimeOfDay(hour: 4, minute: 0),
        ),
        // gap
        TimeRange(
          startTime: TimeOfDay(hour: 23, minute: 0),
          endTime: TimeOfDay(hour: 24, minute: 0),
        ),
        // merge with first one
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 2);

    });

    test('Test mergeDisabledTimes should merge 0 and 24 because they are consecutive and intersecting', () {
      // Arrange
      var disabledTimes = [
        // Merge with last one
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 10),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
        // gap
        TimeRange(
          startTime: TimeOfDay(hour: 2, minute: 0),
          endTime: TimeOfDay(hour: 3, minute: 0),
        ),
        // Merge this gap
        TimeRange(
          startTime: TimeOfDay(hour: 3, minute: 0),
          endTime: TimeOfDay(hour: 4, minute: 0),
        ),
        // gap
        TimeRange(
          startTime: TimeOfDay(hour: 23, minute: 0),
          endTime: TimeOfDay(hour: 0, minute: 40),
        ),
        // merge with first one
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 2);
      expect(result[0], TimeRange(
        startTime: TimeOfDay(hour: 23, minute: 0),
        endTime: TimeOfDay(hour: 1, minute: 0),
      ));
      expect(result[1], TimeRange(
        startTime: TimeOfDay(hour: 2, minute: 0),
        endTime: TimeOfDay(hour: 4, minute: 0),
      ));

    });

    test('Test mergeDisabledTimes orders the timeRanges into right order', () {
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 3, minute: 0),
          endTime: TimeOfDay(hour: 4, minute: 0),
        ),
        TimeRange(
          startTime: TimeOfDay(hour: 2, minute: 0),
          endTime: TimeOfDay(hour: 3, minute: 0),
        ),
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 2);
      expect(result[0], TimeRange(
        startTime: TimeOfDay(hour: 0, minute: 0),
        endTime: TimeOfDay(hour: 1, minute: 0),
      ));
      expect(result[1], TimeRange(
        startTime: TimeOfDay(hour: 2, minute: 0),
        endTime: TimeOfDay(hour: 4, minute: 0),
      ));
    });


    test('Test mergeDisabledTimes returns empty list when disabledTimes is empty', () {
      // Arrange
      List<TimeRange> disabledTimes = [];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 0);
    });

    test('Test mergeDisabledTimes returns the same list when there is only one timeRange', () {
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 1, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 1);
      expect(result, disabledTimes);
    });

    test('Test mergeDisabledTimes returns the same list when there is only one timeRange and it is from 0 to 24', () {
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 24, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 1);
      expect(result, disabledTimes);
    });

    test('Test mergeDisabledTimes returns merged timeRange when they are overlapping', () {
      // Arrange
      var disabledTimes = [
        TimeRange(
          startTime: TimeOfDay(hour: 0, minute: 0),
          endTime: TimeOfDay(hour: 2, minute: 0),
        ),
        TimeRange(
          startTime: TimeOfDay(hour: 1, minute: 0),
          endTime: TimeOfDay(hour: 3, minute: 0),
        ),
      ];

      // Act
      var result = TimeRangePickerHelper.mergeDateRanges(disabledTimes);

      // Assert
      expect(result.length, 1);
      expect(result[0], TimeRange(
        startTime: TimeOfDay(hour: 0, minute: 0),
        endTime: TimeOfDay(hour: 3, minute: 0),
      ));
    });


  });
}