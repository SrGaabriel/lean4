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
  guard (Lean.Linter.isDeprecated env ``Foo.x)
  guard (Lean.Linter.isDeprecated env ``WithDefault.x)
  return "ok"
