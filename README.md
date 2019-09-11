# My undergraduate thesis :

# *The Effect of Training Video Number for Each Class in Near Duplicate Video Retrieval Application using t-Distributed Unsupervised Stochastic Multi-View Hashing Method*

## This isn't all program files of my undergraduate thesis

Abstrak — Aplikasi NDVR muncul akibat banyaknya video yang hampir duplikat dari video asli. Video yang hampir duplikat ini
dapat dimanfaatkan dan dikomersialkan tanpa sepengetahuan dari pemilik hak cipta. Pada sistem NDVR terdapat masalah
ketidakseimbangan jumlah video latih untuk setiap kelas. Oleh karena itu perlu dilakukan pengujian sistem terhadap jumlah video
latih untuk setiap kelas yang berbeda untuk melihat pengaruhnya. Pada penelitian ini, perancangan sistem NDVR menggunakan
metode t-USMVH. 

Sistem NDVR ini terbagi menjadi 4 tahapan yaitu ekstraksi keyframe, ekstraksi ciri, pelatihan sistem, dan juga
pencocokan kode hash antarvideo. Pada ekstraksi keyframe proses pemilihan keyframe berdasarkan sampling per detik namun tetap
mempertimbangkan perubahan citra antardetik. Pada ekstraksi ciri didapatkan ciri lokal dan ciri global, yaitu Hue Saturation Value
(HSV) dan Local Directional Pattern (LDP). 

Untuk pelatihan sistem berdasarkan arsitektur backpropagation, dan pencocokan kode
hash antarvideo menggunakan metode Hamming Distance. Pengujian dilakukan terhadap kombinasi variasi ciri, variasi jumlah iterasi,
dan variasi jumlah video latih untuk setiap kelas. Terdapat 2 variasi jumlah video latih untuk setiap kelas yaitu, imbalance query video
dan balance query video. Dari hasil nilai MAP yang didapatkan terlihat bahwa nilai MAP untuk balance query video lebih besar
dibandingkan dengan imbalance query video pada semua variasi iterasi dan semua variasi ciri. Sedangkan untuk sistem balance query
video menghasilkan nilai MAP yang lebih baik jika menggunakan gabungan ekstraksi ciri lokal dan global dibandingkan dengan hanya
satu ekstraksi ciri.

Kata kunci — Keyframe, NDVR, t-USMVH, HSV, LDP, balance query video, imbalance query video, MAP.
