Shader"ShaderFromScarach/Surface/Basic Training/3 Rim Lighting with Detail Texture"
{
	Properties
	{
		_MainTex("Main Texture",2D) ="black"{}
		_BumpTex("Bump Texture",2D)="black"{}
		_RimColor("Rim Color",Color)=(0.3,0.0,0.3,1.0)
		_RimPower("RimP Power",Range(0.0,10.0)) = 3.0
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert 

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float3 viewDir;
		};

		sampler2D _MainTex;
		sampler2D _BumpTex;
		float4 _RimColor;
		float _RimPower;

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpTex, i.uv_BumpTex));
			half rim= 1-saturate(dot(normalize(i.viewDir), o.Normal));
			o.Emission= _RimColor.rgb * pow(rim, _RimPower);
		}

		ENDCG
	}
	Fallback "Diffuse"
}