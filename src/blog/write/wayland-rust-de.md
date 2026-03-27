---
title: "Membuat Wayland Desktop Environment dengan Rust dan GTK4"
date: 2026-04-12
description: "Catatan perjalanan saya membangun DE kustom menggunakan ekosistem Rust, GTK-rs, dan libadwaita."
slug: wayland-rust-de
---

Eksplorasi membangun _Desktop Environment_ (DE) sendiri yang berjalan di atas protokol Wayland adalah tantangan yang sangat menarik.

Saya sangat menyukai antarmuka aplikasi bawaan GNOME, tetapi untuk lingkungan desktopnya, saya menginginkan sesuatu yang diracik khusus untuk alur kerja saya sendiri. Menggunakan **Rust** dipadukan dengan **GTK-rs** dan `libadwaita` memberikan kombinasi performa, keamanan memori, dan tampilan antarmuka yang modern.

### Kenapa Rust?

Keamanan memori (_memory safety_) bawaan Rust sangat krusial ketika berhadapan dengan komponen tingkat rendah seperti _compositor_ Wayland. Kita bisa menghindari banyak _bug_ yang sering muncul di bahasa C/C++.

Berikut adalah contoh inisialisasi aplikasi GTK4 sederhana di Rust:

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

Pada tulisan berikutnya, saya akan membahas bagaimana menghubungkan _window_ ini dengan protokol Wayland!
