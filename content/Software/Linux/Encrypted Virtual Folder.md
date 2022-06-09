---
slug: vf.enc
---

https://wiki.archlinux.org/title/Dm-crypt/Encrypting_a_non-root_file_system

Create a virtual folder (`~/foo`) from an encrypted file `~/foo.img`:

```bash
# Create ~/private that is encrypted
NAME=private
SIZE=100M

# First-time setup
dd if=/dev/urandom of=~/${NAME}.img bs=$SIZE count=1 iflag=fullblock

LOOP=$(losetup --find)
sudo losetup $LOOP ~/${NAME}.img
sudo cryptsetup luksFormat $LOOP
sudo cryptsetup open $LOOP $NAME
sudo mkfs.ext4 /dev/mapper/$NAME
mkdir ~/$NAME

# Mount
sudo cryptsetup open $LOOP $NAME
sudo mount -t ext4 /dev/mapper/$NAME ~/$NAME

# Then, after reboots:
LOOP=$(losetup --find)
sudo losetup $LOOP ~/${NAME}.img
sudo cryptsetup open $LOOP $NAME
sudo mount -t ext4 /dev/mapper/$NAME ~/$NAME
```

- [ ] Nixify?
- [ ] Avoid having to `chown -R $USER` inside mounted dir?
- [ ] What does it take to resize later? Can we do it unbounded from beginning?