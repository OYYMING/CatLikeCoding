﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionTransformation : Transformation {

	public Vector3 offset;

	public override Matrix4x4 Matrix {
		get {
			Matrix4x4 matrix = new Matrix4x4 ();
			matrix.SetRow (0, new Vector4 (1, 0, 0, offset.x));
			matrix.SetRow (1, new Vector4 (0, 1, 0, offset.y));
			matrix.SetRow (2, new Vector4 (0, 0, 1, offset.z));
			matrix.SetRow (3, new Vector4 (0, 0, 0, 1));

			return matrix;
		}
	}
}