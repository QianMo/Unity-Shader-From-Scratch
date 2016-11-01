Shader"ShaderFromScarach/Surface/Basic Training/7 Cubemap Reflection"
{
	Properties
	{
		_MainTex("Main Texture",2D) = "black"{}
		//_BumpTex("Bump Texture",2D) = "black"{}
		//_Detail("Detail",2D) = "gray"{} 
		//_RimColor("Rim Color",Color)=(0.3,0.0,0.3,1.0)
		//_RimPower("RimP Power",Range(0.0,100.0)) = 50.0
		_Cube ("Cubemap" , CUBE)=""{}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert 

		struct Input
		{
			float2 uv_MainTex;
			//float2 uv_BumpTex;
			//float2 uv_Detail;
			//float4 screenPos;//screenPos is a built-in variable
			float3 worldRefl;
			//float3 viewDir;
		};

		sampler2D _MainTex;
		samplerCUBE _Cube;
		// sampler2D _BumpTex;
		// sampler2D _Detail;
		// float4 _RimColor;
		// float _RimPower;

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb *0.5;
			o.Emission = texCUBE(_Cube , i.worldRefl).rgb;
			//o.Normal = UnpackNormal(tex2D(_BumpTex, i.uv_BumpTex));
			// float2 screenUV = i.screenPos.xy / i.screenPos.w;
			// screenUV *= float2(8,6);
			// o.Albedo *= tex2D(_Detail , screenUV).rgb * 2;
			// half rim= 1-saturate(dot(normalize(i.viewDir), o.Normal));		
			// o.Emission *= _RimColor.rgb * pow(rim, _RimPower);
		}

		ENDCG
	}
	Fallback "Diffuse"
}