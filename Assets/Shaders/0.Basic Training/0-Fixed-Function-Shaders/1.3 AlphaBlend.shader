

Shader"ShaderFromScarach/Fixed-Function/1.3 AlphaBlend"
{
	Properties
	{
		_MainTex("Main Texture",2D)="White"{}
		_BlendTex ("Blend Texture", 2D) = "white" {}  
	}
	
	SubShader
	{
		Pass
		{
            SetTexture [_MainTex] { combine texture }  
            SetTexture [_BlendTex] {combine texture * previous}  
		}
	}
	Fallback "Diffuse"
}