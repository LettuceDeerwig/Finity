extends Node2D
class_name c_ModifierHandler

enum TYPES {
		ADD, #Additive modifier
		MULT, #Multiplicative modifier
		SYSTEM_END	#Special-cased modifiers for system mechanics
					# that apply last and aren't exposed to the player
					# (e.g. depth scaling)
	}

var Modifiers : Array[Modifier]
var Multipliers : Array[Modifier] :
	get:
		return GetByType(TYPES.MULT)
var Adders : Array[Modifier] :
	get:
		return GetByType(TYPES.MULT)
var Systems : Array[Modifier] :
	get:
		return GetByType(TYPES.SYSTEM_END)

#inner class to define a modifier
class Modifier:
	var ID : int
	var Type : int
	var Value : float
	var Source : Node
	var Apply : Callable
	
	func _init(id: int, type : int, value : float, source : Node, apply = null):
		ID = id
		Type = type
		Value = value
		Source = source
		if apply != null && apply is Callable:
			Apply = apply
		else: match Type:
			TYPES.ADD:
				Apply = ApplyAdder
			_:
				Apply = ApplyMultiplier

	func ApplyAdder(baseValue : float) -> float:
		return baseValue + Value
		
	func ApplyMultiplier(baseValue : float) -> float:
		return baseValue * Value

#Applies all modifiers to value in definition order of types
func ApplyAll(baseValue : float) -> float:
	for mod in Adders:
		baseValue = mod.Apply.call(baseValue)
	for mod in Multipliers:
		baseValue = mod.Apply.call(baseValue)
	for mod in Systems:
		baseValue = mod.Apply.call(baseValue)
	return baseValue

func Add(type : int, value : float, source : Node, apply = null):
	var lastMod : Modifier = Modifiers.get(Modifiers.size() - 1) if Modifiers.size() > 0 else null
	var newModId : int = lastMod.ID + 1 if lastMod != null else 0
	Modifiers.append(Modifier.new(newModId, type, value, source, apply))

func GetByIndex(index : int) -> Modifier:
	return Modifiers[index]

func GetBySource(source : Node) -> Array[Modifier]:
	var mods : Array[Modifier]
	for mod : Modifier in Modifiers:
		if mod.Source == source:
			mods.append(mod)
	return mods
	
func GetById(id : int) -> Modifier:
	for mod in Modifiers:
		if mod.ID == id:
			return mod
	return null

func GetByType(type : int) -> Array[Modifier]:
	var mods : Array[Modifier]
	for mod : Modifier in Modifiers:
		if mod.Type == type:
			mods.append(mod)
	return mods

func UpdateBySource(value : float, source : Node):
	var mods : Array[Modifier] = GetBySource(source)
	for mod in mods:
		mod.Value = value

func Remove(source : Node):
	for i in Modifiers.size():
		if Modifiers[i].Source == source:
			Modifiers.remove_at(i)
