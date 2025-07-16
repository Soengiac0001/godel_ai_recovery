#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void run_tool(const char* tool_name, const char* args) {
    char command[1024];
    snprintf(command, sizeof(command), "%s %s", tool_name, args);
    printf("[🛠️ TOOLCHAIN] Executing: %s\n", command);
    int result = system(command);
    if (result != 0) {
        printf("[❌] Tool failed: %s\n", command);
    }
}

