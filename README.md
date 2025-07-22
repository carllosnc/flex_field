# Flex Field

A Flutter package that transforms TextFormField widgets into flexible, dialog-based input fields with customizable display states.

## Features

- Transform any TextFormField into a tappable widget
- Custom display for empty and filled states
- Built-in validation support
- Dialog-based editing interface
- Customizable button text and styling

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flex_field:
    git:
      url: https://github.com/carllosnc/flex_field.git
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:flex_field/flex_field.dart';
```

### Basic Example

```dart
TextFormField(
  controller: nameController,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return "Please enter your name";
    }
    return null;
  },
  decoration: const InputDecoration(
    hintText: 'Ex: John Doe',
    suffixIcon: Icon(Icons.person),
  ),
).flex(
  name: "Name",
  context: context,
  label: () => Text("Enter your name"),
  filled: (value) => Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      value,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
```

## API Reference

### flex() Extension Method

The `flex()` method is an extension on `TextFormField` that transforms it into a flexible input widget.

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `context` | `BuildContext` | ✅ | The build context |
| `label` | `Label` | ✅ | Widget function displayed when field is empty |
| `filled` | `Filled` | ✅ | Widget function displayed when field has value |
| `name` | `String` | ✅ | Title shown in the dialog |
| `resetText` | `String` | ❌ | Text for reset button (default: "Reset") |
| `okText` | `String` | ❌ | Text for OK button (default: "OK") |

#### Type Definitions

```dart
typedef Label = Widget Function();
typedef Filled = Widget Function(String value);
```

## How It Works

1. **Empty State**: When the TextFormField is empty, it displays the widget returned by the `label` function
2. **Filled State**: When the TextFormField has a value, it displays the widget returned by the `filled` function with the current value
3. **Editing**: Tapping the widget opens a dialog containing the original TextFormField for editing
4. **Validation**: The dialog respects the TextFormField's validator and shows error messages
5. **Actions**: Users can reset the field or confirm changes using the dialog buttons

## Customization Examples

### Custom Styling

```dart
TextFormField(
  controller: controller,
  validator: (value) => value?.isEmpty ?? true ? "Required" : null,
).flex(
  name: "Custom Field",
  context: context,
  resetText: "Clear",
  okText: "Save",
  label: () => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.add, color: Colors.grey),
        SizedBox(width: 8),
        Text("Tap to add value", style: TextStyle(color: Colors.grey)),
      ],
    ),
  ),
  filled: (value) => Chip(
    label: Text(value),
    deleteIcon: Icon(Icons.edit),
    onDeleted: () {}, // This won't work, just for visual
  ),
)
```

### Multiple Fields

```dart
Column(
  children: [
    // Name field
    TextFormField(
      controller: nameController,
      validator: (value) => value?.isEmpty ?? true ? "Name required" : null,
    ).flex(
      name: "Full Name",
      context: context,
      label: () => Text("Enter your name"),
      filled: (value) => Text("Name: $value", style: TextStyle(fontWeight: FontWeight.bold)),
    ),

    SizedBox(height: 16),

    // Email field
    TextFormField(
      controller: emailController,
      validator: (value) {
        if (value?.isEmpty ?? true) return "Email required";
        if (!value!.contains('@')) return "Invalid email";
        return null;
      },
    ).flex(
      name: "Email Address",
      context: context,
      label: () => Text("Enter your email"),
      filled: (value) => Text("Email: $value", style: TextStyle(color: Colors.blue)),
    ),
  ],
)
```

## Requirements

- Flutter SDK: >=1.17.0
- Dart SDK: ^3.8.1

## License

This project is licensed under the MIT License.

---

Carlos Costa @ 2025