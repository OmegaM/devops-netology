Terraform manifest use variables when create instances.
Default master node has stats :
CPU - 4
RAM - 4
Disk - 50
Count - 0

Default worker node has stats:
CPU -2
RAM - 2
Disk - 100
Count - 0

How to create instance cluster:
Example 1:
To create 1 master default node and 2 worker default nodes
```bash
terraform apply -var master_count=1 -var worker_count=2
```
Example 2:
To create 1 custom master node and 4 custom worker nodes
```bash
terraform apply -var master_instance={core=2,ram=2,disk=20,image_id="fd8mfc6omiki5govl68h"} -var master_count=1 -var worker_instance={core=4,ram=4,disc=150,image_id="fd8mfc6omiki5govl68h"} -var worker_count=4
```
