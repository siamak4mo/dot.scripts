#!/bin/bash
#
# `Bash_V2rayCollector` script
#  Bash V2ray configuration file collector
#
#  this script downloads v2ray config links from
#  telegram channels in the _CHANNELS variable below
#  the output will be in text format
#
#  some of the configuration links from these channels
#  are only valid for a few days or even hours,
#  so it's convenient to schedule running of this script
#
TMP_FILE="/tmp/bash_cc.html"
TMP_PART_FILE="/tmp/bash_cc.part"
MAX_PART=10
TIMEOUT="timeout 10s"

[[ -z "$HTTP_PROXY" ]] && CURL="$TIMEOUT $(which curl) -sk" \
        || CURL="$TIMEOUT $(which curl) -sk --proxy $HTTP_PROXY"

_CHANNELS="\
https://t.me/s/Awlix_ir
https://t.me/s/beta_v2ray
https://t.me/s/Configforvpn01
https://t.me/s/config_v2ray
https://t.me/s/configV2rayForFree
https://t.me/s/configV2rayNG
https://t.me/s/custom_14
https://t.me/s/customv2ray
https://t.me/s/DigiV2ray
https://t.me/s/Easy_Free_VPN
https://t.me/s/FOX_VPN66
https://t.me/s/FreakConfig
https://t.me/s/free4allVPN
https://t.me/s/Free_HTTPCustom
https://t.me/s/freeland8
https://t.me/s/FreeNet1500
https://t.me/s/FreeV2rays
https://t.me/s/freev2rayssr
https://t.me/s/free_v2rayyy
https://t.me/s/FreeVlessVpn
https://t.me/s/frev2ray
https://t.me/s/frev2rayng
https://t.me/s/God_CONFIG
https://t.me/s/HTTPCustomLand
https://t.me/s/iranvpnet
https://t.me/s/iSeqaro
https://t.me/s/mahsaamoon1
https://t.me/s/napsternetv_config
https://t.me/s/Network_442
https://t.me/s/nufilter
https://t.me/s/nx_v2ray
https://t.me/s/Outline_Vpn
https://t.me/s/polproxy
https://t.me/s/PrivateVPNs
https://t.me/s/proxy_mtm
https://t.me/s/Shadowlinkserverr
https://t.me/s/ShadowsocksM
https://t.me/s/ShadowSocks_s
https://t.me/s/shadowsocksshop
https://t.me/s/ultrasurf_12
https://t.me/s/v2rayan
https://t.me/s/v2ray_ar
https://t.me/s/v2RayChannel
https://t.me/s/v2ray_custom
https://t.me/s/v2ray_for_free
https://t.me/s/v2rayfree1
https://t.me/s/V2Ray_FreedomIran
https://t.me/s/V2Ray_FreedomIran
https://t.me/s/V2RAY_NEW
https://t.me/s/V2rayN_Free
https://t.me/s/V2rayNG3
https://t.me/s/v2rayng_fa2
https://t.me/s/v2rayng_org
https://t.me/s/v2rayng_v
https://t.me/s/v2rayngvpn
https://t.me/s/v2rayNG_VPN
https://t.me/s/V2rayNGvpni
https://t.me/s/v2rayNG_VPNN
https://t.me/s/v2rayn_server
https://t.me/s/v2ray_outlineir
https://t.me/s/V2RayOxygen
https://t.me/s/V2RAY_VMESS_free
https://t.me/s/v2rayvpnchannel
https://t.me/s/v2_vmess
https://t.me/s/vip_vpn_2022
https://t.me/s/ViPVpn_v2ray
https://t.me/s/vmess_iran
https://t.me/s/vmessiran
https://t.me/s/VmessProtocol
https://t.me/s/vmessq
https://t.me/s/vmess_vless_v2rayng
https://t.me/s/VorTexIRN
https://t.me/s/VPN_443
https://t.me/s/VPNCUSTOMIZE
https://t.me/s/vpn_ioss
https://t.me/s/vpnmasi
https://t.me/s/vpn_ocean
https://t.me/s/vpn_proxy_custom
https://t.me/s/vpn_proxy_custom
https://t.me/s/WeePeeN
https://t.me/s/YtTe3la"


for _ln in $_CHANNELS; do
    truncate -s 0 $TMP_FILE
    $CURL $_ln -o $TMP_FILE 2>&2
    
    if [[ ! "$?" == "0" ]]; then
        echo "Error -- Could not download $_ln" >&2
    else
        if [[ ! -s $TMP_FILE ]]; then
            echo "Warning -- $_ln got empty response" >&2
        else
            grep "\(ss\|vless\|vmess\|trojan\)://[^\"<]*" $TMP_FILE -o |\
                grep -v "…" >> $TMP_PART_FILE

            if [[ ! -s $TMP_PART_FILE ]]; then
                echo "Warning -- $_ln has no v2ray configuration link" >&2
            else
                tail -n $MAX_PART $TMP_PART_FILE | sort -u
            fi
        fi
    fi
done
