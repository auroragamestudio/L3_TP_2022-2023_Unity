Shader "L3/SlopeSurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        //TODO ETAPE 1 : Ajouter une texture pour la couleur des faces orientées vers le haut, ou faces "up"     

        
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Threshold ("Threshold", Range(0,1)) = 0.8
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0
        
        sampler2D _MainTex;

        //TODO ETAPE 2 :Ajouter un sampler pour lire la texture de couleur des faces "up"  


        struct Input
        {
            float2 uv_MainTex;
            float3 worldNormal;
            float3 worldPos;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Seuil pour le calcul des faces orientées vers le haut
        half _Threshold;
                
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //TODO Etape 3 : ajouter le calcul d'un UV basé sur les coordonnées "world" X et Z des vertices

            //TODO Etape 4 : lire les deux textures de couleur puis utiliser la fonction lerp pour calculer la couleur
            //en fonction de l'orientation de la normale World
            
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
