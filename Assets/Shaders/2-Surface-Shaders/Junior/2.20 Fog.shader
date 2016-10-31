

Shader"ShaderFromScarach/Surface/2.20 Fog"
{
	Properties
	{
		_FogColor ("Fog Color", Color) = (0.3, 0.4, 0.7, 1.0)
		_MainTex("Main Texture",2D) = "black"{}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert finalcolor:final_color vertex:myvert

		struct Input
		{
			float2 uv_MainTex;
			half fog;

		};
		
		sampler2D _MainTex;
		fixed4 _FogColor;

		void myvert (inout appdata_full v, out Input data)
      	{
          	UNITY_INITIALIZE_OUTPUT(Input,data);
          	float4 hpos = mul (UNITY_MATRIX_MVP, v.vertex);
          	data.fog = min (1, dot (hpos.xy, hpos.xy) * 0.1);
      	}

		void final_color(Input i,SurfaceOutput o,inout fixed4 color)
		{
			 fixed3 fogColor = _FogColor.rgb;
	         #ifdef UNITY_PASS_FORWARDADD
	         fogColor = 0;
	         #endif
	         color.rgb = lerp (color.rgb, fogColor, i.fog);
		}

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}