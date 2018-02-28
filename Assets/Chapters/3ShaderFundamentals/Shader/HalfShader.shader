// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Half Shader" {
	Properties {
		_Tint ("TintColor", Color) = (0.5, 0.9 ,0.2, 1)
	}

	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"
			
			float4 _Tint;

			struct MyData {
				float4 position : SV_POSITION;
				float3 localPosition : TEXCOORD1;
				float2 uv : TEXCOORD0;
			};

			struct VertexData {
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			MyData MyVertexProgram (VertexData vertexData) {
				MyData data;
				data.localPosition = vertexData.position.xyz;
				data.position = UnityObjectToClipPos (vertexData.position);
				data.uv = vertexData.uv;

				return data;
			}

			float4 MyFragmentProgram (MyData data) : SV_TARGET {
				// if (data.uv.x > 0.3 && data.uv.x < 0.8) {
				// 	data.uv.x = 1;
				// }

				return float4 (data.uv, 1, 1);
			}

			ENDCG
		}
	}	
}