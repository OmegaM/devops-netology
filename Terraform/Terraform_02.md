# 7.2. Облачные провайдеры и синтаксис Terraform.

#### 1.
![aws_registration](../imgs/aws_registration.png)
2.
```bash
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 42.7M  100 42.7M    0     0  11.9M      0  0:00:03  0:00:03 --:--:-- 11.9M

unzip awscliv2.zip
...
$ sudo ./aws/install
You can now run: /usr/local/bin/aws --version
$ aws --version 
aws-cli/2.2.46 Python/3.8.8 Linux/5.11.0-37-generic exe/x86_64.ubuntu.20 prompt/off
```

3.
```bash
aws configure
AWS Access Key ID [None]: $AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: $AWS_SECRET_ACCESS_KEY
Default region name [None]: us-west-2
Default output format [None]: yaml
```
6.
![es2_creating](../imgs/free_instance_creating.png)
![instance_type_selecting](../imgs/instance_type_selecting.png)
![instance_lauching](../imgs/instance_lauching.png)
![stoping_instance](../imgs/stoping_instance.png)

```bash
aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************DTQH              env    
secret_key     ****************beBD              env    
    region                us-west-2      config-file    ~/.aws/config
```
#### 2.
