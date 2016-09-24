
##
# Static Utility CLass
#
# @author: George Ding (gd264@cornell.edu)
# @description: Util class for useful operations involving static data in League of Legends
##
class StaticUtil

	# Helper function for item_propagation
	def self.item_propagation_helper(item_list, item_id)
		recipe = ItemDependency.where(parent_item_id: item_id)
		if !recipe.any?
			return
		end
		recipe.each do |item|
			item_list.push(item.child_item_id)
			StaticUtil.item_propagation_helper(item_list, item.child_item_id)
		end
	end

	# Item propagation is the process of recursively generating all of the items that make up a
	# single item in its recipe. This will be used to back propagate champion-item counts for smaller
	# basic items that do not get counted that often in final builds.
	def self.item_propagation(item_id)
		recipe_list = []
		StaticUtil.item_propagation_helper(recipe_list, item_id)
		recipe_list
	end
end
