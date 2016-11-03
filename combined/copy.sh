#!/bin/sh

printUsage() 
{
  echo "./copy.sh HOST SOURCE_DIR DEST_DIR"
}

if [ "$#" -ne 3 ]; then
  printUsage;
  exit 1;
fi

HOST="$1"
SOURCE_DIR="$2"
DEST_DIR="$3"

if [ ! -d "$SOURCE_DIR" ]; then
  printUsage;
  exit 1;
fi

KEY="$SOURCE_DIR/privkey.pem"
CERT="$SOURCE_DIR/fullchain.pem"
DH="$SOURCE_DIR/dhparam.pem"

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

mkdir -p "$DEST_DIR"

cp "$KEY" "$DEST_DIR/$HOST.key"
cp "$CERT" "$DEST_DIR/$HOST.crt"
cp "$DH" "$DEST_DIR/$HOST.dhparam.pem"
