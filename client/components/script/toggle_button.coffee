#########################################################
#
# Toggle Button
#
#########################################################

#########################################################
Template.toggle_button.onCreated ->
	this.id = "id_" + Random.id()

#########################################################
Template.toggle_button.helpers
	checked: () ->
		inst = Template.instance()
		context = inst.data

		if context.session
			value = Session.get context.session
			if context.key
				value = value[context.key]
		else if context.variable
			data = context.variable
			value = data.get()
		else if context.dictionary
			data = context.dictionary
			value = data.get context.key
		else if context.collection_name
			value = get_field_value context

		if value == 1
			return "checked"

		return ""

	id: () ->
		instance = Template.instance()
		return instance.id


#########################################################
Template.toggle_button.events
	"click .toggle-select": () ->
		inst = Template.instance()
		context = inst.data
		console.log "toggled", inst.id

		value = if inst.find("#"+inst.id).checked then 1 else 0

		if context.session
			if context.key
				dict = Session.get context.session
				dict[context.key] = value
				value = dict
			Session.set context.session, value
		else if context.variable
			variable = context.variable
			variable.set value
		else if inst.dictionary
			dict = inst.dictionary
			key = inst.data.key
			dict.set key, value
		else if context.collection_name
			cn = context.collection_name
			f = context.field
			id = context.item_id
			set_field cn, id, f, value

