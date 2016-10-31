//unity built-in struct :
/*struct appdata_full 
{
	float4 vertex : POSITION;
	float4 tangent : TANGENT;
	float3 normal : NORMAL;
	float4 texcoord : TEXCOORD0;
	float4 texcoord1 : TEXCOORD1;
	fixed4 color : COLOR;
};*/

Shader"ShaderFromScarach/Surface/2.18 Custom data computed per-vertex"
{
	Properties
	{
		_MainColor("Main Color",Color)=(1,1,1,1)
		_Amount ("Extrusion Amount", Range(-1,1)) = 0.5
		_MainTex("Main Textrue",2D) = "black"{}
		_MainTexIntensity("Main Texture Intensity" ,Range(0.0,6.0)) = 1.0
		_BumpTex("Bump Texture",2D) = "bump"{}
		_BumpTexIntensity("Bump Texture Intensity" ,Range(0.0,6.0)) = 1.0
		_Detail("Detail",2D) = "gray"{} 
		_Cube ("Cubemap" , CUBE)=""{}
		_CubeTexIntensity("CubeMap Intensity" ,Range(0.0,1.6)) = 0.5
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
		float _Amount;
		float4 _MainColor;
		samplerCUBE _Cube;
		sampler2D _BumpTex;
		float _MainTexIntensity;
		float _BumpTexIntensity;
		float _CubeTexIntensity;
		float _DetailexIntensity;
		sampler2D _Detail;

		void vert(inout appdata_full v,out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input , o);
			o.customColor = abs(v.normal);
		}

		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb * _MainTexIntensity;
			o.Albedo *= i.customColor; 
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