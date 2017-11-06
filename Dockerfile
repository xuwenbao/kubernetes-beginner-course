FROM node:9.0.0
MAINTAINER Wenbao Xu<xuwenbao@chinacloud.com.cn>

# install nodeppt
RUN npm --registry=https://registry.npm.taobao.org install -g nodeppt
# copy markdown files into image
COPY . /src

EXPOSE 8080
CMD ["/usr/local/bin/nodeppt", "start", "-p", "8080"]