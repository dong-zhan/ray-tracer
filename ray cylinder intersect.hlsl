bool rayIntersectCylinderBody(float3 ro, float3 rd, float3 p1, float3 p2, float r, out float tnear, out float tfar)
{
	float3 dp = p2 - p1;		//axis of cylinder

	float dotDpDp = dot(dp, dp);

	float B = (dot(ro, dp) - dot(p1, dp)) / dotDpDp;
	float A = dot(rd, dp) / dotDpDp;

	float3 vB = B * dp;
	float3 vA = A * dp;

	vB = ro - p1 - vB;
	vA = rd - vA;

	//(vA*t + vB) * (vA*t + vB)) = r * r
	A = dot(vA, vA);
	B = 2 * dot(vA, vB);
	float C = dot(vB, vB) - r*r;

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
