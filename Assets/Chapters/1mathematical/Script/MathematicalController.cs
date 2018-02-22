using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MathematicalController : MonoBehaviour {

	public int resolution = 40;
	public int range = 2; // -1 ~ 1
	float step;

	Transform[] points;

	// Use this for initialization
	void Start () {
		CreateNodes ();
	}

	// Update is called once per frame
	void Update () {
		for (int i = 0; i < points.Length; i++) {
			Vector3 position = points[i].position;
			position.y = RippleFunction (position.x, position.z, Time.time);
			points[i].position = position;
		}
	}

	void CreateNodes () {
		points = new Transform[resolution * resolution];
		step = 1.0f * range / resolution;

		Vector3 position = Vector3.zero;
		for (int z = 0, i = 0; z < resolution; z++) {
			position.z = (z + 0.5f) * step - 1;
			for (int x = 0; x < resolution; x++, i++) {
				position.x = (x + 0.5f) * step - 1;
				GameObject obj = GameObject.CreatePrimitive (PrimitiveType.Cube);
				obj.transform.position = position;
				obj.transform.localScale = Vector3.one * range / resolution;
				obj.transform.parent = this.transform;

				points[i] = obj.transform;
			}
		}
	}

	float Sin2DFunction (float x, float z, float t) {
		float y = Mathf.Sin (Mathf.PI * (x + t)) / 2;
		y += Mathf.Sin (Mathf.PI * (z + t)) / 2;

		return y;
	}

	static float MultiSine2DFunction (float x, float z, float t) {
		float y = 4f * Mathf.Sin (Mathf.PI * (x + z + t * 0.5f));
		y += Mathf.Sin (Mathf.PI * (x + t));
		y += Mathf.Sin (2f * Mathf.PI * (z + 2f * t)) * 0.5f;
		y *= 1f / 5.5f;
		return y;
	}

	static float RippleFunction (float x, float z, float t) {
		float d = Mathf.Sqrt (x * x + z * z);
		float y = Mathf.Sin (4 * Mathf.PI * (d + t)) / 2;

		y /= 1f + 10f * d;
		return y;
	}
}