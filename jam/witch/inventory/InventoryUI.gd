extends Control

onready var Items = preload("res://inventory/Items.gd")

var item_list
var quantity_list

var money_label
var potion_label

var recipe_list

var player
var inventory

var selected = [1000]

func _ready():
	player = get_node("../../Player")
	inventory = get_node("../../Player/Inventory")
	item_list = get_node("ItemList")
	quantity_list = $QuantityList
	money_label = get_node("MoneyPanel/MoneyLabel")
	potion_label = get_node("MoneyPanel/PotionLabel")
	recipe_list = get_node("RecipePanel/ScrollContainer/RecipeList")
	print("Inventory Test Ready")


func refresh_items():
	item_list.clear()
	quantity_list.clear()
	

	for item in inventory.playerCollectedItems:
		var item_inst = Items.getInstanceOfItemByItemName(item.name)
		item_list.add_item(item_inst.item_name, item_inst.texture)
		quantity_list.add_item(str(item.quantity), load("res://tiles/blank_16x16.png"))

	money_label.text = "Money: " + str(player.get_money())
	potion_label.text = "Potions Unlocked: %s/13" % str(player.potions_unlocked)
	
	handle_recipe_visibility()

func handle_recipe_visibility():
	if has_items([1,3]):
		recipe_list.get_node("PotionOfMinorStomachAches").visible = true
		recipe_list.get_node("PotionOfMinorStomachAchesSep").visible = true
	if has_items([0,2]):
		recipe_list.get_node("CrunchyNaturePotion").visible = true
		recipe_list.get_node("CrunchyNaturePotionSep").visible = true
	if has_items([50,51]):
		recipe_list.get_node("TastyHealthPotion").visible = true
		recipe_list.get_node("TastyHealthPotionSep").visible = true
	if has_items([0,3,4]):
		recipe_list.get_node("GreaterPotionOfMinorNarcolepsy").visible = true
		recipe_list.get_node("GreaterPotionOfMinorNarcolepsySep").visible = true
	if has_items([2,3,4]):
		recipe_list.get_node("WeakPotionOfGreaterEnergy").visible = true
		recipe_list.get_node("WeakPotionOfGreaterEnergySep").visible = true
	if has_items([3,4,52]):
		recipe_list.get_node("PotionOfAdvancedRevelry").visible = true
		recipe_list.get_node("PotionOfAdvancedRevelrySep").visible = true
	if has_items([1,4,50]):
		recipe_list.get_node("ScalyPotionOfEnhancedNausea").visible = true
		recipe_list.get_node("ScalyPotionOfEnhancedNauseaSep").visible = true
	if has_items([52,55]):
		recipe_list.get_node("PotionOfToadspeak").visible = true
		recipe_list.get_node("PotionOfToadspeakSep").visible = true
	if has_items([50,56,57]):
		recipe_list.get_node("PotionOfDelusionaryToadform").visible = true
		recipe_list.get_node("PotionOfDelusionaryToadformSep").visible = true
	if has_items([54,56,58]):
		recipe_list.get_node("PotionOfLifelongAnxiety").visible = true
		recipe_list.get_node("PotionOfLifelongAnxietySep").visible = true
	if has_items([53,59]):
		recipe_list.get_node("NightmareFuelConcoction").visible = true
		recipe_list.get_node("NightmareFuelConcoctionSep").visible = true
	if has_items([54,55]):
		recipe_list.get_node("PotionOfNeversleep").visible = true
		recipe_list.get_node("PotionOfNeversleepSep").visible = true
	if has_items([60,61]):
		recipe_list.get_node("PsychoticEpisodeInABottle").visible = true
		recipe_list.get_node("PsychoticEpisodeInABottle").visible = true

func has_items(item_ids):
	var collected_ids = get_collected_item_ids()
	
	for item_id in item_ids:
		if not collected_ids.has(item_id):
			return false
			
	return true

func get_collected_item_ids():
	var item_ids = []
	for item in inventory.playerCollectedItems:
		var item_inst = Items.getInstanceOfItemByItemName(item.name)
		item_ids.append(item_inst.id)
	return item_ids

func _physics_process(delta):
	var new_selected = item_list.get_selected_items()
	if(len(new_selected) > 0):
		if (new_selected[0] != selected[0]):
			selected = new_selected
			print(item_list.get_item_text(selected[0]))


func _on_ItemList_item_activated(index):
	var item = inventory.playerCollectedItems[index]
	if item.quantity > 0:
		var carried = player.get_node("CarriedItem")
		carried.set_current_item(item.name)
		carried.set_visibility(true)
		self.visible = false

