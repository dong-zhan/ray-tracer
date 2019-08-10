//p: ray o
//v: ray dir
//pa: cone apex
//va: cone dir
//sina2: sin(half apex angle) squared
//cosa2 : cos(half apex angle) squared
bool intersectInfiniteCone(float3 p, float3 v, float3 pa, float3 va, float sina2, float cosa2, out float tnear, out float tfar)
{
	float3 dp = p - pa;
	float vva = dot(v, va);
	float dpva = dot(dp, va);
	
	float3 v_vvava = v - vva * va;
	float3 dpvava = dp - dot(dp, va) * va;

	float A = cosa2 * dot(v_vvava, v_vvava) - sina2 * vva * vva;
	float B = 2 * cosa2 * dot(v_vvava, dpvava) - 2 * sina2 * vva * dpva;
	float C = cosa2 * dot(dpvava, dpvava) - sina2 * dpva * dpva;

	float disc = B*B - 4 * A*C;
	if (disc < 0.0001)return false;

	float sqrtDisc = sqrt( disc );
	tnear = (-B - sqrtDisc ) / (2*A);
	tfar = (-B + sqrtDisc ) / (2*A);
	return true;
}
