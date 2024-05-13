#ifndef TOY_DIALECT_TD
#define TOY_DIALECT_TD

include "mlir/IR/OpBase.td"

def ToyDialect : Dialect {
  let name = "toy";
  let cppNamespace = "::mlir::toy";
  let summary = "Toy Dialect";
}

#endif  // TOY_DIALECT