#include <stdio.h>
#include <stdlib.h>

void run_cmd(const char *cmd) {
    printf("\n[🧠 CMD] %s\n", cmd);
    int result = system(cmd);
    if (result != 0) {
        printf("[❌] Command failed: %s\n", cmd);
    }
}

int main() {
    printf("⚙️  Gödel AI Recovery - System Scan Begin\n");

    // Identify connected storage devices
    run_cmd("lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT > logs/devices.log");
    run_cmd("echo '[📁] Listing block devices complete.'");

    // Scan SMART data
    run_cmd("smartctl --scan > logs/smart_devices.log");
    run_cmd("bash -c 'for dev in $(cut -d\" \" -f1 logs/smart_devices.log); do "
        "echo \"Device: $dev\" >> logs/smart_status.log; "
        "smartctl -a $dev >> logs/smart_status.log 2>&1; "
        "done'");
    
    run_cmd("which photorec > logs/toolcheck.log || echo 'photorec missing' >> logs/toolcheck.log");
    run_cmd("which ddrescue >> logs/toolcheck.log || echo 'ddrescue missing' >> logs/toolcheck.log");

    // Mount attempt
    run_cmd("mkdir -p /mnt/recovery");
    run_cmd("mount /dev/sda1 /mnt/recovery 2>> logs/mount.log || echo '[⚠️] Mount failed, logging only.' >> logs/mount.log");

    printf("\n✅ System Scan Complete.\n");
    return 0;
}
