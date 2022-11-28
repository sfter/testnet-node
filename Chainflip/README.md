![image](https://user-images.githubusercontent.com/101462877/202866596-c418882c-cd8a-4344-9a67-11e645d9fb37.png)

## Referensi

[Dokumen resmi](https://docs.chainflip.io/perseverance-validator-documentation/)

[Validator auction](https://stake-perseverance.chainflip.io/auctions)

[Server Discord Chainflip](https://discord.gg/MeY637VK)

[Vanity ETH](https://vanity-eth.tk/)

[Goerli faucet](https://goerlifaucet.com)

[Goerli RPC](https://alchemy.com/?r=DY5MDYwOTY0MjY1M)

## Thanks to
> [Jambul merah](https://github.com/jambulmerah) <br>
> [bayy420-999](https://github.com/bayy420-999)

## Persyaratan hardware & software

### Persyaratan hardware

| Komponen | Spesifikasi minimal |
|----------|---------------------|
|CPU|4 Cores|
|RAM|32 GB DDR4 RAM|
|Penyimpanan|1 TB HDD|
|Koneksi|10Mbit/s port|

| Komponen | Spesifikasi rekomendasi |
|----------|---------------------|
|CPU|32 Cores|
|RAM|32 GB DDR4 RAM|
|Penyimpanan|2 x 1 TB NVMe SSD|
|Koneksi|1 Gbit/s port|

### Persyaratan software/OS

| Komponen | Spesifikasi minimal |
|----------|---------------------|
|Sistem Operasi|Ubuntu 16.04|

| Komponen | Spesifikasi rekomendasi |
|----------|---------------------|
|Sistem Operasi|Ubuntu 20.04|

## Persyaratan tambahan

Sebelum melanjutkan ke langkah selanjutnya pastikan anda telah melengkapi persyaratan-persyaratan berikut:
* Dompet ETH
* Goerli RPC
* tFlip Token

### Dompet ETH

Dalam menjalankan testnet node, anda tidak disarankan untuk menggunakan akun ETH ber-asset. Anda disarankan untuk membuat akun ETH baru.

Anda dapat membuat dompet ETH di Metamask atau website lain seperti [Vanity ETH](https://vanity-eth.tk/). Lalu simpan private key dompet baru anda.

Selain itu, pastikan dompet anda memiliki setidaknya 0.1 gETH (goerli ETH). Anda bisa mendapatkannya dengan mengklaim faucet di [disini](https://goerlifaucet.com/)

### Goerli RPC

Anda memerlukan Goerli RPC untuk menjalankan node, Anda bisa membuatnya [disini](https://alchemy.com/?r=44b9e90dc6860958).

* Registrasi di alchemy
* Pilih `CREATE APP`
* Isi Name dan Description
* Di bagian CHAIN ganti CHAIN menjadi GOERLI
* Klik `CREATE APP`
* Setelah itu cari App yang anda buat tadi 
* Pilih `VIEW DETAILS`
* Pilih `VIEW KEY`
* Salin HTTPS dan Websocket

### tFlip Token

tFlip Token dibutuhkan untuk delegasi dan memenangkan slot validator. Jika anda mendapatkan slot validator, maka validator anda akan dimasukan `active list`

Minimal stake untuk mendapatkan slot validator akan berubah setiap saat, anda bisa mengecek minimal stake [disini](https://stake-perseverance.chainflip.io/)

Untuk mendapatkan tFlip Token anda dapat mengikuti langkah-langkah dibawah:

* Pergi ke (https://tflip-dex.thunderhead.world/)
* Hubungkan Metamask Wallet kamu, pastikan gunakan Wallet untuk Node
* Swap gEth kamu menjadi tFlip

## Setup Otomatis

* Unduh script

  ```console
  bash -c "$(curl -sSL https://raw.githubusercontent.com/mggnet/testnet/main/Chainflip/chainflip.sh)"
  ```
  
  Lalu isi informasi yang diperlukan

## Jalankan node

* Jalankan node

  ```console
  sudo systemctl start chainflip-node
  ```

* Cek status node

  ```console
  sudo systemctl status chainflip-node
  ```

* Cek log

  ```console
  tail -f /var/log/chainflip-node.log
  ```

  > Jika log sudah seperti ini `💤 Idle (15 peers), best: #3578 (0xcf9a…d842), finalized #3576 (0x6a0e…03fe), ⬇ 27.0kiB/s ⬆ 25.5kiB/s 
  ✨ Imported #3579 (0xa931…c03e)` anda dapat melanjutkan langkah selanjutnya

* Jalankan chainflip-engine

  ```console
  sudo systemctl start chainflip-engine
  ```

* Cek status chainflip-engine

  ```console
  sudo systemctl status chainflip-engine
  ```

* Mulai ulang chainflip-node & chainflip-engine

  ```console
  sudo systemctl enable chainflip-node
  sudo systemctl enable chainflip-engine
  ```

* Cek log chainflip-engine

  ```console
  tail -f /var/log/chainflip-engine.log
  ```

## Stake

Sebelum melanjutkan ke langkah berikutnya, pastikan anda telah memiliki tFlip Token

Ikuti langkah-langkah berikut untuk staking tFlip Token:

* Pergi ke [Perseverance Staking App](https://stake-perseverance.chainflip.io/)
* Pilih `My nodes`
* Pilih `+ Add node` 
* Pilih `Register new node`
* Masukan `Public key (SS58)` dan jumlah tFlip Token yang ingin di-stake, lalu pencet `Stake`
* Konfirmasi transaksi di Metamask

Setelah itu mulai ulang chainflip-engine

```console
sudo systemctl restart chainflip-engine
```

> Jika anda membuka website `Perseverance Staking App` menggunakan hp, pastikan anda menggunakan Desktop mode untuk melihat menu `My nodes`
> Jika anda mengikuti tutorial ini dari awal, anda dapat mencari `Public key (SS58)` di file `sign_key.txt`


## Daftarkan Validator key

Sebelum mendaftarkan Validator key, pastikan node anda telah tersinkronisasi penuh, lalu jalankan perintah dibawah:

```console
sudo chainflip-cli \
      --config-path /etc/chainflip/config/Default.toml \
      register-account-role Validator
```

> Setelah menjalankan perintah diatas, tunggu sampe validator key anda terdaftar. Proses ini dapat memakan waktu beberapa saat

Setelah itu aktifkan validator agar bisa mengikuti auction selanjutnya, jalankan perintah berikut:

```console
sudo chainflip-cli \
    --config-path /etc/chainflip/config/Default.toml \
    activate
```

Terakhir putar validator key anda dengan menggunakan perintah berikut:

```console
sudo chainflip-cli \
    --config-path /etc/chainflip/config/Default.toml rotate
```

(OPSIONAL) anda dapat mengkostumisasi nama validator anda menggunakan perintah berikut:

```console
sudo chainflip-cli \
    --config-path /etc/chainflip/config/Default.toml \
    vanity-name <NAMA_BARU_VALIDATOR_ANDA>
```

## Menghentikan validator

Jika anda ingin berhenti menjadi validator, anda bisa menggunakan perintah berikut:

```console
sudo chainflip-cli \
    --config-path /etc/chainflip/config/Default.toml \
    retire
```

> Setelah menjalankan perintah diatas, anda akan berhenti mengikuti validator auction

Lalu tarik tFlip Token anda

```console
sudo chainflip-cli \
    --config-path /etc/chainflip/config/Default.toml \
    claim <JUMLAH_TFLIP_TOKEN_YANG_INGIN_DITARIK> <ADDRESS_ETH_UNTUK_MENERIMA_TOKEN>
```

> Jangan lupa untuk memasukan jumlah tFlip Token yang ingin ditarik dan mengganti address ETH

## Perintah berguna

### Menjalankan service

* Menjalankan service chainflip-node

  ```console
  sudo systemctl start chainflip-node
  ```

* Menjalankan service chainflip-engine

  ```console
  sudo systemctl start chainflip-engine
  ```

### Memulai ulang service

* Memulai ulang service chainflip-node

  ```console
  sudo systemctl restart chainflip-node
  ```

* Memulai ulang service chainflip-engine

  ```console
  sudo systemctl restart chainflip-engine
  ```

### Menghentikan service

* Menghentikan service chainflip-node

  ```console
  sudo systemctl stop chainflip-node
  ```

* Menghentikan service chainflip-engine

  ```console
  sudo systemctl stop chainflip-engine
  ```

### Cek log

* Cek log chainflip-node

  ```console
  tail -f /var/log/chainflip-node.log
  ```

* Cek log chainflip-engine

  ```console
  tail -f /var/log/chainflip-engine.log
  ```
