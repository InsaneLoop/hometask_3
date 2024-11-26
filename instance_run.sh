aws ec2 run-instances --image-id ami-012967cc5a8c9f891 \
--count 1 \
--instance-type t2.micro \
--key-name hometask2 \
--security-group-ids sg-0d97c6f05dd2de4c7 \
--subnet-id  subnet-01d6a4e65da866e80 \
--iam-instance-profile Name=SSMrole \
--user-data file://script.sh
