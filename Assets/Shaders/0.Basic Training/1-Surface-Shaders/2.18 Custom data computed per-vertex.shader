
Shader"ShaderFromScarach/Surface/Basic Training/18 Custom data computed per-vertex"
{
	Properties
	{
		_MainColor("Main Color",Color)=(1,1,1,1)
		_MainTex("Main Texture",2D) = "black"{}
		_MainTexIntensity("Main Texture Intensity" ,Range(0.0,6.0)) = 1.0
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		struct Input
		{
			float2 uv_MainTex;
			float3 customColor;

		};
		
		sampler2D _MainTex;
		float _MainTexIntensity;

		void vert(inout appdata_full v,out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input , o);
			o.customColor = abs(v.normal);
		}

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb * _MainTexIntensity;
			o.Albedo *= i.customColor; 
		}

		ENDCG
	}
	Fallback "Diffuse"
}