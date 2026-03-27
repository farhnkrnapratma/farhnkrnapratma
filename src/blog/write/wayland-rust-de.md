---
title: "Building a Wayland Desktop Environment with Rust and GTK4"
date: 2026-04-12
description: "Notes on my journey building a custom DE using the Rust, GTK-rs, and libadwaita ecosystem."
slug: wayland-rust-de
---

Exploring the creation of a custom _Desktop Environment_ (DE) running on the Wayland protocol is a very exciting challenge.

I really love the interface of GNOME's default applications, but for the desktop environment itself, I want something tailored specifically to my own workflow. Using **Rust** combined with **GTK-rs** and `libadwaita` provides a combination of performance, memory safety, and a modern interface look.

### Why Rust?

Rust's built-in _memory safety_ is crucial when dealing with low-level components like a Wayland _compositor_. We can avoid many of the _bugs_ that frequently occur in C/C++.

Here is an example of a simple GTK4 application initialization in Rust:

```rust
use gtk::prelude::*;
use gtk::{Application, ApplicationWindow};

fn main() {
    let app = Application::builder()
        .application_id("id.my.fkp.wayland_de")
        .build();

    app.connect_activate(|app| {
        let window = ApplicationWindow::builder()
            .application(app)
            .title("My Custom DE")
            .default_width(800)
            .default_height(600)
            .build();
        window.present();
    });

    app.run();
}
```
