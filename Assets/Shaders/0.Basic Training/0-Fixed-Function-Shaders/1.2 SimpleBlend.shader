Shader"ShaderFromScarach/Fixed-Function/1.2 SimpleBlend"
{
	Properties
	{
		_MainTex("Main Texture",2D)="White"{}
	}
	
	SubShader
	{
		Pass
		{
			//Blend DstColor SrcColor
			//Blend SrcAlpha OneMinusSrcAlpha    // Alpha混合  
			//Blend One One                       // 相加  
			//Blend One OneMinusDstColor         // 比较柔和的相加（SoftAdditive）  
			Blend DstColor Zero                  // 乘法  
			Blend DstColor SrcColor              // 2倍乘法

			SetTexture[_MainTex]{combine texture}
		}
	}
	Fallback "Diffuse"
}