#include <stdlib.h>
#include "../nanovg/src/nanovg.h"

#ifdef _MSC_VER
#pragma warning(disable: 4305)  // 'initializing' : truncation from 'double' to 'float'
#endif

#define BLENDISH_IMPLEMENTATION
#include "blendish.h"

#define OUI_IMPLEMENTATION
#ifdef __cplusplus
extern "C" {
#endif
#include "oui.h" 
#ifdef __cplusplus
}
#endif
