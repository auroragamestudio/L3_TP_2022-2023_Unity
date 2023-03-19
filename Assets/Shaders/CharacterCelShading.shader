Shader "L3/CharacterCelShading"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _lightShadowThreshold( "Light Shadow Threshold", Range( -1, 1 ) ) = 0.5
        _lightShadowFrontierWidth( "Light Shadow Frontier Width", Range( 0.0, 0.1 ) ) = 0.01
        
        _OutlineColor( "Outline Color", Color ) = (0, 0, 0, 1)
        _OutlineWidth( "Outline Width", Range( 0, 1 ) ) = 0.05
    }
    SubShader
    {
        CGINCLUDE
            #include "UnityCG.cginc"
            #include "L3_Lighting.cginc"
            
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

            sampler2D _MainTex;
            float4 _MainTex_ST;
        
            fixed4 _CelShadowColor;
            float _lightShadowThreshold;
            float _lightShadowFrontierWidth;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.worldPos = mul( unity_ObjectToWorld, v.vertex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
        ENDCG
        
        //TODO Outline pass
        
        
        
        // Cel shading forward pass (sun light)
        Pass
        {
            Tags { "RenderType"="Opaque" "LightMode" = "ForwardBase" }
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            
            fixed4 frag (v2f i) : SV_Target
            {
                // lecture de la texture d'albedo / couleur / diffuse
                fixed4 col = tex2D(_MainTex, i.uv);

                //TODO calcul de la lumière du soleil
   
                
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
            Tags { "LightMode" = "ForwardAdd" }
            Cull Back
            blend one one
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            
            fixed4 frag (v2f i) : SV_Target
            {
                // lecture de la texture d'albedo / couleur / diffuse
                fixed4 col = tex2D(_MainTex, i.uv);

                // calcul de la lumière du soleil
                float dotNL = dot(i.normal, normalize(_WorldSpaceLightPos0 - i.worldPos) );
                float lightShadowValue = smoothstep(_lightShadowThreshold - _lightShadowFrontierWidth,
                                                    _lightShadowThreshold + _lightShadowFrontierWidth,
                                                    dotNL);

                col.rgb *= lerp(0, 1.0, lightShadowValue) * _LightColor0;
                
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
        */
        
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
