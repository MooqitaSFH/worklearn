// Server Methods For The Questions Collection

Meteor.methods({
    add_question: question => {
        var user = Meteor.user()

        if(!user) {
            throw new Meteor.Error('Not permitted.')
        }

        try {
            for(field in question) {
                if(field === null) {
                    throw new Meteor.Error('Invalid field.')
                }
            }

            inserted_correctly = Questions.insert({
                question: question.question,
                answer_one: question.answer_one,
                answer_two: question.answer_two,
                answer_three: question.answer_three,
                answer_four: question.answer_four,
                correct_answer: question.correct_answer,
                subject: question.subject,
                published: true
            })
        } catch(error) {
            throw new Meteor.Error('Unable to submit.')
        }

        return true
    },

    get_questions: () => {
        var raw_questions = Questions.find().fetch()
        var questions = []

        for(let i = 0; i < raw_questions.length; i++) {
            if(!raw_questions[i]['published'] != true) {
                questions.push({
                    id: raw_questions[i]['_id'],
                    question: raw_questions[i]['question'],
                    answer_one: raw_questions[i]['answer_one'],
                    answer_two: raw_questions[i]['answer_two'],
                    answer_three: raw_questions[i]['answer_three'],
                    answer_four: raw_questions[i]['answer_four'],
                    correct_answer: raw_questions[i]['correct_answer'],
                    subject: raw_questions[i]['subject'],
                    published: raw_questions[i]['published'],
                })
            }
        }

        return questions
    },

    get_cobol_questions: () => {
        var raw_questions = Questions.find().fetch()
        var questions = []

        for(let i = 0; i < raw_questions.length; i++) {
            if(raw_questions[i]['published'] == true && raw_questions[i]['subject'] == 'cobol') {
                questions.push({
                    id: raw_questions[i]['_id'],
                    question: raw_questions[i]['question'],
                    answer_one: raw_questions[i]['answer_one'],
                    answer_two: raw_questions[i]['answer_two'],
                    answer_three: raw_questions[i]['answer_three'],
                    answer_four: raw_questions[i]['answer_four'],
                    correct_answer: raw_questions[i]['correct_answer'],
                    subject: raw_questions[i]['subject']
                })
            }
        }

        return questions
    },

    get_comp_thinking_questions: () => {
        var raw_questions = Questions.find().fetch()
        var questions = []

        for(let i = 0; i < raw_questions.length; i++) {
            if(raw_questions[i]['published'] == true && raw_questions[i]['subject'] == 'comp_thinking') {
                questions.push({
                    id: raw_questions[i]['_id'],
                    question: raw_questions[i]['question'],
                    answer_one: raw_questions[i]['answer_one'],
                    answer_two: raw_questions[i]['answer_two'],
                    answer_three: raw_questions[i]['answer_three'],
                    answer_four: raw_questions[i]['answer_four'],
                    correct_answer: raw_questions[i]['correct_answer'],
                    subject: raw_questions[i]['subject']
                })
            }
        }

        return questions
    },

    get_python_questions: () => {
        var raw_questions = Questions.find().fetch()
        var questions = []

        for(let i = 0; i < raw_questions.length; i++) {
            if(raw_questions[i]['published'] == true && raw_questions[i]['subject'] == 'python') {
                questions.push({
                    id: raw_questions[i]['_id'],
                    question: raw_questions[i]['question'],
                    answer_one: raw_questions[i]['answer_one'],
                    answer_two: raw_questions[i]['answer_two'],
                    answer_three: raw_questions[i]['answer_three'],
                    answer_four: raw_questions[i]['answer_four'],
                    correct_answer: raw_questions[i]['correct_answer'],
                    subject: raw_questions[i]['subject']
                })
            }
        }

        return questions
    },

    set_cobol_score: score => {
        var user = Meteor.user()
        var profile = Profiles.findOne({user_id: user._id})

        if(profile.cobol_quiz_score != undefined) {
            return false
        }

        if(profile.my_balance != undefined) {
            new_balance = profile.my_balance

        var score_float = parseFloat(score)

        if(score_float >= 70.00) {
            modify_field_unprotected(Profiles, profile._id, 'cobol_course_progress', 100)
            new_balance += score_float
            modify_field_unprotected(Profiles, profile._id, 'my_balance', new_balance)
        } else {
            modify_field_unprotected(Profiles, profile._id, 'cobol_course_progress', 0)
        }
        modify_field_unprotected(Profiles, profile._id, 'cobol_quiz_score', parseFloat(score))
    },

    set_comp_thinking_score: score => {
        var user = Meteor.user()
        var profile = Profiles.findOne({user_id: user._id})

        if(profile.comp_thinking_quiz_score != undefined) {
            false
        }
        
        if(profile.my_balance != undefined) {
            new_balance = profile.my_balance
        }

        var score_float = parseFloat(score)

        if(score_float >= 70.00) {
            modify_field_unprotected(Profiles, profile._id, 'comp_thinking_course_progress', 100)
            new_balance += score_float
            modify_field_unprotected(Profiles, profile._id, 'my_balance', new_balance)
        } else {
            modify_field_unprotected(Profiles, profile._id, 'comp_thinking_course_progress', 0)
        }
        modify_field_unprotected(Profiles, profile._id, 'comp_thinking_quiz_score', parseFloat(score))
    },

    set_python_score: score => {
        var user = Meteor.user()
        var profile = Profiles.findOne({user_id: user._id})

        if(profile.python_quiz_score != undefined) {
            return false
        }

        if(profile.my_balance != undefined) {
            new_balance = profile.my_balance
        }

        var score_float = parseFloat(score)

        if(score_float >= 70.00) {
            modify_field_unprotected(Profiles, profile._id, 'python_course_progress', 100)
            new_balance += score_float
            modify_field_unprotected(Profiles, profile._id, 'my_balance', new_balance)
        } else {
            modify_field_unprotected(Profiles, profile._id, 'python_course_progress', 0)
        }

        modify_field_unprotected(Profiles, profile._id, 'python_quiz_score', parseFloat(score))
    }
})