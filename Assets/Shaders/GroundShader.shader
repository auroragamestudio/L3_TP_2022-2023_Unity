Shader "L3/GroundShader"
{
    Properties
    {
        _GroundColor( "Ground Color", Color ) = (0, 0, 0, 1)
    	
    	//TODO ETAPE 1 : Ajouter une propriété pour la normal map
    	
    }
	
    SubShader
    {
    	CGINCLUDE
    		#include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "L3_Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;

    			//TODO Etape 2 : ajouter l'entrée TANGENT
	        	

    			float3 normal : NORMAL;
	        	float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            	float2 uv : TEXCOORD0;

            	//TODO Etape 2 : ajouter un tableau de 3 float3 pour stocker la matrice de passage NORMAL vers WORLD 
				

            	UNITY_FOG_COORDS(4)
            	LIGHTING_COORDS(5,6)
            	float4 worldPos : TEXCOORD7;
            	float3 worldNormal : TEXCOORD8;
            };

    		//TODO ETAPE 1 : ajouter la texture _NormalMap
			

    		// Cette variable bizarrement nommée permet de faire le lien entre l'UI Tiling et Offset de l'inspector et le shader
			float4 _NormalMap_ST; // X et Y contiennent le Tiling, Z et W contiennent l'Offset
	        
            fixed4 _GroundColor;
	        fixed4 _CelShadowColor;
  
            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _NormalMap); // Macro Unity qui permet d'appliquer l'offset et le tiling sur l'UV
            	o.worldPos = mul( unity_ObjectToWorld, v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);

            	//TODO Ajouter le code préparation de la matrice de passage espace NORMAL vers Espace WORLD 
            	
                

            	UNITY_TRANSFER_FOG(o,o.pos);
            	TRANSFER_VERTEX_TO_FRAGMENT(o);
                return o;
            }
    	ENDCG
    	
	    Pass
        {
        	Tags { "RenderType"="Opaque" "LightMode" = "ForwardBase" }
        
        	ZWrite On
            Cull Back
        		
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
	        #pragma multi_compile_fwdbase
            
            fixed4 frag (v2f i) : SV_Target
            {
            	//TODO Décoder la normale stockée dans la texture NormalMap
            	//TODO Utiliser la matrice de passage NORMAL vers WORLD pour calculer
            	// la nouvelle normale dans l'espace WORLD
				
				

            	float light = saturate(dot(i.worldNormal, _WorldSpaceLightPos0));
            	
            	float attenuation = LIGHT_ATTENUATION(i); // Contient les ombres projetées
                fixed4 col = _GroundColor * ((light * attenuation) + _CelShadowColor) * sunLightIntensity();
            	
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
        
    	// TODO Forward Add pass
    	Pass
        {
        	Tags { "LightMode" = "ForwardAdd" }
        
        	Blend One One
            ZWrite Off
        		
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #pragma multi_compile_fwdadd_fullshadows

            fixed4 frag (v2f i) : SV_Target
            {
            	// TODO ajouter le calcul de l'éclairage utilisant les normales map en modifiant la ligne "light"
            					

            	float light = saturate(dot(i.worldNormal, normalize(_WorldSpaceLightPos0 - i.worldPos) ) );
            	
            	float attenuation = SHADOW_ATTENUATION(i);
                fixed4 col = _LightColor0 * light * attenuation;
				col.a = 1;
                return col;
            }
            ENDCG
        }
    	
    	
        Pass
		{		
			Tags{ "LightMode" = "ShadowCaster" }		
			CGPROGRAM
			#pragma vertex vertex_shader
			#pragma fragment pixel_shader
			#pragma target 3.0
					
			float4 vertex_shader (float4 vertex:POSITION,uint id:SV_VertexID) : SV_POSITION
			{
				return UnityObjectToClipPos(vertex);								
			}

			float4 pixel_shader (void) : COLOR
			{
				return 0;
			}
			ENDCG
		}
    	
    }
}
