#######################################################
Meteor.publish 'git_challenges', (parameter) ->
	pattern =
		query: Match.Optional(String)
		page: Number
		size: Number
	check parameter, pattern

	self = this

#	secret = Secrets.findOne()
#	config =
#		consumerKey: secret.upwork.oauth.consumerKey
#		consumerSecret: secret.upwork.oauth.consumerSecret

#	UpworkApi = require('upwork-api')
#	Search = require('upwork-api/lib/routers/jobs/search.js').Search

#	api = new UpworkApi(config)
#	jobs = new Search(api)
#	params =
#		q: q
#		paging: paging
#		budget: budget
#		job_type: 'fixed'
#	accessToken = secret.upwork.oauth.accessToken
#	accessTokenSecret = secret.upwork.oauth.accessSecret

#	api.setAccessToken accessToken, accessTokenSecret, () ->

#	remote = (error, data) ->
#		if error
#			console.log(error)
#		else
#			for d in data.jobs
#				if Tasks.findOne(d.id)
#					continue
#				d.snippet = d.snippet.split('\n').join('<br>')
#				self.added('tasks', d.id, d)

#	bound = Meteor.bindEnvironment(remote)
#	jobs.find params, bound
#	HTTP.call('GET', 'https://api.github.com/search/issues?q=web+agile+language:ruby+type:issue+is:public+archived:false+state:open&per_page=10&page=1&sort=updated&order=desc',
	if parameter.query.length > 3
		HTTP.call('GET', 'https://api.github.com/search/issues?q=test',
			headers:
				'User-Agent': "Meteor/1.6.1",
		 	query: parameter.query
			params:
				per_page: 10
				page: 1
				sort: "updated"
				order: "desc",
			(error, response) ->
				if error
					console.log(error)
				else
					#console.log(response)
					if response.data and response.data.items.length > 0
						for item in response.data.items
							item.description = item.body.toString()
							if item.description.length > 250
								item.description = item.description.slice(0,249) + "\r\n[...]"
							self.added('git_challenges',item.id,item))


	#self.added('git_challenges', 1, {title: "Connection to database works!"})
	self.ready()

