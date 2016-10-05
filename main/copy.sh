#!/bin/bash

source .env
if [ -z $TRADLE_HOST ]; then 
  echo "set TRADLE_HOST environment variable";
  exit 1;
fi

KEY="$1/privkey.pem"
CERT="$1/fullchain.pem"
DH="$1/dhparam.pem"

if [ ! -L "$KEY" ]; then 
  if [ ! -f "$KEY" ]; then
    echo "expected privkey.pem at $KEY";
    exit 1;
  fi
fi

if [ ! -L "$CERT" ]; then
  if [ ! -f "$CERT" ]; then
    echo "expected fullchain.pem at $CERT"; 	
    exit 1;
  fi
fi

if [ ! -L "$DH" ]; then
  if [ ! -f "$DH" ]; then
    echo "expected dhparam.pem at $DH. To generate it, run: openssl dhparam -out \"$DH/dhparam.pem\" 2048"; 	
    exit 1;
  fi
fi

mkdir -p $2

cp "$KEY" "$2/$TRADLE_HOST.key"
cp "$CERT" "$2/$TRADLE_HOST.crt"
cp "$DH" "$2/$TRADLE_HOST.dhparam.pem"
