# ``LCLabel``

LCLabel is a TextKit 2 based UIView that mimics a the behaviour of UILabel & UITextView


## Overview

### How to use:

Using LCLabel is as simple as using a UILabel

```swift
let text = NSMutableAttributedString(
  string: "welcome to this new adventure!!!",
  attributes: [:])
let range = (text.string as NSString).range(of: "welcome")
text.addAttribute(
  .lclabelLink, // Note we use type `lclabelLink`
  value: URL(string: "tel://909001")!,
  range: range)
let label = LCLabel(
  frame: CGRect(
    origin: .zero, 
    size: .init(
      width: 300, 
      height: 30)))
label.isUserInteractionEnabled = true
label.delegate = self
label.attributedText = text
view.addSubview(label)
```

![](testTextCenterAlignment.1.png)

or incase AutoLayout is being used

```swift
let label = LCLabel(frame: .zero)
label.isUserInteractionEnabled = true
label.delegate = self
label.attributedText = text
view.addSubview(label)
label.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
  label.topAnchor.constraint(equalTo: view.topAnchor),
  label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
  label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  label.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
```

![](testInstagramLabelMimic.1.png)

#### Notes:

While building it with TextKit was interesting, the following nits where found:

- Setting the styles for links are usually broken. There are two solutions for this:
  1- Use type `.lclabelLink` instead of `.link` when creating your NSAttributedString

  2- Setting `linkStyleValidation` to be `.ensure` which will force the NSTextStorage to either replace all the instances of `.link` with `.lclabelLink` or takes values of `linkAttributes` and sets them to the Storage.

- `linkAttributes` would only be set if `.ensure` was set.

### Performance

#### Memory

Using UILabel as a baseline, we were able to achieve a similar performance to UILabel.

A simple text in a LCLabel would use around `96 Kib` in memory compared to UILabel.
![](shorttext.png)

A single line text in a LCLabel would use around `384 Kib` in memory compared to UILabel.
![](oneline-text-long.png)

A single line with Emojis text in a LCLabel would use around `1.12 MiB` in memory compared to the `1.23 MiB` UILabel.
![](longtext-emoji.png)

#### Scrolling

Using UILabel as a baseline, we were able to achieve a similar performance to UILabel, 
when scrolling and that was measured in the `UI Full Tests`. 
The benchmark was based on the amount of hitches detected on an iPhone XS, 
where both labels had zero hitches when scrolling a list around 5 times each time we ran the test.
