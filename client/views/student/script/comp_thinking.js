Template.comp_thinking_course.onRendered(() => {
	Meteor.call('get_course_progress', (err, res) => {
		Session.set('cobol_course_progress', res.cobol_course_progress)
		Session.set('comp_thinking_course_progress', res.comp_thinking_course_progress)
		Session.set('python_course_progress', res.python_course_progress)
	})

	Meteor.call('get_comp_thinking_modules', (err, res) => {
		Session.set('comp_thinking_modules', res)
	})
})

Template.comp_thinking_course.helpers({
	'is_module_completed': index => {
		var comp_thinking_course_progress = Session.get('comp_thinking_course_progress')
		var comp_thinking_modules = Session.get('comp_thinking_modules')
		var num_comp_thinking_modules = comp_thinking_modules.length
		var resume_progress = (comp_thinking_course_progress / (100 / num_comp_thinking_modules))
		var return_val = false

		if(index < resume_progress) {
			return_val = true
		}

		return return_val
	},

	'is_module_disabled': index => {
		var comp_thinking_course_progress = Session.get('comp_thinking_course_progress')
		var comp_thinking_modules = Session.get('comp_thinking_modules')
		var num_comp_thinking_modules = comp_thinking_modules.length
		var resume_progress = (comp_thinking_course_progress / (100 / num_comp_thinking_modules))
		var return_val = false

		if(index > resume_progress || (index > 0 && comp_thinking_course_progress == undefined)) {
			return_val = true
		}

		return return_val
	},

	'comp_thinking_modules': () => {
		return Session.get('comp_thinking_modules')
	},

	'comp_thinking_course_progress': () => {
		return Session.get('comp_thinking_course_progress')
	},

    'comp_thinking_module_back': index => {
		return index - 1
    },

    'comp_thinking_module_next': index => {
        return index + 1
    },

	'comp_thinking_module_resume': () => {
		var comp_thinking_course_progress = Session.get('comp_thinking_course_progress')
		var comp_thinking_modules = Session.get('comp_thinking_modules')
		var num_comp_thinking_modules = comp_thinking_modules.length
		var resume_progress = 0

		if(comp_thinking_course_progress != undefined) {
			resume_progress = (comp_thinking_course_progress / (100 / num_comp_thinking_modules))
		}

		return resume_progress
	},

	'comp_thinking_module_resume_title': () => {
		var comp_thinking_course_progress = Session.get('comp_thinking_course_progress')
		var comp_thinking_modules = Session.get('comp_thinking_modules')
		var num_python_modules = python_modules.length
		var resume_progress = 0

		if(comp_thinking_course_progress != undefined) {
			resume_progress = (comp_thinking_course_progress / (100 / num_comp_thinking_modules))
		}

		if(comp_thinking_modules[resume_progress].title == undefined) {
			return false
		}

		return comp_thinking_modules[resume_progress].title
	}
})

Template.comp_thinking_course.events({
	'click .comp_thinking_module_next': event => {
		var comp_thinking_modules = Session.get('comp_thinking_modules')
		var num_comp_thinking_modules = comp_thinking_modules.length

		Meteor.call('update_comp_thinking_course_progress', event.toElement.value, num_comp_thinking_modules)

		Meteor.call('get_course_progress', (err, res) => {
			Session.set('cobol_course_progress', res.cobol_course_progress)
			Session.set('comp_thinking_course_progress', res.comp_thinking_course_progress)
			Session.set('python_course_progress', res.python_course_progress)
		})
	}
})