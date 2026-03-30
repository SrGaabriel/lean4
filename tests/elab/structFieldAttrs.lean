-- Tests for attributes on structure fields.

import Lean

/-! ### Basic: @[reducible] on a field -/

structure Foo where
  @[reducible] x : Nat
  y : Bool

/-! ### Multiple attributes on a single field -/

structure Baz where
  @[reducible, inline] compute : Nat → Nat

/-! ### Attributes on class fields -/

class MyClass (α : Type) where
  @[reducible] default : α

/-! ### Attributes on fields with defaults -/

structure WithDefault where
  @[reducible] x : Nat := 42

/-! ### Custom tag attribute on a field -/

initialize testFieldTag : Lean.TagAttribute ←
  Lean.registerTagAttribute `testField "marks a projection for testing"

structure Tagged where
  @[testField] value : Nat

-- Verify the custom attribute was applied to the projection
#eval do
  let env ← Lean.getEnv
  guard (testFieldTag.hasTag env ``Tagged.value)
  return "ok"
