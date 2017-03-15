. $BUILDER_DIR/CONFIG


echostderr "Syncing the filesystem from $BUILDER_DIR"

rsync -ar $BUILDER_DIR/platform-uploads/ /


echostderr "Setting permissions"

if [ -d /etc/nginx ]; then
    chmod 755 /etc/nginx/conf.d
    chmod 644 /etc/nginx/nginx.conf
    rm -rf /etc/nginx/sites-enabled/default
    chown -R root.root /etc/nginx/
    chown -R www-data.adm /var/log/nginx
fi

if [ -d /var/www/errors/ ]; then
    chown -R www-data.adm /var/www/errors
    chmod -R 644 /var/www/errors
fi




