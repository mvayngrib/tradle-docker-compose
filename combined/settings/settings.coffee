exports.server =
    redis_port: '{{ REDIS_PORT | default(6379, false) }}'
    redis_host: '{{ REDIS_HOST | default("localhost", false) }}'
    {% if REDIS_PASSWORD %}
    redis_auth: '{{REDIS_PASSWORD}}'
    {% endif %}
    tcp_port: 8081
    udp_port: 8081
    access_log: yes
{% if ENABLE_ACL %}
    acl:
        # restrict publish access to private networks
        publish: ['127.0.0.1', '10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16']
{% endif %}

exports['event-source'] =
    enabled: yes

{% if APNS_CERT and APNS_KEY %}
# IOS APNS pushes
exports['apns'] =
    enabled: yes
    class: require('./lib/pushservices/apns').PushServiceAPNS
    # Convert cert.cer and key.p12 using:
    # $ openssl x509 -in cert.cer -inform DER -outform PEM -out apns-cert.pem
    # $ openssl pkcs12 -in key.p12 -out apns-key.pem -nodes
    cert: '{{APNS_CERT}}'
    key: '{{APNS_KEY}}'
    cacheLength: 100
    # Uncomment to set the default value for parameter.
    # This setting not overrides the value for the parameter that is set in the payload fot event request.
    # category: 'show'
    # contentAvailable: true
    # Selects data keys which are allowed to be sent with the notification
    # Keep in mind that APNS limits notification payload size to 256 bytes
    payloadFilter: ['messageFrom']
    # uncommant for dev env
    gateway: 'gateway.sandbox.push.apple.com'
    address: 'feedback.sandbox.push.apple.com'
{% endif %}

{% if GCM_KEY %}
# Android GCM pushes
exports['gcm'] =
    enabled: yes
    class: require('./lib/pushservices/gcm').PushServiceGCM
    key: '{{ GCM_KEY }}'
{% endif %}

# Push message as post request
exports['http'] =
    enabled: yes
    class: require('./lib/pushservices/http').PushServiceHTTP

{% if WNS_ID and WNS_SECRET %}
# Windows phone pushes: WP7.5, 8.1
exports["wns-toast"] =
    enabled: yes
    client_id: 'ms-app://{{WNS_ID}}'
    client_secret: '{{WNS_SECRET}}'
    class: require('./lib/pushservices/wns').PushServiceWNS
    type: 'toast'
    # Any parameters used here must be present in each push event.
    launchTemplate: '/Page.xaml?{{WNS_QUERY_STRING}}'
{% endif %}

# Transports: Console, File, Http
#
# Common options:
# level:
#   error: log errors only
#   warn: log also warnings
#   info: log status messages
#   verbose: log event and subscriber creation and deletion
#   silly: log submitted message content
#
# See https://github.com/flatiron/winston#working-with-transports for
# other transport-specific options.
exports['logging'] = [
        transport: 'Console'
        options:
            level: '{{ PUSHD_LOGGING_LEVEL  | default("silly", false)}}'
    ]
