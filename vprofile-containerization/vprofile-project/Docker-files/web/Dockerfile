FROM nginx
LABEL "Project"="Vprofile"
LABEL "Author"="Godfred"

# removing the default configuration 
RUN rm -rf /etc/nginx/conf.d/default.conf
# copying our default configuration to defaults location
COPY nginvproapp.conf /etc/nginx/conf.d/vproapp.conf