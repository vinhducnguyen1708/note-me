cat << EOF > /var/www/html/index.html
<html><head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<style>
    body {
        background-image: url('lake.jpg');
        background-size: cover;
    }
    .container {
        color: #f5f5f5;
        font-size: 70px;
        font-weight: bold;
        position: absolute;
        top: 50%;
        left: 50%;
        -moz-transform: translateX(-50%) translateY(-50%);
        -webkit-transform: translateX(-50%) translateY(-50%);
        transform: translateX(-50%) translateY(-50%);
    }
    </style></head><body>
    <div class="container">
      Response from: Somethingcool
    </div></body></html>
EOF