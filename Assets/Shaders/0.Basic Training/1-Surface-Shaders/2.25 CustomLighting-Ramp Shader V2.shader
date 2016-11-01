

Shader"ShaderFromScarach/Surface/Basic Training/25 CustomLighting-Ramp Shader V2"
{
	Properties
	{
		_MainTex("Main Texture",2D) = "black"{}
		_Ramp ("【渐变纹理】Shading Ramp", 2D) = "gray" {}  
		_BumpMap ("【凹凸纹理】Bumpmap", 2D) = "bump" {}    
        _Detail ("【细节纹理】Detail", 2D) = "gray" {}    
        _RimColor ("【边缘颜色】Rim Color", Color) = (0.26,0.19,0.16,0.0)    
        _RimPower ("【边缘颜色强度】Rim Power", Range(0.5,8.0)) = 3.0    
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM

		#pragma surface surf CartoonShader


		//变量声明 
        sampler2D _MainTex;    
        sampler2D _Ramp;    
        sampler2D _BumpMap;    
        sampler2D _Detail;    
        float4 _RimColor;    
        float _RimPower;    

		half4 LightingCartoonShader(SurfaceOutput s, fixed3 lightDir, fixed atten) 
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
			//主纹理的uv值    
            float2 uv_MainTex;    
            //凹凸纹理的uv值    
            float2 uv_BumpMap;    
            //细节纹理的uv值    
            float2 uv_Detail;     
            //当前坐标的视角方向    
            float3 viewDir;    
		};
		
		void surf(Input i,inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, i.uv_MainTex).rgb;
            //设置细节纹理    
            o.Albedo *= tex2D (_Detail, i.uv_Detail).rgb * 2;     
            //从凹凸纹理获取法线值    
            o.Normal = UnpackNormal (tex2D (_BumpMap, i.uv_BumpMap));    
            //从_RimColor参数获取自发光颜色    
            half rim = 1.0 - saturate(dot (normalize(i.viewDir), o.Normal));    
            o.Emission = _RimColor.rgb * pow (rim, _RimPower);  
		}

		ENDCG
	}
	Fallback "Diffuse"
}