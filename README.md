# IM3270 Terminal Emulator - Downloads

Modern 3270 terminal emulator for Windows and Linux.

## Download Latest Version (v0.43.16)

| Platform | Download | Size |
|----------|----------|------|
| **Windows Installer** | [IM3270 Setup 0.43.16.exe](https://github.com/stcarmi/im3270-releases/releases/download/v0.43.16/IM3270.Setup.0.43.16.exe) | ~100 MB |
| **Windows Portable** | [IM3270 0.43.16.exe](https://github.com/stcarmi/im3270-releases/releases/download/v0.43.16/IM3270.0.43.16.exe) | ~100 MB |
| **Linux tar.gz** | [im3270-0.43.16-linux.tar.gz](https://github.com/stcarmi/im3270-releases/releases/download/v0.43.16/im3270-0.43.16-linux.tar.gz) | ~119 MB |
| **Linux AppImage** | [IM3270-0.43.16.AppImage](https://github.com/stcarmi/im3270-releases/releases/download/v0.43.16/IM3270-0.43.16.AppImage) | ~120 MB |

**macOS**: Coming soon!

## What's New in v0.43.16

- Fix Profile Manager: clicking a profile caused Save to update instead of creating a new one

## Prerequisites

### s3270 4.x Required

IM3270 requires **s3270 version 4.0 or later**. Linux distro packages (`dnf install x3270-x11`, `apt install x3270`) install outdated v3.x which will **not work**.

### Windows
- Download and install [wc3270 4.x](https://x3270.miraheze.org/wiki/Downloads) and ensure it's in your PATH

### Linux (all distros) - Build s3270 from source
```bash
# Install build dependencies
sudo dnf install gcc make openssl-devel   # Fedora/RHEL
# or: sudo apt install gcc make libssl-dev  # Ubuntu/Debian

# Download and build s3270 4.x
wget https://x3270.bgp.nu/download/04.04/suite3270-4.4ga6-src.tgz
tar xzf suite3270-4.4ga6-src.tgz
cd suite3270-4.4
./configure && make s3270 && sudo make install.s3270
```

Verify installation:
```bash
s3270 -version   # Should show 4.x
```

### Linux AppImage
```bash
# AppImage requires FUSE
sudo dnf install fuse fuse-libs   # Fedora/RHEL
# or: sudo apt install fuse libfuse2  # Ubuntu/Debian
```

## Troubleshooting

IM3270 writes a diagnostic log on every startup:
```bash
cat ~/.im3270/im3270.log
```

The log captures s3270 version checks, backend startup, and errors. Check this file if the app won't start or connect.

## Features

- Multi-tab terminal sessions
- Split screen mode (side-by-side / top-bottom)
- Macro recording and playback
- File transfer (IND$FILE)
- Paste to Data Area (Ctrl+Shift+V) for ISPF editor
- Retro CRT display mode
- Keystroke display for demos
- SSL/TLS support
- Profile manager with Quick Connect
- Customizable keyboard shortcuts
- And much more...

## Documentation

Visit [im3270.infomanta.com](https://im3270.infomanta.com) for full documentation.

## License

IM3270 includes a **60-day free trial**. Purchase a license at [im3270.infomanta.com](https://im3270.infomanta.com).

## Support

- Email: support@infomanta.com
- Website: [im3270.infomanta.com/support](https://im3270.infomanta.com/support.html)

---

Developed by [Infomanta Ltd](https://www.infomanta.com)
