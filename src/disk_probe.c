#include <stdio.h>
#include <stdlib.h>

void probe_disks() {
    printf("[🔍] Probing available disks...\n");
    int status = system("lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT > logs/devices.log");
    if (status == 0) {
        printf("[✅] Disk probe complete. Results written to logs/devices.log\n");
    } else {
        printf("[❌] Disk probe failed.\n");
    }
}
