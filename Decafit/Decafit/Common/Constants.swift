//
//  Constants.swift
//  Decafit
//
//  Created by Decagon on 03/08/2022.
//

import Foundation

enum Constants {
    static let emailHolder = "Email address"
    static let pswHolder = "Password"
    static let fullname = "Full name"
    static let phone = "Phone number"
    static let confirmPsw = "Confirm password"
    static let signIn = "Sign In"
    static let signUp = "Sign up"
    static let next = "Next"

    static let run = "Run"
    static let close = "Close"
    static let loginHeadertext = "Track \n your fitness"
    static let createPlan = "Create a \nfitness/nutrition plan"
    static let noAccounttext = "Don't have an account? "
    static let signinWith = " Or sign in with "
    static let yesAccount = "Already have an account? "
    static let limit = "Set your limit"
    static let inputvcSubt = "Enter the number of reps and sets for your workout"
    static let sets = "Number of sets"
    static let reps = "Number of reps"
    static let time = "Estimated time"
    static let count = "Number of counts"
    
    static let googleImg = "google-logo"
    static let fbImg = "fb-img"
    static let appleImg = "apple-img"
    static let fitnessImg = "fitness-img"
    static let signupImg = "signup-img"
    static let calenderImg = "calender"
    static let profileImg = "profile"
    static let backArrow = "back-arrow"
    static let weightImg = "weightlift"
    static let clockImg = "clock"
    static let flameImg = "flame.fill"
    static let playImg = "play"
    static let playFillSystemImg = "play.fill"
    static let pauseImg = "pause.fill"

    static let requiredInit = "init(coder:) has not been implemented"
    static let goodMorning = "Good Morning"
    static let todayCellId = "TodayCell"
    static let workoutCellId = "StartWorkoutCell"
    static let exerciseCellId = "ExerciseCell"
    static let workoutModalTopSwipeCell = "WorkoutModalTopSwipeCell"
    static let exerciseLabelText = "This Exercise"
    static let workoutDurationLabelText = "X10"
    static let bodyFocusAreaText = "First"
    static let focusDurationLabelText = "Second"
    static let focusAreaViewTitleText = "Other Focus Areas"
    static let todaySessionViewTitleText = "Today's session"
    static let todayFirstLabelText = "First"
    static let todaySecondLabelText = "Counts"
    static let todayThirdLabelTextAfterIcon = " 24 min"
    static let todayFourthLabelTextAfterIcon = " 24 Kcal"
    
    static let alertTitleError = "Error!"
    static let networkError = "Network Error"
    static let passwordMismatchError = "Passwords do not match!"
    static let blankTextFieldError = "All fields are required!"
    static let incorrectInputError = "Incorrect input"
    
    
    static let loginText = "login5"
    
    
    static let overlayIdentifier = "overlay"
    static let removeShadow = "hidesShadow"
    
    static let exerciseTimerButtonText = "Next Workout"
    static let completeText = "complete"
    static let incompleteText = "incomplete"
    static let continueWorkout = "Continue Workout"
    static let resume = " Resume"
    static let pause = " Pause"
    static let loremText = modalText()
    static let urlStr = "https://decagon-decafit-api.herokuapp.com/decafit"
}
func modalText() -> String {
    let text1 = "Lorem ipsum dolor sit amet, consetetur elitr, sed diam nonumy eirmod tempor invidunt labore etLorem ipsum dolor sit amet, consetetur elitr, sed diam nonumy eirmod tempor"
    let text2 = "dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, sea takimata sanctus est Lorem ipsum dolor "
    let text3 = "Lorem ipsum dolor sit amet, consetetur elitr, sed diam nonumy eirmod tempor invidunt labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo"
    let text = text1 + text2 + text3
    return text
}
