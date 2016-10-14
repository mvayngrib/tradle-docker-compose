#!/bin/sh

printUsage() 
{
  echo "./copy.sh SOURCE_DIR DEST_DIR"
}

if [ -f .env ]; then
  source ./.env
fi

if [ -z $HOST ]; then 
  echo "set HOST environment variable";
  exit 1;
fi

if [ ! -d "$1" ]; then 
  printUsage;
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
    echo "expected dhparam.pem at $DH. To generate it, run: openssl dhparam -out \"$DH\" 2048"; 	
    exit 1;
  fi
fi

mkdir -p $2

cp "$KEY" "$2/$HOST.key"
cp "$CERT" "$2/$HOST.crt"
cp "$DH" "$2/$HOST.dhparam.pem"
