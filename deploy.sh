#!/bin/bash

HOST='pi@soundpi'
cd ..

update()
{
    FILE=SamplerBox/$1
    LOCAL_MD5=$(md5sum $FILE)
    REMOTE_MD5=$(ssh $HOST "md5sum $FILE")
    if [[ "$REMOTE_MD5" != "$LOCAL_MD5" ]]; then
        scp $FILE $HOST:$FILE
    fi
}

update samplerbox.py

# restart samplerbox
ssh $HOST "sudo systemctl daemon-reload; sudo systemctl restart samplerbox"
