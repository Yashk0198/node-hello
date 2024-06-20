# node-hello
# Create dockerfile

# To setup the Cluster using EKSCTL, follow the following steps - 

1) You must have access and secret access key for the user that you can get from IAM.

2) Set the access and secret access key in the machine at "~/.aws/credentials" or "aws configure" path(you can create this path) as -
   [default]
   aws_access_key_id = ""
   aws_secret_access_key = ""
   
 3) Install awscli as - 
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt install unzip
    unzip awscliv2.zip
    sudo ./aws/install 
    
 4) Install kubectl as - 
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.26.4/2023-05-11/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
    kubectl version --client
 
 5) Install aws-iam-authenticator as - 
    curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64
    chmod +x ./aws-iam-authenticator
    mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
    aws-iam-authenticator help
   
     
 6) Now install eksctl as  - 
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    export PATH=$PATH:/usr/local/bin
    echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
    eksctl version
    
7) Create cluster using eksctl as  - 
    eksctl create cluster  --name mycluster --version 1.26 --nodegroup-name mygroup --node-type t2.micro --nodes 2 --region us-east-1 # --region us-east-1 --zones=us-east-1a,us-east-1b,us-east-1d


   Install Helm on ubuntu server
   -------------------------------
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

Install and configure argocd
------------------------------
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get pods -n argocd
kubectl get svc -n argocd
Edit the svc of type LoadBalancer or Nodeport

Username is admin and for password run the below command

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d



