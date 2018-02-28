// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Texture Splatting" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		[NoScaleOffset]_Texture1 ("Texture1", 2D) = "white" {}
		[NoScaleOffset]_Texture2 ("Texture2", 2D) = "white" {}
	}

	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"
			
			sampler2D _MainTex,_Texture1,_Texture2;
			float4 _MainTex_ST;

			struct VertexData {
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct FragmentData {
				float4 position : SV_POSITION;
				float2 uv1 : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
			};

			FragmentData MyVertexProgram (VertexData vertexData) {
				FragmentData fragmentData;
				fragmentData.position = UnityObjectToClipPos (vertexData.position);
				fragmentData.uv1 = vertexData.uv;
				fragmentData.uv2 = TRANSFORM_TEX (vertexData.uv, _MainTex);

				return fragmentData;
			}

			float4 MyFragmentProgram (FragmentData data) : SV_TARGET {
				float value = tex2D (_MainTex, data.uv1).w;
				if (value == 0) {
					return tex2D (_Texture1, data.uv2);
				} else if (value == 1) {
					return tex2D (_Texture2, data.uv2);
				} else {
					return tex2D (_Texture1, data.uv2) * value + tex2D (_Texture2, data.uv2) * (1 - value);
				}
			}

			ENDCG
		}
	}	
}