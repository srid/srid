---
slug: rtl8821cu
---

Having gotten frustrated with the [[X1C7 WiFi issue]], I decided to use an external USB WiFi adapter. [Here is the specific adapter](https://www.amazon.ca/gp/product/B078MHKFJ9/)[^title] I purchased from Amazon. It does not work with Linux out of the box; however, the shipment came with a mini CD (with presumably the Windows driver) that had the code `RTL8811/RTL8812` which hinted at the possible Linux driver to use.

[^title]: Product title: *WiFi Adapter Flenco 600Mbps WiFi Dongle Mini Dual Band 2.4G/5G USB Wireless Network Adapter Support for Win 7/8/8.1/10/XP/Vista*

## Initial investigation

After inserting the adapter to USB port, `dmesg` displayed

```
[  +0.933146] usb 1-3: USB disconnect, device number 6
[  +4.194956] usb 1-3: new high-speed USB device number 11 using xhci_hcd
[  +0.126132] usb 1-3: New USB device found, idVendor=0bda, idProduct=c811, bcdDevice= 2.00
[  +0.000006] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000003] usb 1-3: Product: 802.11ac NIC
[  +0.000003] usb 1-3: Manufacturer: Realtek
[  +0.000003] usb 1-3: SerialNumber: 123456
```

And `lsusb` identified ([why?](https://askubuntu.com/questions/510713/ifconfig-cant-see-usb-wireless)) the device ID `c811`:


```
$ lsusb | grep 802
Bus 001 Device 011: ID 0bda:c811 Realtek Semiconductor Corp. 802.11ac NIC
```

Which led me to [this post](https://askubuntu.com/questions/1162974/wireless-usb-adapter-0bdac811-realtek-semiconductor-corp) that indicated that I needed to use the [`8821cu`](https://github.com/brektrou/rtl8821CU) (matching what's on the mini CD) Linux driver for this particular hardware.

## Configuring NixOS

Fortunately, this is all in nixpkgs; I only had to add the following to my NixOS configuration and reboot:

```nix
boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
```

Reboot.

## Using the card

Expect to see the card in `ifconfig`. If connecting via `nmtui` produces this error:

```
Could not activate connection
Insufficient privileges
```

... use `sudo nmtui`.
