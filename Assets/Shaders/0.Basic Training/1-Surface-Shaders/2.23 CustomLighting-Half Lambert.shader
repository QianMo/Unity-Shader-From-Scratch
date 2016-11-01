

Shader"ShaderFromScarach/Surface/Basic Training/23 CustomLighting-Half Lambert"
{
	Properties
	{
		_MainTex("Main Texture",2D) = "black"{}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf HalfLambert

		half4 LightingHalfLambert (SurfaceOutput s, half3 lightDir, half atten)   
	    {  
	        half NdotL =max(0, dot (s.Normal, lightDir));  
	  
	        //在兰伯特光照的基础上加上这句，增加光强  
	        float hLambert = NdotL * 0.5 + 0.5;    
	        half4 color;  
	  
	        //修改这句中的相关参数  
	        color.rgb = s.Albedo * _LightColor0.rgb * (hLambert * atten * 2);  
	        color.a = s.Alpha;  
	        return color;  
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