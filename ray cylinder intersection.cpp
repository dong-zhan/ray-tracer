//r is the radius of the cylinder
//ro, rd is the ray
bool rayIntersectCylinderBody(CVector4D<>&ro, CVector4D<>&rd, CVector4D<>&p1, CVector4D<>&p2, float r, float& tnear, float&tfar)
{
	CVector4D<>dp = p2 - p1;		//axis of cylinder

	float dotDpDp = dp.dot(dp);

	float B = (ro.dot(dp) - p1.dot(dp)) / dotDpDp;
	float A = rd.dot(dp) / dotDpDp;

	CVector4D<> vB = B * dp;
	CVector4D<> vA = A * dp;

	vB = ro - p1 - vB;
	vA = rd - vA;

	//(vA*t + vB) * (vA*t + vB)) = r * r
	A = vA.dot(vA);
	B = 2 * vA.dot(vB);
	float C = vB.dot(vB) - r*r;

	float discriminant = B * B - 4 * A * C;
	const float epsilon = 0.0001f;
	if (discriminant < epsilon){
		return false;
	}else{
		float sqrtDisc = sqrt(discriminant);
		tnear = (-B - sqrtDisc) / (2 * A);
		tfar = (-B + sqrtDisc) / (2 * A);
		return true;
	}	
}
