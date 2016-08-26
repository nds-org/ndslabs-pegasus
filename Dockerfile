FROM centos:7

# https://pegasus.isi.edu/documentation/installation.php 

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk wget vim && \
    wget -O /etc/yum.repos.d/htcondor.repo \ 
       http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel7.repo && \
    wget -O /etc/yum.repos.d/pegasus.repo \ 
       http://download.pegasus.isi.edu/wms/download/rhel/7/pegasus.repo && \
    yum install -y condor pegasus && \
    useradd  -p pegasus pegasus && \
    sed -i 's/AUTHENTICATION = "PAMAuthentication"/AUTHENTICATION = "NoAuthentication"/' /usr/lib64/python2.7/site-packages/Pegasus/service/defaults.py 


USER pegasus

RUN pegasus-db-admin update
    


EXPOSE 5000

CMD ["pegasus-service", "--host", "0.0.0.0"]


