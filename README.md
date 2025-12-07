

# 📦 How to Add This Package to Your Project

Follow these steps to add the Image Picker & Story Viewer package to any iOS project:

### **1️⃣ Open Xcode → File → Add Package Dependency…**

### **2️⃣ Paste this URL:**

```
https://github.com/Excelsior-Technologies-Community/Excelsior-Technologies-Community-IOS_ImagePicker.git
```

### **3️⃣ Select the branch (main / Stages) or latest version**

### **4️⃣ Add the package to your iOS app target**

That's it — Xcode will automatically download and link the package.

---

# 🚀 How to Use in Your Project

Import the module at the top of your Swift file:

```swift
import ImageViewr
```

Then use this example to:

* Select multiple images from the gallery
* Open them in Instagram-style story viewer

Here is the **exact code developers should copy**:

```swift
import SwiftUI
import ImageViewr

struct ContentView: View {

    @State private var showPicker = false
    @State private var showViewer = false
    @State private var images: [UIImage] = []

    var body: some View {
        VStack(spacing: 20) {

            Button("Select Images") {
                showPicker = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)

            if !images.isEmpty {
                Button("Open Story Viewer") {
                    showViewer = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .padding()
        .sheet(isPresented: $showPicker) {
            ImagePicker(images: $images)
        }
        .fullScreenCover(isPresented: $showViewer) {
            StoryViewer(images: images)
        }
    }
}
```

---

# 🎉 Done!
 
