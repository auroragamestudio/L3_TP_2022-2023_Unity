Shader "L3/PostProcess"
{
    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
	        HLSLPROGRAM
            #pragma vertex VertDefault
            #pragma fragment Frag

			#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/Colors.hlsl"

            // Declaration d'un Sampler2D pour lire dans l'image déjà rendue 
			TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);
			       
			// Dimensions en pixels de la texture _MainTex, remplies par Unity automatiquement
			float4 _MainTex_TexelSize;

            float _Radius;
			float _Amount;
            float _Saturation;
            float _Tint;
            
			float3 blur(float2 uv, float radius)
			{
				// Matrice de rotation 2D
				float2x2 m = float2x2(-0.736717,0.6762,-0.6762,-0.736717);
				int nbSamples = 64;
				
				float3 blurredPixel = float3(0.0,0.0,0.0);

				// distance entre les pixels
				float2 s = _MainTex_TexelSize.zw;
				float2 texel = float2(2/s.x,2/s.y);

				// vecteur 2D pour la lecture des pixels de l'image à flouter
				float2 angle = float2(0.0,radius);
				
				radius = 1.0;
				for (int j=0;j<nbSamples;j++)
				{
					 //sm 5.0 fast reciprocal function
					radius += rcp(radius);

					// Rotation de la direction de l'uv de lecture 
					angle = mul(angle,m);

					// Calcul de l'uv tourné
					float2 rotatedUV = uv + texel*(radius-1.0)*angle;

					// lecture du pixel de l'image à flouter
					float3 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, rotatedUV ).rgb;

					// Accumulation des valeurs de pixel
					blurredPixel += color;
				}
				
				// Moyenne des pixels
				return blurredPixel/(float)nbSamples;
			}
            
			float4 Frag(VaryingsDefault i) : SV_Target
			{
				float4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);

				//TODO implémenter l'effet de flou et appliquer l'effet en fonction de la variable _Amount
					
				
				//TODO Ajuster la colorimétrie du pixel courant : saturation et teinte

				
					
				return color;
			}
			ENDHLSL
		}
    }
}