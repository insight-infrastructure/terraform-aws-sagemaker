#!/bin/bash
set -e

cd /home/ec2-user/SageMaker

%{ for n in notebook_paths ~}
aws s3 cp s3://${notebook_bucket_name}/${n} .
%{ endfor ~}

%{ for s in script_paths ~}
aws s3 cp s3://${scripts_bucket_name}/${s} .
%{ endfor ~}

#aws s3 cp s3://${bucket_name}/sagemaker/sample/notebooks/Scikit-learn_Estimator_Example_With_Terraform.ipynb .
#aws s3 cp s3://${bucket_name}/sagemaker/sample/scripts/scikit_learn_script.py .

ENVIRONMENT=python3
#NOTEBOOK_FILE=/home/ec2-user/SageMaker/Scikit-learn_Estimator_Example_With_Terraform.ipynb

source /home/ec2-user/anaconda3/bin/activate "$ENVIRONMENT"
nohup jupyter nbconvert "$NOTEBOOK_FILE" --ExecutePreprocessor.kernel_name=python3 --ExecutePreprocessor.timeout=1500 --execute
source /home/ec2-user/anaconda3/bin/deactivate
