locals {
    lamp_template = {
        group_name      = "lamp"
        vm              = var.TMP_VMS[index(var.TMP_VMS.*.name, "lamp_template")]
        max_creating    = 3
        max_expansion   = 3
        max_deleting    = 3
        scale_size      = 3 
        max_unavailable = 1
    }

    sa_iam = [
        {
            role    = "storage.editor"
            sa_id   = "${yandex_iam_service_account.sa.id}"
        },
        {
            role    = "vpc.publicAdmin"
            sa_id   = "${yandex_iam_service_account.sa.id}"
        },
        {
            role    = "editor"
            sa_id   = "${yandex_iam_service_account.sa.id}"
        }
    ]

}