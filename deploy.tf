// snapshot����Persistent Disk���쐬����
resource "google_compute_disk" "terraform_disk" {
  name     = "terraform-disk"
  type     = "pd-ssd"
  zone     = "${var.region_zone}"
  snapshot = �ySnapshot-name�z
  size     = 10
}

// snapshot����쐬����Persistent Disk���u�[�g�f�B�X�N�Ƃ���GCE���N������
resource "google_compute_instance" "test-instance" {
  //�C���X�^���X���A�}�V���^�C�v�A�쐬����]�[���̑I��
  name         = "${var.instanceName}"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"

  //�l�b�g���[�N�^�O���L��
  tags = ["http-server"]

  //�����グ��OS��I���B
  boot_disk {
      source = "${google_compute_disk.terraform_disk.name}"
  }

  //�v���~�e�B�uVM�Ƃ��č쐬
  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  //�l�b�g���[�N�C���^�t�F�[�X�����L�ځB
  //IP�A�h���X�Œ艻���ݒ�
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  //service_account�̐ݒ�
  service_account {
    email = �yServiceAccount�z
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
