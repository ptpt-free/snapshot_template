// snapshotからPersistent Diskを作成する
resource "google_compute_disk" "terraform_disk" {
  name     = "terraform-disk"
  type     = "pd-ssd"
  zone     = "${var.region_zone}"
  snapshot = 【Snapshot-name】
  size     = 10
}

// snapshotから作成したPersistent DiskをブートディスクとしてGCEを起動する
resource "google_compute_instance" "test-instance" {
  //インスタンス名、マシンタイプ、作成するゾーンの選択
  name         = "${var.instanceName}"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"

  //ネットワークタグを記載
  tags = ["http-server"]

  //立ち上げるOSを選択。
  boot_disk {
      source = "${google_compute_disk.terraform_disk.name}"
  }

  //プリミティブVMとして作成
  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  //ネットワークインタフェース情報を記載。
  //IPアドレス固定化等設定
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  //service_accountの設定
  service_account {
    email = 【ServiceAccount】
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
