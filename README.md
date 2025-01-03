
# Raspberry Pi Flutter Setup Guide

## 1. Install `snapp_installer` on Raspberry Pi

- Ensure the Flutter version matches **3.22.3** on the Raspberry Pi.

## 2. Configure Laptop for Running Raspberry Pi Device

1. If Snapp CLI can't run or activate:

   ```bash
   dart pub global activate snapp_cli
   ```

2. Add devices:

   ```bash
   snapp_cli add device
   ```

   - Follow the prompts to add the required configuration.

3. Check connected devices:

   ```bash
   flutter devices
   ```

4. Run the application using the device name:

   ```bash
   flutter run -d pi-4b
   ```

## 3. SSH Passwordless Configuration

If SSH access prompts for a password, configure passwordless SSH:

1. Copy SSH key to the Raspberry Pi:

   ```bash
   ssh-copy-id user@192.168.xxx.xxx
   ```

2. Test SSH connection:

   ```bash
   ssh user@192.168.xxx.xxx
   ```

   - After configuration, SSH should no longer require a password because we already Copy SSH key to the Raspberry Pi.

## 4. Connect Wi-Fi via Terminal

1. Check the status of network devices:

   ```bash
   nmcli dev status
   ```

2. Connect to a Wi-Fi network:

   ```bash
   sudo nmcli dev wifi connect "SSID" password "PASSWORD"
   ```

## 5. Disable Ethernet

1. Identify the Ethernet interface (usually named `eth0`).
2. Disable Ethernet:

   ```bash
   sudo ifconfig eth0 down
   ```

> Replace `eth0` with the appropriate Ethernet interface name if different.
