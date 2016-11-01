Shader"ShaderFromScarach/Fixed-Function/1.1 SimpleTexture"
{
	Properties
	{
		_MainTex("Main Texture",2D)="White"{}
	}
	
	SubShader
	{
		Pass
		{
			SetTexture[_MainTex]{combine texture}
		}
	}
	Fallback "Diffuse"
}