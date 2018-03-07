###############################################
Meteor.methods	
    add_question: () ->
		user = Meteor.user()

		if not user
			throw new Meteor.Error('Not permitted.')

		return gen_question user

	add_answer: () ->
		user = Meteor.user()

		if not user
			throw new Meteor.Error('Not permitted.')

		return gen_answer user