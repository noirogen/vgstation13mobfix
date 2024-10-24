/*
	File: Unary Operators
*/
/*
	Class: unary
	Represents a unary operator in the AST. Unary operators take a single operand (referred to as x below) and return a value.
*/
/datum/node/expression/operation/unary
	precedence = OOP_UNARY

/*
	Class: LogicalNot
	Returns !x.

	Example:
	!true = false and !false = true
*/
//
/datum/node/expression/operation/unary/LogicalNot
	name = "logical not"

/*
	Class: BitwiseNot
	Returns the value of a bitwise not operation performed on x.

	Example:
	~10 (decimal 2) = 01 (decimal 1).
*/
//
/datum/node/expression/operation/unary/BitwiseNot
	name = "bitwise not"

/*
	Class: Minus
	Returns -x.
*/
//
/datum/node/expression/operation/unary/Minus
	name = "minus"

/*
	Class: group
	A special unary operator representing a value in parentheses.
*/
//
/datum/node/expression/operation/unary/group
	precedence = OOP_GROUP

/datum/node/expression/operation/unary/New(var/datum/node/expression/exp)
	src.exp = exp
	return ..()
