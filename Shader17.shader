﻿Shader "Custom/Shader17"
{
    Properties
    {
		_Diffuse("Diffuse", Color) = (1,1,1,1)
		_Specular("Specular", Color) = (1,1,1,1)




    }
    SubShader
    {
 
		Tags{"LightMode"= "ForwardBase"}

			Pass
		{
			CGPROGRAM
#pragma vertex vert   
#pragma fragment frag
#include "UnityCG.cginc"
#include "Lighting.cginc"




		struct v2f
		{
			fixed4 vertex : SV_POSITION;
			fixed3 normal : NORMAL;

		};

	struct a2f
	{

		fixed4 vertex : POSITION;
		fixed3 normal : NORMAL;

	};




	fixed4 _Diffuse;
	fixed4 _Specular;



				v2f vert(a2f a)
				{

					v2f o;
					o.vertex = UnityObjectToClipPos(a.vertex);
					
					o.normal = UnityObjectToWorldNormal(a.normal);

					return o;
				}



			fixed4 frag(v2f v): SV_Target
			{
				fixed3 normal = normalize(v.normal);
				fixed3 lightDir = normalize(_WorldSpaceLightPos0.rgb);


				fixed3 NDotL = dot(lightDir,normal);





				fixed3 diffuse =_LightColor0.rgb *NDotL * _Diffuse ;
	

				fixed3 halfDiffuse = (diffuse * 0.5) + 0.5;

				fixed3 reflectLight = reflect(-lightDir, normal);

				fixed3 specular = _Specular.rgb * reflectLight;

				fixed3 finalColor = halfDiffuse + specular;

				return fixed4(finalColor,1.0);

			}

			ENDCG

		}

    }
    FallBack "Diffuse"
}
