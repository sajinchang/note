#!/usr/bin/env bash

# produce a html file

cat <<EOF
    <html>
        <head>
            <title>
               My System Information
            </title>
        </head>
        <body>
            <h1>My System Information</h1>
            <div>
            `free -m`
            </div> 
        </body>
    </html>
EOF
