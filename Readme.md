# Final Project PSD PA21 - Traffic Light Controler

### Background

Sistem pengontrol lampu lalu lintas memiliki peran penting dalam mengatur arus kendaraan dan pejalan kaki di persimpangan jalan, terutama di persimpangan empat arah yang padat. Tanpa pengontrol yang efisien, penumpukan jumlah kendaraan dapat terjadi sehingga menyebabkan kemacetan yang mengarah pada peningkatan waktu perjalanan, konsumsi bahan bakar yang lebih tinggi, bahkan kecelakaan. Pengontrol lampu lalu lintas yang baik harus mampu mengoptimalkan pergerakan kendaraan, memberikan waktu yang cukup bagi pejalan kaki untuk menyeberang, dan mengatur arus lalu lintas untuk kasus-kasus khusus. Sistem digital menawarkan solusi yang efisien dibandingkan pengontrol berbasis analog. Proyek Traffic Light Controller Design mensimulasikan perancangan pengontrol arus lalu lintas dengan meningkatkan efisiensi lalu lintas perempatan dengan menerapkan prinsip-prinsip perancangan sistem digital untuk menciptakan lampu lalu lintas yang lebih efisien. Sistem yang kami rancang menggunakan finite state machine (FSM) untuk mengatur sinyal lampu lalu lintas, memastikan kelancaran arus lalu lintas, dan mengutamakan keselamatan baik bagi kendaraan maupun pejalan kaki.

### Komponen Sistem dan Penjelasan Implementasi Modul

1. Finite State Machine (FSM)

   Fungsi: Mengatur transisi antar state lampu lalu lintas (Red, Yellow, Green, Pedestrian) sesuai dengan urutan dan kondisi yang telah ditentukan.

   Implementasi: Digunakan untuk mendefinisikan status pengontrol lampu lalu lintas dalam empat state: IDLE_STATE, RED_STATE, YELLOW_STATE, GREEN_STATE, dan PEDESTRIAN_STATE. Setiap state berfungsi untuk mengontrol kapan lampu lalu lintas harus merah, kuning, atau hijau, serta kapan lampu penyeberangan pejalan kaki diaktifkan.

   Cara Kerja: Transisi antar state terjadi berdasarkan input seperti tombol pedestrian yang ditekan dan durasi lampu hijau yang berakhir. Dalam mode aktif, sistem berjalan melalui siklus state berdasarkan urutan: RED → YELLOW → GREEN → RED, dengan perubahan tergantung pada kondisi input, yaitu toggle, clock, reset, atau button pedestrian.

2. Timer

   Fungsi: Mengontrol durasi lampu hijau pedestrian berdasarkan input waktu (Timer) yang diterima.

   Implementasi: Timer berupa input 8-bit yang digunakan untuk menetapkan waktu berapa lama lampu hijau pejalan kaki akan menyala. Timer ini digunakan dalam state PEDESTRIAN_STATE untuk menentukan durasi di mana lampu hijau untuk pejalan kaki aktif.

   Cara Kerja: Ketika tombol pedestrian ditekan dan memasuki state PEDESTRIAN_STATE, sistem mengambil nilai dari input Timer dan menggunakan nilai tersebut untuk menetapkan durasi lampu hijau pejalan kaki. Setelah timer mencapai 0, sistem akan kembali ke state RED_STATE.

3. Kontrol Lampu Lalu Lintas Utama dan Belok Kiri

   Fungsi: Mengatur lampu lalu lintas utama (Red, Yellow, Green) dan lampu belok kiri untuk setiap arah (utara, timur, selatan, barat).

   Implementasi: Pengontrol mengatur lampu utama untuk setiap arah sesuai dengan state yang sedang berlaku. Lampu belok kiri disinkronkan dengan lampu hijau utama untuk arah yang bersangkutan. Lampu utama dan belok kiri akan memasuki RED State ketika terdapat input pedestrian dan timer.

### Testing

#### Synthesize

![picture 0](https://i.imgur.com/GkJ7qTw.png)

#### Waveform

![picture 1](https://i.imgur.com/paEJYrQ.png)
