-- Tests for attributes on structure fields.

import Lean

/-! ### @[deprecated] on a field -/

structure Foo where
  @[deprecated] x : Nat
  y : Bool

/-! ### @[inline] on a field -/

structure Baz where
  @[inline] compute : Nat → Nat

/-! ### @[reducible] on a class field -/

class MyClass (α : Type) where
  @[reducible] default : α

/-! ### Field with default -/

structure WithDefault where
  @[deprecated] x : Nat := 42

/-! ### Verify attributes were applied to projections -/

#eval do
  let env ← Lean.getEnv
  unless Lean.Linter.isDeprecated env ``Foo.x do
    throw "Foo.x should be deprecated"
  unless Lean.Linter.isDeprecated env ``WithDefault.x do
    throw "WithDefault.x should be deprecated"
  return "ok"
