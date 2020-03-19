Shader "Hidden/PaletteScreenShader"
{
	Properties
	{
		[PerRendererData] _MainTex("Base (RGB)", 2D) = "white" {}

		_ColorCount("Color Count", Int) = 4

		_Intensity("Intensity", Range(0, 1)) = 1
		_Threshold("Threshold", Range(0, 1)) = 0.2
	}

		SubShader
		{
			Pass
			{
				CGPROGRAM

				#pragma exclude_renderers flash
				#pragma vertex vert_img
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest

				#include "UnityCG.cginc"

				uniform sampler2D _MainTex;

				uniform int _ColorCount;
				uniform fixed4 _Colors[256];
				uniform half _Intensity;
				uniform float _Threshold;

				fixed4 frag(v2f_img i) : COLOR
				{
					fixed4 c = tex2D(_MainTex, i.uv);

					fixed ct = c.rgb;

					for (int i = 0; i < _ColorCount; i++)
					{
						fixed cc = distance(c, _Colors[i]);

						c.rgb = lerp(c.rgb, (ct > cc - _Threshold && ct < cc + _Threshold) ? _Colors[i].rgb : c.rgb, _Intensity);
					}

					return c;
				}

			ENDCG

			}
		}
}
