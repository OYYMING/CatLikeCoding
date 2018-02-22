using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformationGrid : MonoBehaviour {

	public Transform prefab;

	public int gridResolution;
	Transform[] grid;

	void Awake () {
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

	}

}