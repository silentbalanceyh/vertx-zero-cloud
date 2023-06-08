#!/usr/bin/env bash
rm -rf istio
curl -L https://istio.io/downloadIstio | sh -
mv -f istio-1.14.1 istio