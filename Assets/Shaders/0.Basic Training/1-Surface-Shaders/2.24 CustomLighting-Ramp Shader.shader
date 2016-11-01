

Shader"ShaderFromScarach/Surface/Basic Training/24 CustomLighting-Ramp Shader"
{
	Properties
	{
		_MainTex("Main Texture",2D) = "black"{}
		_Ramp ("【渐变纹理】Shading Ramp", 2D) = "gray" {}  
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM

		#pragma surface surf Ramp

		//变量声明  
        sampler2D _Ramp;  
		sampler2D _MainTex;

		half4 LightingRamp (SurfaceOutput s, half3 lightDir, half atten)   
	    {  
            //点乘反射光线法线和光线方向  
            half NdotL = dot (s.Normal, lightDir);   
            //增强光强  
            half diff = NdotL * 0.5 + 0.5;  
            //从纹理中定义渐变效果  
            half3 ramp = tex2D (_Ramp, float2(diff,diff)).rgb;  
            //计算出最终结果  
            half4 color;  
            color.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten * 2);  
            color.a = s.Alpha;  
  
            return color;  
	    }  

		struct Input
		{
			float2 uv_MainTex;
		};
		
		

	
		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
		}

		ENDCG
	}
	Fallback "Diffuse"
}