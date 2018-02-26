using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformationGrid : MonoBehaviour {

	public Transform prefab;

	public int gridResolution;
	Transform[] grid;

	List<Transformation> transformation;
	Matrix4x4 Matrix;

	void Awake () {
		var cameraMatrix = Camera.main.projectionMatrix;
		Debug.LogError (cameraMatrix.GetRow (0).ToString ());
		Debug.LogError (cameraMatrix.GetRow (1).ToString ());
		Debug.LogError (cameraMatrix.GetRow (2).ToString ());
		Debug.LogError (cameraMatrix.GetRow (3).ToString ());

		transformation = new List<Transformation> ();
		grid = new Transform[gridResolution * gridResolution * gridResolution];

		for (int i = 0, x = 0; x < gridResolution; x++) {
			for (int y = 0; y < gridResolution; y++) {
				for (int z = 0; z < gridResolution; z++, i++) {
					grid[i] = CreateGridPoint (x, y, z);
				}
			}
		}
	}

	Transform CreateGridPoint (int x, int y, int z) {
		Transform point = GameObject.Instantiate<Transform> (prefab);
		point.parent = transform;
		point.localPosition = GetCoordinates (x, y, z);
		point.GetComponent<MeshRenderer> ().material.color = new Color ((float) x / gridResolution, (float) y / gridResolution, (float) z / gridResolution);
		return point;
	}

	Vector3 GetCoordinates (int x, int y, int z) {
		return new Vector3 (x - (gridResolution - 1) * 0.5f, y - (gridResolution - 1) * 0.5f, z - (gridResolution - 1) * 0.5f);
	}

	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {
		UpdateTransformation ();

		for (int i = 0, x = 0; x < gridResolution; x++) {
			for (int y = 0; y < gridResolution; y++) {
				for (int z = 0; z < gridResolution; z++, i++) {
					grid[i].localPosition = TransformPoint (x, y, z);
				}
			}
		}
	}

	void UpdateTransformation () {
		GetComponents<Transformation> (transformation);

		Matrix = transformation[0].Matrix;
		for (int i = 1; i < transformation.Count; i++) {
			Matrix = transformation[i].Matrix * Matrix;
		}
	}

	Vector3 TransformPoint (int x, int y, int z) {
		Vector3 point = GetCoordinates (x, y, z);

		return Matrix.MultiplyPoint (point);
	}

}