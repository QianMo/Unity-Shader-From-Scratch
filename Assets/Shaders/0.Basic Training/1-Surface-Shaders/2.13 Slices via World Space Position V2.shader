//function frac() : Returns the fractional portion of a scalar or each vector component
//function clip() : conditionally kill a pixel before output	

Shader"ShaderFromScarach/Surface/Basic Training/13 Slices via World Space Position v2"
{
	Properties
	{
		_MainColor("Main Color",Color)=(1,1,1,1)
		_MainTex("Main Texture",2D) = "black"{}
		_MainTexIntensity("Main Texture Intensity" ,Range(0.0,6.0)) = 0.5
		_BumpTex("Bump Texture",2D) = "bump"{}
		_BumpTexIntensity("Bump Texture Intensity" ,Range(0.0,6.0)) = 0.5
		// _Detail("Detail",2D) = "gray"{} 
		// _Cube ("Cubemap" , CUBE)=""{}
		// _CubeTexIntensity("CubeMap Intensity" ,Range(0.0,1.6)) = 0.5
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert 

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float3 worldPos;
			// float2 uv_Detail;
			// float4 screenPos;//screenPos is a built-in variable
			// float3 worldRefl;
			// INTERNAL_DATA
		};

		float4 _MainColor;
		sampler2D _MainTex;
		// samplerCUBE _Cube;
		sampler2D _BumpTex;
		float _MainTexIntensity;
		float _BumpTexIntensity;
		// float _CubeTexIntensity;
		// float _DetailexIntensity;
		// sampler2D _Detail;

		void surf(Input i,inout SurfaceOutput o)
		{

			clip(frac((i.worldPos.y + i.worldPos.z * 0.1f) * 5) - 0.5);
			//clip (frac((i.worldPos.y+i.worldPos.z*0.1) * 5) - 0.5);
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb * _MainTexIntensity * _MainColor.rgb;
			//o.Albedo *= tex2D(_Detail, i.uv_Detail).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpTex, i.uv_BumpTex)) * _BumpTexIntensity;
			//o.Emission = texCUBE(_Cube , WorldReflectionVector(i, o.Normal)).rgb * _CubeTexIntensity ;
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