#ifndef L3_LIGHTING // bonne pratique
#define L3_LIGHTING

#include "UnityLightingCommon.cginc"
#include "UnityStandardUtils.cginc"

half sunLightIntensity()
{
    return LinearRgbToLuminance(_LightColor0);
}

float3 ambientLight(float3 normal, float3 ambient, float3 worldPos)
{
    return ShadeSHPerPixel(normal, ambient, worldPos);
}

#endif
