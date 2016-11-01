

Shader"ShaderFromScarach/Surface/Basic Training/22 CustomLighting-Specular"
{
	Properties
	{
		_MainTex("Main Texture",2D) = "black"{}
	}

	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		#pragma surface surf SimpleSpecular

   		half4 LightingSimpleSpecular (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)   
   		{
	        half3 h = normalize (lightDir + viewDir);  
  
            half diff = max (0, dot (s.Normal, lightDir));  
  
            float nh = max (0, dot (s.Normal, h));  
            float spec = pow (nh, 48.0);  
  
            half4 c;  
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * (atten * 2);  
            c.a = s.Alpha;  
            return c;  
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