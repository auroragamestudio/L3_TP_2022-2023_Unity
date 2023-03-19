Shader "L3/EnvironmentCelShading"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _lightShadowThreshold( "Light Shadow Threshold", Range( 0.0, 1 ) ) = 0.5
        _lightShadowFrontierWidth( "Light Shadow Frontier Width", Range( 0.0, 0.1 ) ) = 0.01
    }
    SubShader
    {
    	CGINCLUDE
			#include "UnityCG.cginc"
			#include "L3_Lighting.cginc"
    	
			sampler2D _MainTex;
			float4 _MainTex_ST;

    		fixed4 _CelShadowColor;
			float _lightShadowThreshold;
			float _lightShadowFrontierWidth;

			struct appdata
			{
			    float4 vertex : POSITION;
			    float4 normal : NORMAL;
			    float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			    float3 normal : NORMAL;
				
			    float2 uv : TEXCOORD0;
			    UNITY_FOG_COORDS(1)
				float4 worldPos : TEXCOORD2;
			};

			v2f vert (appdata v)
			{
			    v2f o;
			    o.vertex = UnityObjectToClipPos(v.vertex);
			    o.normal = UnityObjectToWorldNormal(v.normal);
				o.worldPos = mul( unity_ObjectToWorld, v.vertex);
			    o.uv = TRANSFORM_TEX(v.uv, _MainTex);
			    UNITY_TRANSFER_FOG(o,o.vertex);
			    return o;
			}
    	ENDCG
    	
    	// Forward Base pass
        Pass
        {
        	Tags { "RenderType"="Opaque" "LightMode" = "ForwardBase"  }
        	
        	//TODO modifier le mode de culling pour passer en "double face"
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            //TODO Utiliser le paramètre "facing" pour éclairer uniquement les faces vers la lumière
            fixed4 frag (v2f i, fixed facing : VFACE) : SV_Target
            {
                // lecture de la texture de couleur
                fixed4 col = tex2D(_MainTex, i.uv);

                //TODO Ajouter éclairage Cel shading
                
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
        
    	// TODO Forward Add pass
    	/*
    	Pass
        {
        	Tags { "LightMode" = "ForwardAdd"  }
            Cull Off
        	Blend one one
        	Zwrite on
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            fixed4 frag (v2f i, fixed facing : VFACE) : SV_Target
            {
                // lecture de la texture de couleur
                fixed4 col = tex2D(_MainTex, i.uv);

                // Eclairage Cel shade
                float dotNL = saturate( dot(i.normal, normalize(_WorldSpaceLightPos0 - i.worldPos)));
                float lightShadowValue = smoothstep(_lightShadowThreshold - _lightShadowFrontierWidth,
                                                    _lightShadowThreshold + _lightShadowFrontierWidth,
                                                    dotNL * facing);

            	col *= lerp(0, 1, lightShadowValue) * _LightColor0;
                
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    	*/
    	
    	//TODO ajouter la pass de Shadow caster / depth
    	/*
	    Pass
		{		
			Tags{ "LightMode" = "ShadowCaster" }
			
			Cull Off
			
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
    	*/
    }
}
