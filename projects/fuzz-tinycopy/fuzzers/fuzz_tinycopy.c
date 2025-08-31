#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include "tinycopy.h"

// 단순 문자열화 후 tinycopy_copy 호출
int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    if (size == 0 || size > 1023) return 0;
    char s[1024];
    memcpy(s, data, size);
    s[size] = '\0';
    tinycopy_copy(s);
    return 0;
}
