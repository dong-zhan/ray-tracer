//coordinates conversion: 3d world pos on a unit sphere to planar coordinate
float2 sphericalToPlanar(float3 nPos)	//normalized pos
{
	float2 tex = float2(atan2(nPos.z, nPos.x), nPos.y);
	tex.x /= PI;
	tex += float2(1,1);
	tex *= 0.5;
	//TODO: should y be 1-y?, most cases not necessary.
	return tex;
}

//convert 3d cartesian coordiantes on a plane to planar coordinates
float2 coord3dTo2D(float3 ip, float3 orig, float3 right, float3 normal)
{
	float3 dir = ip - orig;
	float len = sqrt(dot(dir,dir));
		
	float3 c = cross(dir, right);
	float d = dot(c, normal);
	
	dir /= len;  		//normalize
	
	float cosA = dot(dir, right);		//cos(angle) between (ip, plane origin) and plane right vector
	float angle = acos(cosA);
	
	if(d<0){
		angle = PI2 - angle;
	}
	
	float sinA = sin(angle);					
	
	float2 tex = float2(cosA, sinA);
	tex *= len;
	
	return tex;
}
