FROM php:7.2.34-fpm-alpine as app

ENV TZ=Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    # deps 依赖
    # bind-tools 集成了常见的命令，如 dig, nslookup 等。
    apk update && \
    apk --no-cache add bind-tools tzdata \
    # timezone 时区
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo '$TZ' > /etc/timezone && \
    # composer
    # 不要使用 composer 镜像，因为官方的镜像使用的 PHP 可能是 PHP8，而真正的运行环境此处为 PHP7，导致安装下来的依赖是不能使用的。
    # 也可以独立构建镜像和运行时镜像，使用多阶段构建。
    wget -O /usr/local/bin/composer https://mirrors.aliyun.com/composer/composer.phar && \
    chmod +x /usr/local/bin/composer && \
    /usr/local/bin/composer config -g repos.packagist composer https://mirrors.aliyun.com/composer/ && \
    # php-fpm.conf
    echo "[global]"        > /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "daemonize = no" >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    # php.ini
    # 为了提升性能，启用 opcache，具体参数可以执行设置
    # 生产环境为了安全，建议关闭 PHP 版本标识
    cp /usr/local/etc/php/php.ini-production                 /usr/local/etc/php/php.ini && \
    sed -i "s/;opcache.enable_cli=0/opcache.enable_cli=1/g"  /usr/local/etc/php/php.ini && \
    sed -i "s/expose_php = On/expose_php = Off/g"            /usr/local/etc/php/php.ini

WORKDIR /app

# 以上可以作为一个基础镜像，作为一个 PHP 的基础环境
# 业务可以根据需要，统一安装 PHP 扩展等

COPY . .

RUN set -x ; mkdir -p storage \
    && mkdir -p storage/framework/cache \
    && mkdir -p storage/framework/sessions \
    && mkdir -p storage/framework/testing \
    && mkdir -p storage/framework/views \
    && mkdir -p storage/logs \
    && chmod -R 777 storage \
    && composer install -vvv

FROM nginx:alpine as nginx

COPY --from=app /app/nginx.conf /etc/nginx/conf.d/

COPY --from=app /app/public /app/public