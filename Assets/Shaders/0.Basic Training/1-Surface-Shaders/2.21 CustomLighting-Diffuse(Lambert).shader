

Shader"ShaderFromScarach/Surface/Basic Training/21 CustomLighting-Diffuse"
{
	Properties
	{
		_MainTex("Main Texture",2D) = "black"{}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf SimpleLambert

   		half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) 
   		{
	        half NdotL = dot (s.Normal, lightDir);
	        half4 c;
	        c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
	        c.a = s.Alpha;
	        return c;
        }

		struct Input
		{
			float2 uv_MainTex;
		};
		
		sampler2D _MainTex;

	
		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}