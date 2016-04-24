open Core.Std

open Synthesis_common

open Hypothesis
open Infer

val default_cost_model : CostModel.t

module L2_Generalizer : sig
  module type S = sig
    val generalize : CostModel.t -> Generalizer.t
    val generate_constants : CostModel.t -> Generalizer.t
    val generate_identifiers : CostModel.t -> Generalizer.t
    val generate_expressions : CostModel.t -> Generalizer.t
    val generate_lambdas : CostModel.t -> Generalizer.t
    val generate_combinators : CostModel.t -> Generalizer.t
  end

  module Symbols : sig
    val lambda : Symbol.t
    val combinator : Symbol.t
    val expression : Symbol.t
    val constant : Symbol.t
    val identifier : Symbol.t
    val base_case : Symbol.t
  end
  
  module With_components : S
  module No_components : S
  module No_lambdas : S
end

module L2_Synthesizer : sig
  type t
    
  val create : ?cost_model:CostModel.t -> Deduction.t -> t
    
  val synthesize :
    ?max_cost:int
    -> t
    -> Hypothesis.t
    -> Hypothesis.t Option.t Or_error.t
      
  val initial_hypothesis : t -> Example.t list -> Hypothesis.t
end
