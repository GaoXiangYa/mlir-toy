#ifndef TOY_OPS
#define TOY_OPS

include "mlir/IR/OpBase.td"
include "toy/ToyDialect.td"
include "mlir/Interfaces/SideEffectInterfaces.td"


class ToyOp<string mnemonic, list<Trait> traits = []> : 
  Op<ToyDialect, mnemonic, traits>;

def ConstantOp : ToyOp<"constant"> {
  let summary = "constant operation";
  let description = [{
    Constant operation turns a literal into an SSA value. The data is attached
    to the operation as an attribute. For example:

      %0 = "toy.constant"()
         { value = dense<[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]> : tensor<2x3xf64> }
        : () -> tensor<2x3xf64>
  }];
  let arguments = (ins F64ElementsAttr:$value);
  let results = (outs F64Tensor);
  let hasVerifier = 1;

  let builders = [
    OpBuilder<(ins "::mlir::DenseElementsAttr": $value), [{
      build($_builder, $_state, value.getType(), value);
    }]>,
  OpBuilder<(ins "double":$value)>
  ];
}

def PrintOp : ToyOp<"print"> {
  let arguments = (ins F64Tensor:$input);
  let hasCustomAssemblyFormat = 1;
}
#endif // TOY_OPS