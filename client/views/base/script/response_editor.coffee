########################################
# response
########################################

########################################
_get_index = () ->
	index = FlowRouter.getParam("index")
	if not index
		index = Session.get "current_page"

	return index


########################################
_get_template_id = () ->
	id = FlowRouter.getParam("template_id")
	if not id
		id = Session.get "current_template"

	return id

#######################################
#
# response dashboard
#
########################################

########################################
Template.response_dashboard.onCreated ->
	self = this
	self.autorun () ->
		filter =
			owner_id: Meteor.userId()
		name = Session.get "collection_name"
		self.subscribe "responses", name, filter, "response_dashboard"

########################################
Template.response_dashboard.helpers
	collection_name: () ->
		return Session.get "collection_name"

	response: () ->
		collection = get_collection Session.get "collection_name"
		if not collection
			return undefined

		id = FlowRouter.getParam("response_id")
		res = collection.findOne(id)
		return res

	responses: () ->
		collection = get_collection Session.get "collection_name"
		if not collection
			return undefined

		filter =
			parent_id: ""

		mod =
			sort:
				deleted: 1
				index: 1
				view_order: 1

		res = collection.find(filter, mod)
		if res.count() == 0
			return undefined

		return res

########################################
import { saveAs } from 'file-saver'


########################################
Template.response_dashboard.events
	"change #collection_name": (event) ->
		target = event.target
		value = target.options[target.selectedIndex].value;
		value = event.target.value
		Session.set "collection_name", value

	"click #export_responses": () ->
		Meteor.call "backup_responses",
			(err, res) ->
				if err
					sAlert.error(err)
				else
					blob = base64_to_blob res
					saveAs blob, "responses.zip"

	"click #add_response": () ->
		name = Session.get "collection_name"

		Meteor.call "add_response", name, {},
			(err, res) ->
				if err
					sAlert.error(err)
				else
					sAlert.info("response added")


########################################
# Response Item
########################################

########################################
Template.response_item.onCreated ->
	this.file_data = new ReactiveVar("")
	this.file_name = new ReactiveVar("")
	this.expanded = new ReactiveVar(false)

########################################
Template.response_item.helpers
	response_url: () ->
		return "/response/"+this._id

	has_children: (parent) ->
		filter =
			parent_id: parent._id

		collection = get_collection Session.get "collection_name"
		if not collection
			return false

		res = collection.find(filter).count()
		return res

	expanded: () ->
		return Template.instance().expanded.get()

	children: (parent) ->
		filter =
			parent_id: parent._id

		mod =
			sort:
				index:1

		collection = get_collection Session.get "collection_name"
		if not collection
			return []

		list = collection.find(filter, mod)
		return list

	name_or_title: () ->
		if this.name
			return this.name

		return this.title

	file_data: () ->
		return Template.instance().file_data.get()

	file_name: () ->
		return Template.instance().file_name.get()

########################################
Template.response_item.events
	"click #expand": (event) ->
		id = this._id
		ins = Template.instance()

		if ins.data._id != id
			return

		s = not ins.expanded.get()
		ins.expanded.set(s)

	"click #delete_response": () ->
		field = "deleted"
		collection_name = "Responses"
		value = get_field_value(this, field, this._id, collection_name)
		value = if value then false else true
		item_id = this._id

		Meteor.call "set_field", collection_name, item_id, field, value, undefined,
			(err, res) ->
				if err
					sAlert.error(err)
				if res
					sAlert.success("Updated: " + field)

	"click #add_response_with_parent": () ->
		name = Session.get "collection_name"
		param:
			parent_id: this._id
		Meteor.call "add_response", name, param,
			(err, res) ->
				if err
					sAlert.error(err)
				else
					sAlert.info("response added")


########################################
#
# Response editor
#
########################################

########################################
Template.response_editor.onCreated ->
	this.loaded_response = new ReactiveVar(false)

	self = this
	self.autorun () ->
		filter =
			_id: self.data._id

		name = Session.get "collection_name"
		self.subscribe "responses", name, filter, "response_editor",
			onReady: () ->
				self.loaded_response.set(true)

########################################
Template.response_editor.helpers
	template_id: ->
		return this.template_id

	data_loaded: () ->
		inst = Template.instance()
		done = inst.loaded_response.get()
		return done

	response: ->
		return this

#########################################################
# Edit tools
#########################################################

#########################################################
Template._edit_toggle.events
	'click #edit': () ->
		ed = Session.get("editing_response")

		if ed == this._id
			Session.set("editing_response", "")
			return

		Session.set("editing_response", this._id)


#########################################################
Template._edit_tools.helpers
	is_visible: (val) ->
		if val in this.visible_to
			return "selected"

	is_template: (val) ->
		if val == this.template
			return "selected"

	is_group: (val) ->
		if val == this.group
			return "selected"

	templates: () ->
		return [{value:"", label:"Select template"}
		{value:"empty", label:"Empty"}
		{value:"post", label:"Post"}
		{value:"headline", label:"Headline"}
		{value:"publication", label:"Publication"}
		{value:"team", label:"Team"}
		{value:"member", label:"Member"}
		{value:"partner", label:"Partner"}
		{value:"partner_list", label:"Partner List"}
		{value:"slide_deck", label:"Slide Deck"}
		{value:"slide_base", label:"Slide Base"}
		{value:"slide_content", label:"Slide Content"}
		{value:"slide_title", label:"Slide Title"}]

	parents: () ->
		filter = {}
		mod =
			fields:
				_id: 1
				title: 1

		collection = get_collection this.collection_name
		if not collection
			return []

		list = collection.find(filter, mod).fetch()
		groups = [{value:"", label:"Select a parent"}]
		groups.push ({value:x._id, label:x.title} for x in list)...

		return groups

