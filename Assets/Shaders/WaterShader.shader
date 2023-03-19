Shader "L3/WaterShader"
{
	Properties
	{
		_Noise( "Noise Map", 2D ) = "white" {}
		_DeepWaterColor( "Deep Water Color", Color ) = (0.325, 0.807, 0.971, 1.0)
		_WaveWaterColor( "Shallow Water Color", Color ) = (0.325, 0.807, 0.971, 1.0)
		_WaterAmplitude ( "Water Amplitude", Range( 0.0, 2.0 ) ) = 0.1
		_UVScale( "UV Scale ", Range( 0.0, 0.2 ) ) = 1
		_UVSpeed( "UV Speed", Range( 0.0, 0.2 ) ) = 1
		_dxdz( "Normal Dx Dz", Range( 0.0, 2 ) ) = 1.0
		_depthDistance( "depth distance", Range( 0.0, 1.0 ) ) = 1

		[PowerSlider( 4 )] _FresnelExponent( "Fresnel Exponent", Range( 0.25, 4 ) ) = 1
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		//TODO Ajouter le mode de blending Transparency
		
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			
			#include "L3_Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS( 1 )
				float4 vertex : SV_POSITION;

				float3 normalDir : TEXCOORD2;

				//TODO Ajouter un float3 ViewDir et un float4 pour screenPosition

			};

			sampler2D _Noise;
			sampler2D _CameraDepthTexture;
			float _depthDistance;

			float4 _DeepWaterColor;
			float4 _WaveWaterColor;

			float3 _FresnelColor;
			float _FresnelExponent;

			float _WaterAmplitude;
			float _UVScale;
			float _UVSpeed;
			float _dxdz;
			
			v2f vert( appdata v )
			{
				v2f o;

				// *****************************************************************************************************
				// Calcul des positions mondes
				// *****************************************************************************************************
				
				

				// *****************************************************************************************************
				// World UV generation & UV scaling and scrolling
				// *****************************************************************************************************
				
				

				// *****************************************************************************************************
				// Lecture de la texture de bruit de Perlin
				// http://kitfox.com/projects/perlinNoiseMaker/
				// *****************************************************************************************************
			
				

				// *****************************************************************************************************
				// Calcul de la normale
				// *****************************************************************************************************
				
				

				// *****************************************************************************************************
				// Vertex displacement : animation du mesh
				// *****************************************************************************************************
				

				// *****************************************************************************************************
				// Calcul de la position du vertex dans l'espace de clipping
				// *****************************************************************************************************
				o.vertex = UnityObjectToClipPos( v.vertex );

				// *****************************************************************************************************
				// Stocker les données View dir et normal dir dans la structure de sortie
				// *****************************************************************************************************
				
				o.normalDir = v.normal;
				

				
				
				UNITY_TRANSFER_FOG( o,o.vertex );
				return o;
			}

			#define SMOOTHSTEP_AA 0.01
			
			fixed4 frag( v2f i ) : SV_Target
			{
				// *****************************************************************************************************
				// Ecume du bord de l'eau basée sur la depth map
				// *****************************************************************************************************
				
				
				
				// *****************************************************************************************************
				// Water color utilisation de la texture de noise pour réhausser les crêtes
				// *****************************************************************************************************
				
				
					
				// *****************************************************************************************************
				// Eclairage : Lambert
				// *****************************************************************************************************
				
				

				// *****************************************************************************************************
				// Fresnel et Reflection
				// *****************************************************************************************************
	
				
				
				// *****************************************************************************************************
				// Calcul de la couleur de l'eau et application de l'éclairage
				// *****************************************************************************************************
				fixed4 output = _DeepWaterColor;
				
				
				// *****************************************************************************************************
				// Transparence et Ecume 
				// *****************************************************************************************************
				

				
				UNITY_APPLY_FOG( i.fogCoord, col );
				return output;
			}
			ENDCG
		}
	}
}
