# BookShelf UI Design System & Implementation Guide

> **Purpose:** This file is the single source of truth for the visual design of the BookShelf Flutter app.
>
> AI/Codex must follow this document consistently when creating or modifying UI.
>
> The final product should feel like a real, polished mobile application designed by a product team — **not a generic AI-generated Flutter demo**.

---

# 1. Core Design Direction

## 1.1 Product personality

BookShelf is a personal reading library app.

The visual language should feel:

- Calm
- Intelligent
- Warm
- Organized
- Modern
- Premium but simple
- Friendly without looking childish
- Suitable for university students and adult readers

The app should **not** feel:

- Overly colorful
- Cartoonish
- Like a Material UI demo
- Like an AI-generated landing page
- Overloaded with gradients
- Full of random icons
- Too rounded everywhere
- Visually noisy
- Corporate / enterprise-heavy

---

# 2. Global Design Rules

## 2.1 Mobile-first

The application is designed for a typical Android phone.

Target width:

```text
360px – 430px
```

Primary reference width:

```text
390px
```

All screens must:

- Fit without horizontal scrolling
- Avoid clipped text
- Avoid buttons extending outside the viewport
- Use vertical scrolling when needed
- Respect safe areas
- Keep controls reachable with one hand where reasonable

---

## 2.2 Consistency

Always reuse the same:

- Button styles
- Input styles
- Card styles
- Radius
- Shadows
- Spacing
- Typography
- Icon sizes
- Section headings
- Empty states
- Feedback messages

Do not invent new visual styles screen by screen.

---

# 3. Color System

Use a restrained palette.

## 3.1 Primary palette

```dart
primary900 = Color(0xFF1F3A35);
primary800 = Color(0xFF294A43);
primary700 = Color(0xFF365D54);
primary600 = Color(0xFF447268);
primary500 = Color(0xFF557F75);
primary100 = Color(0xFFE6EFEC);
primary050 = Color(0xFFF3F7F6);
```

Primary meaning:

- Deep green = books, calm, focus, maturity
- Use for primary CTA, active state, important icons

---

## 3.2 Accent

```dart
accent500 = Color(0xFFC98952);
accent100 = Color(0xFFF7EBDD);
```

Use sparingly for:

- Favorite stars
- Small decorative details
- Highlight chips
- Warm visual balance

Do **not** use accent as the main button color.

---

## 3.3 Neutral palette

```dart
neutral950 = Color(0xFF171A19);
neutral900 = Color(0xFF202423);
neutral800 = Color(0xFF363B39);
neutral700 = Color(0xFF505653);
neutral600 = Color(0xFF6D736F);
neutral500 = Color(0xFF8A908C);
neutral400 = Color(0xFFA7ACA9);
neutral300 = Color(0xFFC6CAC7);
neutral200 = Color(0xFFDEE1DF);
neutral100 = Color(0xFFECEFED);
neutral050 = Color(0xFFF7F8F7);
white = Color(0xFFFFFFFF);
```

---

## 3.4 Semantic colors

### Success

```dart
success700 = Color(0xFF2F6B4F);
success100 = Color(0xFFE4F2EA);
```

### Error

```dart
error700 = Color(0xFFB23A3A);
error100 = Color(0xFFFBE7E7);
```

### Warning

```dart
warning700 = Color(0xFF9A6817);
warning100 = Color(0xFFFFF1D4);
```

### Info

```dart
info700 = Color(0xFF35698F);
info100 = Color(0xFFE5F0F8);
```

---

# 4. Background System

## 4.1 Main screen background

Default:

```dart
Color(0xFFF7F8F7)
```

Avoid pure white as the entire screen background unless on a dialog or card.

Why:

- Slight warm-neutral background feels more premium
- Cards become easier to distinguish
- Reduces harsh visual contrast

---

## 4.2 Surface background

Cards, forms, dialogs:

```dart
Color(0xFFFFFFFF)
```

---

## 4.3 Hero / top-section background

For Home screen only, use:

```dart
Color(0xFFF0F5F3)
```

Optional subtle gradient:

```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFF3F7F6),
    Color(0xFFE8F0ED),
  ],
)
```

Do not use strong gradients elsewhere.

---

# 5. Typography

Use:

```text
Inter
```

If Inter is unavailable:

```text
Roboto
```

Do not mix fonts.

---

## 5.1 Type scale

### Display

```text
Size: 32
Weight: 700
Height: 1.15
Letter spacing: -0.5
```

Used only for:

- Home hero title "BookShelf"

---

### H1

```text
Size: 26
Weight: 700
Height: 1.2
```

Used for main screen titles.

---

### H2

```text
Size: 21
Weight: 700
Height: 1.25
```

Used for major content sections.

---

### H3

```text
Size: 18
Weight: 600
Height: 1.3
```

Used for card titles and subsections.

---

### Body Large

```text
Size: 16
Weight: 400
Height: 1.5
```

---

### Body

```text
Size: 14
Weight: 400
Height: 1.5
```

---

### Body Medium

```text
Size: 14
Weight: 500
Height: 1.45
```

---

### Caption

```text
Size: 12
Weight: 400
Height: 1.4
```

---

### Button

```text
Size: 15
Weight: 600
Height: 1.2
```

---

## 5.2 Text color hierarchy

Primary text:

```dart
neutral950
```

Secondary text:

```dart
neutral600
```

Muted/helper:

```dart
neutral500
```

Disabled:

```dart
neutral400
```

Error:

```dart
error700
```

Link / interactive text:

```dart
primary700
```

---

# 6. Spacing System

Use an 4px base grid.

Allowed spacing:

```text
4
8
12
16
20
24
32
40
48
64
```

Do not use random values like:

```text
13
17
19
23
```

unless needed for exact alignment.

---

## 6.1 Screen padding

Default horizontal padding:

```text
20px
```

Compact horizontal padding:

```text
16px
```

Use 20 whenever possible.

---

## 6.2 Section spacing

Between major sections:

```text
24px – 32px
```

Between title and description:

```text
8px
```

Between label and input:

```text
8px
```

Between form fields:

```text
16px
```

Between list cards:

```text
12px
```

---

# 7. Radius System

```text
Small: 8
Medium: 12
Large: 16
XL: 20
Pill: 999
```

Recommended:

- Input: 12
- Button: 12
- Card: 16
- Dialog: 20
- Filter chip: 999

Do not round every element to 24+.

---

# 8. Shadow System

Avoid heavy shadows.

## Card shadow

```dart
BoxShadow(
  color: Color(0x12000000),
  blurRadius: 16,
  offset: Offset(0, 4),
)
```

Use only on:

- Primary cards
- Dialogs
- Floating surfaces

Simple list items may use border instead of shadow.

---

# 9. Border System

Default border:

```dart
Color(0xFFDEE1DF)
```

Width:

```text
1px
```

Focused input border:

```dart
primary600
```

Error border:

```dart
error700
```

---

# 10. Iconography

Use Material Icons or Material Symbols consistently.

Recommended style:

```text
Outlined
```

Default sizes:

```text
16 — metadata
18 — compact control
20 — standard control
22 — app bar
24 — prominent action
```

Avoid decorative icons with no purpose.

Never mix:

- filled random icon pack
- emojis
- outlined icons

inside the same interface.

---

# 11. Buttons

## 11.1 Primary button

Use for:

- Login
- Register
- Add Book
- Save

Style:

```text
Height: 48
Radius: 12
Background: primary800
Text: white
Text size: 15
Weight: 600
Horizontal padding: 20
```

State behavior:

### Normal

```text
primary800
```

### Pressed

```text
primary900
```

### Disabled

```text
background: neutral200
text: neutral500
```

Icon optional.

Do not use gradients.

---

## 11.2 Secondary button

Use for:

- Cancel
- Clear
- Secondary actions

Style:

```text
Height: 44–48
Radius: 12
Background: white
Border: neutral300
Text: neutral800
```

---

## 11.3 Text button

Use for:

- Login from Home
- Register from Home
- Edit
- Minor actions

Style:

```text
Transparent
Text: primary700
Weight: 600
```

No underline unless it is an actual inline link.

---

## 11.4 Destructive button

Use only for Delete.

```text
Background: error700
Text: white
```

Delete should never look identical to a normal primary CTA.

---

## 11.5 Button width

Main form buttons:

```text
width: double.infinity
```

Dialog buttons:

```text
fit content
```

App bar buttons:

```text
fit content
```

---

# 12. Inputs

All text inputs must use the same visual system.

## 12.1 Input container

```text
Height: 52px minimum
Radius: 12
Fill: white
Border: neutral300
Horizontal padding: 14
```

---

## 12.2 Label

Display above input.

```text
Font: 14
Weight: 600
Color: neutral800
Bottom spacing: 8
```

Example:

```text
Email
[ input field ]
```

Do not use floating labels.

---

## 12.3 Placeholder

```text
Color: neutral500
Weight: 400
```

Example:

```text
Enter your email
```

---

## 12.4 Error state

Border:

```text
error700
```

Error text:

```text
Size: 12
Color: error700
Top spacing: 6
```

Validation text must appear directly below the corresponding field.

---

## 12.5 Password

Use:

```text
obscureText: true
```

Add visibility toggle icon at right.

Icon:

```text
visibility_outlined / visibility_off_outlined
```

---

## 12.6 Textarea

Notes field:

```text
Minimum 4 lines
Maximum 6 lines
Vertical padding: 14
```

Do not make Notes a single-line input.

---

# 13. Dropdowns

Genre and Status dropdowns use the same shell as inputs.

```text
Height: 52
Radius: 12
Background: white
Border: neutral300
```

Chevron:

```text
keyboard_arrow_down_rounded
```

Default values must remain exactly:

```text
Choose genre
Choose status
```

Do not replace these exact texts.

---

# 14. Switch

Favorites-only switch:

Use native Flutter Switch styled with:

```text
Active track: primary500
Active thumb: white
Inactive track: neutral300
```

Label left, switch right.

Example:

```text
Favorites only                    [switch]
```

---

# 15. Cards

## 15.1 Standard content card

```text
Background: white
Radius: 16
Padding: 16
Border: neutral200
```

Optional subtle shadow.

---

## 15.2 Feature card — Home

Layout:

```text
Icon
Title
Description
```

Use:

```text
Icon container: 40x40
Icon background: primary100
Icon color: primary700
```

Card should have:

```text
Radius: 16
Padding: 16
```

No giant illustrations.

---

# 16. Book List Card

Each book row should feel compact but rich.

Recommended layout:

```text
┌───────────────────────────────────────┐
│ Book Title                       ☆    │
│ Author Name                           │
│                                       │
│ [Fiction]   [Reading]                 │
│                                View ›  │
└───────────────────────────────────────┘
```

## Styling

Title:

```text
Size: 16
Weight: 600
Color: neutral950
Max lines: 2
```

Author:

```text
Size: 13
Color: neutral600
```

Favorite star:

```text
Inactive: star_border_rounded
Active: star_rounded
Active color: accent500
Size: 24
```

View control:

```text
Text: "View"
Icon: chevron_right
Color: primary700
```

Whole card can also be tappable.

---

# 17. Chips

## Genre chip

```text
Background: neutral100
Text: neutral700
```

## Status chip

### To Read

```text
Background: info100
Text: info700
```

### Reading

```text
Background: warning100
Text: warning700
```

### Finished

```text
Background: success100
Text: success700
```

Chip style:

```text
Height: 28
Horizontal padding: 10
Radius: pill
Text size: 12
Weight: 600
```

---

# 18. App Bar / Header

## Logged-out screens

Simple header.

```text
Height: 64
Background: transparent or screen background
```

Left:

```text
BookShelf
```

Right:

```text
Login
Register
```

Because mobile width is limited, use compact text buttons.

---

## Logged-in List screen

Layout:

```text
BookShelf
user@email.com
Logout
```

Suggested UI:

```text
Top row:
BookShelf                         Logout

Below:
Signed in as user@email.com
```

The email should not compete visually with the title.

---

# 19. Snackbar / Feedback Messages

Use snackbar for success.

Success examples:

```text
Registration successful
Book added
```

Style:

```text
Background: neutral900
Text: white
Radius: 12
Margin: 16
Floating behavior
```

Success icon optional:

```text
check_circle_outline
```

Do not show huge success banners.

Firebase/form failures should appear inside the form below the submit button when required.

---

# 20. Dialogs

## Delete confirmation

Title:

```text
Delete book?
```

Body:

```text
This action cannot be undone.
```

Actions:

```text
Cancel
Delete
```

Dialog styling:

```text
Radius: 20
Padding: 24
Background: white
```

Cancel:

```text
secondary/text button
```

Delete:

```text
destructive button
```

Do not use alert icons larger than 40.

---

# 21. Empty State

Required exact text:

```text
No books found
```

Design:

```text
Centered
Top spacing: 48
```

Icon:

```text
menu_book_outlined
```

Icon styling:

```text
Size: 48
Color: neutral400
```

Title:

```text
No books found
Size: 17
Weight: 600
```

Optional supporting text:

```text
Try adjusting your filters or add a new book.
```

Only the required text must remain exact.

---

# 22. Loading State

Use a clean centered indicator.

Preferred:

```text
CircularProgressIndicator
Stroke width: 2.5
Color: primary700
```

Do not show protected screen content before auth state has resolved.

---

# 23. Error State

Use inline error container.

```text
Background: error100
Radius: 12
Padding: 12
```

Icon:

```text
error_outline
```

Text:

```text
error700
```

Avoid full-screen red UI unless the entire page truly failed.

---

# 24. Home Screen

## 24.1 Layout

Recommended structure:

```text
SafeArea
  Header
  Hero
  Feature section
  Bottom CTA
```

---

## 24.2 Header

Left:

```text
BookShelf
```

Right:

```text
Login   Register
```

---

## 24.3 Hero

Background:

```text
primary050 / subtle green gradient
```

Spacing:

```text
Horizontal: 20
Vertical: 32
```

Content:

```text
Small eyebrow optional:
YOUR PERSONAL LIBRARY

Main:
BookShelf

Description:
A short description explaining personal book tracking.

Primary CTA:
Register

Secondary CTA:
Login
```

Important:

The visible title `BookShelf` must remain exactly written.

---

## 24.4 Feature cards

At least three.

Suggested feature titles:

```text
Track your books
Sort by status
Rate your favorites
```

Use vertical stacked cards on mobile.

Do not create a 3-column layout on phone.

---

# 25. Login Screen

Recommended structure:

```text
Back
Title: Welcome back
Description
Email
Password
Firebase error area
Login button
Register navigation
```

The actual app requirement still uses the exact screen functionality and field error strings.

UI styling:

- Form centered vertically but scrollable
- Max content width = screen width
- White card optional
- Avoid overly large auth illustrations

---

# 26. Register Screen

Recommended structure:

```text
Back
Title: Create your account
Description
Email
Password
Confirm password
Firebase error area
Register button
Login navigation
```

Keep password fields identical in styling.

---

# 27. List Screen

This is the main product screen.

Recommended order:

```text
Header
Page title
Add Book collapsible/section
Filters
Summary
Book list
```

---

# 28. Add Book Form

Use a dedicated white card.

Section title:

```text
Add a book
```

Fields order:

```text
Title
Author
Genre
Status
Rating
Notes
```

Layout:

- One column only
- Genre and Status may be side by side only on large screens
- On normal phones keep them stacked for safety

Submit button:

```text
Add Book
```

Success appears as snackbar.

---

# 29. Filter Section

Use one contained card.

Order:

```text
Search
Genre
Status
Favorites only
Clear
```

Search field:

```text
Leading icon: search
Placeholder: Search by title or author
```

Clear:

```text
Secondary / text action
```

Do not make Clear visually dominant.

---

# 30. Summary Section

Use one simple card.

Example:

```text
Summary

Books: 5
Favorites: 2

Reading        3
To Read        1
Finished       1
```

Design:

- Avoid charts
- Avoid pie graphs
- Avoid progress bars
- Keep the summary textual and easy to verify

Status rows:

```text
status chip or label on left
count on right
```

---

# 31. Detail Screen — View Mode

Recommended structure:

```text
App bar
Book title
Author

Metadata card
Genre
Status
Rating
Favorite

Notes card

Edit button
Delete button
```

Title can wrap up to 2–3 lines.

Metadata rows:

```text
Label on left
Value on right
```

Example:

```text
Genre                 Fiction
Status                Reading
Rating                4 / 5
```

Favorite toggle may be star button.

---

# 32. Detail Screen — Edit Mode

Replace values with form controls.

Keep same field order as Add Book.

Bottom action area:

```text
Cancel     Save
```

Save = primary.

Cancel = secondary.

Keep actions visible near the bottom but do not force a sticky footer if it covers the keyboard.

---

# 33. Favorite Interaction

Use star icon only.

Inactive:

```text
star_border_rounded
neutral500
```

Active:

```text
star_rounded
accent500
```

Animation:

```text
150–200ms scale/fade
```

Do not use heart icon.

---

# 34. Interaction Motion

Animations should be subtle.

Allowed:

```text
150ms – 250ms
```

Examples:

- Favorite toggle
- Filter result fade
- Expand/collapse Add Book form
- Snackbar appearance

Avoid:

- Large bouncing animations
- Rotating cards
- Page transitions longer than 300ms

---

# 35. Navigation

Use standard Flutter navigation.

Transition:

```text
Material page transition
```

Avoid custom dramatic transitions.

Back behavior must remain correct.

The List screen must not return to Login/Register after successful authentication.

---

# 36. Responsive Rules

## Width < 370px

- Horizontal padding can reduce to 16
- Buttons remain full width
- Filters stacked
- Avoid side-by-side controls

## Width >= 400px

- Keep main padding 20–24
- Forms still mostly vertical
- Do not suddenly switch to tablet layout

---

# 37. Accessibility

Minimum touch target:

```text
44x44
```

Minimum body text:

```text
14px
```

Avoid low contrast.

Important icons should have semantic labels.

Do not rely on color alone to communicate status.

---

# 38. Exact Text Preservation

Do not modify required texts from the exam.

Examples that must remain exact where required:

```text
BookShelf
Login
Register
Logout
Registration successful
Choose genre
Choose status
Fiction
Non-Fiction
Academic
Other
To Read
Reading
Finished
Book added
No books found
Books: N
Favorites: N
Cancel
Delete
Save
Edit
```

Validation messages must also remain exactly as defined in the exam specification.

Visual styling may change.

Text wording may not.

---

# 39. AI/Codex Implementation Rules

When AI modifies UI:

1. Read this file first.
2. Reuse existing shared widgets before creating new ones.
3. Never create a one-off button style.
4. Never hardcode random colors inside screens.
5. Never use arbitrary font sizes.
6. Never add gradients unless specified here.
7. Never use excessive shadows.
8. Never use emojis as UI icons.
9. Never change required visible texts.
10. Do not redesign unrelated screens while fixing one screen.
11. Maintain functional behavior.
12. Use responsive layout.
13. Keep code clean and reusable.
14. UI must look production-ready before adding decorative elements.

---

# 40. Recommended Shared Widgets

Create reusable components:

```text
AppPrimaryButton
AppSecondaryButton
AppTextButton
AppTextField
AppPasswordField
AppDropdown
AppCard
BookCard
StatusChip
GenreChip
SectionHeader
AppSnackbar
EmptyState
LoadingState
ErrorState
ConfirmDeleteDialog
```

---

# 41. Recommended Theme Structure

Suggested folder:

```text
lib/
  app/
    theme/
      app_colors.dart
      app_spacing.dart
      app_radius.dart
      app_typography.dart
      app_theme.dart
```

---

# 42. Example Theme Constants

## app_spacing.dart

```dart
class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 40;
}
```

---

## app_radius.dart

```dart
class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 999;
}
```

---

# 43. Do / Don't

## DO

- Use spacious layouts
- Use strong typography hierarchy
- Keep forms clean
- Use subtle borders
- Use a restrained palette
- Use meaningful icons
- Keep list cards compact
- Use visual consistency
- Design for real phone screens
- Prioritize usability over decoration

## DON'T

- Add giant gradients
- Use glassmorphism
- Add neon colors
- Put everything inside cards
- Use 5+ colors in one screen
- Add fake analytics
- Add excessive illustrations
- Use emoji icons
- Make every button pill-shaped
- Use random shadows
- Add text not needed for the task
- Make UI look like a Dribbble concept instead of a real app

---

# 44. Final Visual Quality Checklist

Before considering a screen complete, check:

- [ ] Is spacing consistent?
- [ ] Are colors from the design system?
- [ ] Are text sizes consistent?
- [ ] Is the primary action obvious?
- [ ] Is there only one dominant CTA?
- [ ] Are touch targets at least 44px?
- [ ] Does it work on ~360px width?
- [ ] Is anything clipped?
- [ ] Is the page scrollable when keyboard appears?
- [ ] Does validation sit below the correct field?
- [ ] Are error states visually consistent?
- [ ] Are book cards readable at a glance?
- [ ] Are filters easy to understand?
- [ ] Does the screen feel calm instead of crowded?
- [ ] Does it look like a real product, not an AI template?
- [ ] Are all required exam texts preserved exactly?

---

# 45. Design Principle Summary

If unsure how to style something, follow this rule:

> **Use the simplest polished solution.**

BookShelf should feel like:

```text
A calm personal reading companion
+
A professional modern Flutter app
+
A clean product suitable for an app store
```

It should never feel like:

```text
A school prototype
A default Flutter demo
A random AI-generated interface
A flashy concept design
```
