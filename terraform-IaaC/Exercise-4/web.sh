# #!/bin/bash
# yum install wget unzip httpd -y 
# systemctl start httpd
# systemctl enable httpd
# cp -r /2133_moso_interior.zip ./
# echo "============= COPIED FILE ============"
# # wget https://www.tooplate.com/zip-templates/2133_moso_interior.zip
# unzip -o 2133_moso_interior.zip
# cp -r 2133_moso_interior/* / var/www/html/
# systemctl restart httpd


# #!/bin/bash
# yum install wget unzip httpd -y
# systemctl start httpd
# systemctl enable httpd
# if systemctl is-active --quiet httpd; then
#     echo "Apache HTTP Server is running:"
#     systemctl status httpd
# else
#     echo "Apache HTTP Server is not running."
# fi
# wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
# unzip -o 2117_infinite_loop.zip
# cp -r 2117_infinite_loop/* /var/www/html/
# systemctl restart httpd
#!/bin/bash

# Configure yum to skip the failing repository if it's unavailable
sudo yum-config-manager --save --setopt=<repoid>.skip_if_unavailable=true

# Install required packages
yum install wget unzip httpd -y

# Start and enable Apache HTTP Server
systemctl start httpd
systemctl enable httpd

# Check if Apache HTTP Server is running
if systemctl is-active --quiet httpd; then
    echo "Apache HTTP Server is running:"
    systemctl status httpd
else
    echo "Apache HTTP Server is not running."
fi

# Download and extract website files
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip
unzip -o 2117_infinite_loop.zip

# Copy website files to Apache document root
cp -r 2117_infinite_loop/* /var/www/html/

# Restart Apache HTTP Server
systemctl restart httpd


