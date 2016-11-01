Shader"ShaderFromScarach/Surface/Basic Training/2.SimpleTexture"
{
	Properties
	{
		_MainTex("Main Texture",2D) ="black"{}
		_BumpTex("Bump Texture",2D)="black"{}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert 

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpTex;
		};

		sampler2D _MainTex;
		sampler2D _BumpTex;

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex,i.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpTex,i.uv_BumpTex));
		}

		ENDCG
	}
	Fallback "Diffuse"
}