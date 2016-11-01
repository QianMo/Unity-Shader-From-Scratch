#Surface Shader Writing

Writing shaders that interact with lighting is complex. There are different light types, different shadow options, different rendering paths (forward and deferred rendering), and the shader should somehow handle all that complexity.

Surface Shaders in Unity is a code generation approach that makes it much easier to write lit shaders than using low level vertex/pixel shader programs. Note that there are no custom languages, magic or ninjas involved in Surface Shaders; it just generates all the repetitive code that would have to be written by hand. You still write shader code in Cg / HLSL.

You define a “surface function” that takes any UVs or data you need as input, and fills in output structure SurfaceOutput. SurfaceOutput basically describes properties of the surface (it’s albedo color, normal, emission, specularity etc.). You write this code in Cg / HLSL.

Surface Shader compiler then figures out what inputs are needed, what outputs are filled and so on, and generates actual vertex&pixel shaders, as well as rendering passes to handle forward and deferred rendering.

Standard output structure of surface shaders is this:

    struct SurfaceOutput
	{
    	fixed3 Albedo;  // diffuse color
    	fixed3 Normal;  // tangent space normal, if written
    	fixed3 Emission;
    	half Specular;  // specular power in 0..1 range
    	fixed Gloss;    // specular intensity
    	fixed Alpha;    // alpha for transparencies
	};

In Unity 5, surface shaders can also use physically based lighting models. Built-in Standard and StandardSpecular lighting models (see below) use these output structures respectively:

	struct SurfaceOutputStandard
	{
	    fixed3 Albedo;      // base (diffuse or specular) color
	    fixed3 Normal;      // tangent space normal, if written
	    half3 Emission;
	    half Metallic;      // 0=non-metal, 1=metal
	    half Smoothness;    // 0=rough, 1=smooth
	    half Occlusion;     // occlusion (default 1)
	    fixed Alpha;        // alpha for transparencies
	};

or

	struct SurfaceOutputStandardSpecular
	{
	    fixed3 Albedo;      // diffuse color
	    fixed3 Specular;    // specular color
	    fixed3 Normal;      // tangent space normal, if written
	    half3 Emission;
	    half Smoothness;    // 0=rough, 1=smooth
	    half Occlusion;     // occlusion (default 1)
	    fixed Alpha;        // alpha for transparencies
	};


#Reference
[https://docs.unity3d.com/Manual/SL-SurfaceShaders.html](https://docs.unity3d.com/Manual/SL-SurfaceShaders.html)
