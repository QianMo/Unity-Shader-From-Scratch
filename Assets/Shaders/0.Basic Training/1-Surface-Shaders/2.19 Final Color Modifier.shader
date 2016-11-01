

Shader"ShaderFromScarach/Surface/Basic Training/19 Final Color Modifier"
{
	Properties
	{
		_ColorTint ("Final Color", Color) = (1.0, 0.6, 0.6, 1.0)
		_MainTex("Main Textrue",2D) = "black"{}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert finalcolor:final_color

		struct Input
		{
			float2 uv_MainTex;
			float3 customColor;

		};
		
		sampler2D _MainTex;
		float4 _ColorTint;
		

		void final_color(Input i,SurfaceOutput o,inout fixed4 color)
		{
			color *=_ColorTint;
		}

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
			//o.Normal = UnpackNormal(tex2D(_BumpTex, i.uv_BumpTex)) * _BumpTexIntensity;
			//o.Emission = texCUBE(_Cube , WorldReflectionVector(i, o.Normal)).rgb * _CubeTexIntensity ;
			//o.Alpha = _MainColor.a;
			//float2 screenUV = i.screenPos.xy / i.screenPos.w;
			//screenUV *= float2(8,6);
			//o.Albedo *= tex2D(_Detail , screenUV).rgb * 2;
			// half rim= 1-saturate(dot(normalize(i.viewDir), o.Normal));		
			// o.Emission =o.Emission* 10*_RimColor.rgb * pow(rim, _RimPower);
		}

		ENDCG
	}
	Fallback "Diffuse"
}