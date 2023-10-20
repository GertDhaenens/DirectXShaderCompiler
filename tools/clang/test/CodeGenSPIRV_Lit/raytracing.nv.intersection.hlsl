// RUN: %dxc -T lib_6_3 -fspv-extension=SPV_NV_ray_tracing -fcgl  %s -spirv | FileCheck %s
// CHECK:  OpCapability RayTracingNV
// CHECK:  OpExtension "SPV_NV_ray_tracing"
// CHECK:  OpDecorate [[a:%[0-9]+]] BuiltIn LaunchIdNV
// CHECK:  OpDecorate [[b:%[0-9]+]] BuiltIn LaunchSizeNV
// CHECK:  OpDecorate [[c:%[0-9]+]] BuiltIn WorldRayOriginNV
// CHECK:  OpDecorate [[d:%[0-9]+]] BuiltIn WorldRayDirectionNV
// CHECK:  OpDecorate [[e:%[0-9]+]] BuiltIn RayTminNV
// CHECK:  OpDecorate [[f:%[0-9]+]] BuiltIn IncomingRayFlagsNV
// CHECK:  OpDecorate %gl_InstanceID BuiltIn InstanceId
// CHECK:  OpDecorate [[g:%[0-9]+]] BuiltIn InstanceCustomIndexNV
// CHECK:  OpDecorate %gl_PrimitiveID BuiltIn PrimitiveId
// CHECK:  OpDecorate [[h:%[0-9]+]] BuiltIn ObjectRayOriginNV
// CHECK:  OpDecorate [[i:%[0-9]+]] BuiltIn ObjectRayDirectionNV
// CHECK:  OpDecorate [[j:%[0-9]+]] BuiltIn ObjectToWorldNV
// CHECK:  OpDecorate [[k:%[0-9]+]] BuiltIn WorldToObjectNV

struct Attribute
{
  float2 bary;
};

[shader("intersection")]
void main() {

// CHECK:  OpLoad %v3uint [[a]]
  uint3 _1 = DispatchRaysIndex();
// CHECK:  OpLoad %v3uint [[b]]
  uint3 _2 = DispatchRaysDimensions();
// CHECK:  OpLoad %v3float [[c]]
  float3 _3 = WorldRayOrigin();
// CHECK:  OpLoad %v3float [[d]]
  float3 _4 = WorldRayDirection();
// CHECK:  OpLoad %float [[e]]
  float _5 = RayTMin();
// CHECK:  OpLoad %uint [[f]]
  uint _6 = RayFlags();
// CHECK:  OpLoad %uint %gl_InstanceID
  uint _7 = InstanceIndex();
// CHECK:  OpLoad %uint [[g]]
  uint _8 = InstanceID();
// CHECK:  OpLoad %uint %gl_PrimitiveID
  uint _9 = PrimitiveIndex();
// CHECK:  OpLoad %v3float [[h]]
  float3 _10 = ObjectRayOrigin();
// CHECK:  OpLoad %v3float [[i]]
  float3 _11 = ObjectRayDirection();
// CHECK: [[matotw:%[0-9]+]] = OpLoad %mat4v3float [[j]]
// CHECK-NEXT: OpTranspose %mat3v4float [[matotw]]
  float3x4 _12 = ObjectToWorld3x4();
// CHECK:  OpLoad %mat4v3float [[j]]
  float4x3 _13 = ObjectToWorld4x3();
// CHECK: [[matwto:%[0-9]+]] = OpLoad %mat4v3float [[k]]
// CHECK-NEXT: OpTranspose %mat3v4float [[matwto]]
  float3x4 _14 = WorldToObject3x4();
// CHECK:  OpLoad %mat4v3float [[k]]
  float4x3 _15 = WorldToObject4x3();

  Attribute myHitAttribute = { float2(0.0f,0.0f) };
// CHECK: OpReportIntersectionKHR %bool %float_0 %uint_0
  ReportHit(0.0f, 0U, myHitAttribute);
}
