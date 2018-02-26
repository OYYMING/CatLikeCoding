// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Textured With Detail" {
	Properties {
		_Tint ("TintColor", Color) = (0.5, 0.9 ,0.2, 1)
		_MainTex ("MainTex", 2D) = "white" {}
		_DetailTex ("DetailTex", 2D) = "gray" {}
	}

	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"
			
			float4 _Tint;
			sampler2D _MainTex,_DetailTex;
			float4 _MainTex_ST,_DetailTex_ST;

			struct MyData {
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvDetail : TEXCOORD1;
			};

			struct VertexData {
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			MyData MyVertexProgram (VertexData vertexData) {
				MyData data;
				data.position = UnityObjectToClipPos (vertexData.position);

				data.uv = TRANSFORM_TEX (vertexData.uv, _MainTex);
				data.uvDetail = TRANSFORM_TEX (vertexData.uv, _DetailTex);

				return data;
			}

			float4 MyFragmentProgram (MyData data) : SV_TARGET {
				float4 color = tex2D (_MainTex, data.uv) * _Tint;
				color *= tex2D (_DetailTex, data.uvDetail) * 2;
				return color;
			}

			ENDCG
		}
	}	
}