
Template.organization_quiz.onCreated ->
    buildQuiz: () ->
        # store HTML output
        output =
            this.output[]

        # for each question...
        myQuestions.forEach (currentQuestion, questionNumber) ->
        # we'll need a place to store the list of answer choices
            answers =
                this.answers[]
        
        # for each available answer
        for letter in currentQuestion.answers
        # add radion button for each 
            answers.push
            """
            <label>
            <input type="radio" name="question${questionNumber}" value="{letter}">
            #{letter} :
            #{currentQuestion.answers[letter]}
            </label>
            """
        

quizContainer = document.getElementById('quiz')
resultsContainer = document.getElementById('results')
submitButton = document.getElementById('submit')    

myQuestions = [
    {
      question: 'Who is the strongest?'
      answers:
        a: 'Superman'
        b: 'The Terminator'
        c: 'Waluigi, obviously'
      correctAnswer: 'c'
    }
    {
      question: 'What is the best site ever created?'
      answers:
        a: 'SitePoint'
        b: 'Simple Steps Code'
        c: 'Trick question; they\'re both the best'
      correctAnswer: 'c'
    }
    {
      question: 'Where is Waldo really?'
      answers:
        a: 'Antarctica'
        b: 'Exploring the Pacific Ocean'
        c: 'Sitting in a tree'
        d: 'Minding his own business, so stop asking'
      correctAnswer: 'd'
    }
  ]

buildQuiz = ->
    # we'll need a place to store the HTML output
    output = []
    # finally combine our output list into one string of HTML and put it on the page
    quizContainer.innerHTML = output.join('')
    return

showResults = ->
    # gather answer containers from our quiz
    answerContainers = quizContainer.querySelectorAll('.answers')
    # keep track of user's answers
    numCorrect = 0
    # for each question...
    return

buildQuiz()
    # on submit, show results
    submitButton.addEventListener 'click', showResults
    return
