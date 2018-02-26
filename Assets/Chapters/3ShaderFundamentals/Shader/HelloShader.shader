// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Hello Shader" {
	Properties {
		_Tint ("TintColor", Color) = (0.5, 0.9 ,0.2, 1)
		_MainTex ("MainTex", 2D) = "white" {}
	}

	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"
			
			float4 _Tint;
			sampler2D _MainTex;
			float4 _MainTex_ST;

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
				// data.uv = vertexData.uv * _MainTex_ST.xy + _MainTex_ST.zw;
				data.uv = TRANSFORM_TEX (vertexData.uv, _MainTex);
				return data;
			}

			float4 MyFragmentProgram (MyData data) : SV_TARGET {
				// return float4 (data.localPosition + 0.5, 1) * _Tint;
				// return float4 (data.uv,1,1);
				return tex2D (_MainTex, data.uv) * _Tint;
			}

			ENDCG
		}
	}	
}