FROM httpd
MAINTAINER madhukeerthy
LABEL dockerfile
COPY . /usr/local/apache2/htdocs/
