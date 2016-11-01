Shader"ShaderFromScarach/Surface/Basic Training/1.SimpleTexture"
{
	Properties
	{
		_MainTex("Main Texture",2D) ="black"
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert 

		struct Input
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex,i.uv_MainTex).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}