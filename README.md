# Iriset

**Iriset** is a lightweight macOS app that creates complete, platform-specific icon sets for Xcode projects. Drop in a high-resolution image, choose your target platforms, and the app generates all required icon assets — including a `Contents.json` file — and inserts the generated resources into your Xcode project.

---

## Features

- **Drag & Drop Interface**  
  Drop any PNG or JPEG file directly into the app.

- **Multi-Platform Support**  
  Generate icons for:
  - iOS
  - iPadOS
  - macOS
  - watchOS
  - visionOS

- **Xcode Project Integration**  
  Specify the path to your `.xcodeproj`, and the app will locate the existing `AppIcon.appiconset` folder and insert the icons directly into it.

- **Auto-Generated Contents.json**  
  Automatically creates the correct `Contents.json` file for all selected platforms.

---

## How It Works

1. **Drop** a high-resolution image (preferably 1024×1024 or larger) into the app.
2. **Select** one or more target platforms.
3. **Choose** your Xcode project path (`.xcodeproj` file).
4. **Click Generate** – the app resizes the image, names the files appropriately, and updates your `AppIcon.appiconset`.

---

## Folder Detection Logic

When given a `.xcodeproj` file, the app searches for the existing `AppIcon.appiconset` folder in the following locations:

1. `<projectRoot>/Assets.xcassets/AppIcon.appiconset`
2. `<projectRoot>/<projectName>/Assets.xcassets/AppIcon.appiconset`

If neither is found, icon generation will be skipped and an error will be logged.

---

## Input Image Requirements

- **File Type**: PNG or JPEG  
- **Resolution**: At least 1024×1024  
- **Aspect Ratio**: Square  
- **Transparency**: Avoid unless needed  
- **Padding**: None – the image should fill the entire canvas

---

## Screenshot

<img width="1012" alt="Screenshot 2025-03-30 at 11 17 57 PM" src="https://github.com/user-attachments/assets/048307ff-1c86-4437-bbf4-fe2566fd7bed" />

---

## License

Copyright (c) 2025 Zach Bonner

All rights reserved.

This source code is provided for educational purposes **only**. 

## Permissions:
- You may view and read this code to **learn** about the author's development practices and coding style.

## Restrictions:
- You **may not** modify, distribute, sublicense, or use this code in any form, including personal, commercial, or open-source projects.
- You **may not** incorporate any part of this code into another project.
- You **may not** use this code in any compiled, interpreted, or executed format.
- You **may not** claim authorship or derive work from this project.

## Liability:
This code is provided **as-is**, without warranty of any kind. The author is not responsible for any use or misuse of this code.

For inquiries, please contact Zach. 
