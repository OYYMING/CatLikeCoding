// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/The First Light Shader" {
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

			struct VertexData {
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct FragmentData {
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : TEXCOORD1;
			};

			FragmentData MyVertexProgram (VertexData vertexData) {
				FragmentData data;
				data.position = UnityObjectToClipPos (vertexData.position);
				data.uv = TRANSFORM_TEX (vertexData.uv, _MainTex);
				data.normal = mul(unity_ObjectToWorld, float4(vertexData.normal,0));
				// data.normal = normalize (data.normal);
				return data;
			}

			float4 MyFragmentProgram (FragmentData data) : SV_TARGET {
				return float4 (data.normal * 0.5 + 0.5, 1);
			}

			ENDCG
		}
	}	
}