Journey 1: First-Time User Onboarding
1.1 App Launch & Welcome
Screen: Welcome/Splash

App logo and tagline
"Get Started" button
"I'm returning" link (for existing CloudKit users)

User Actions:

Taps "Get Started"
Views brief feature overview (3 slides max)

1.2 Account Setup
Screen: Basic Profile Creation

Name input field
Approximate handicap (optional, with "I don't know" option)
CloudKit account detection and sync setup

User Actions:

Enters name
Selects handicap range or skips
Grants CloudKit permission for data sync

1.3 Location Permission
Screen: Location Request

Explanation: "Find courses near you"
Visual showing course discovery benefit
Permission request trigger

User Actions:

Grants location permission (recommended)
Or skips (can add courses manually)

1.4 First Course Setup
Screen: Add Your Home Course

"Let's add your first course" message
Two options:

"Find nearby courses" (if location granted)
"Add course manually"



If location granted:

Shows list of nearby golf facilities (from Apple Maps)
User selects one from list

If manual entry:

Course name input
City/state input
Basic course info (par, total yardage)

1.5 Course Details Entry
Screen: Course Information

Course name (pre-filled if selected from maps)
Total par (default 72)
Total yardage (optional)
Number of holes (18 default, option for 9)
"I'll add hole details later" checkbox

User Actions:

Confirms basic course info
Chooses to add hole details now or later
Taps "Save Course"


Journey 2: Adding Detailed Course Information
2.1 Hole-by-Hole Entry (Optional during first setup)
Screen: Hole Details

Hole number navigation (1-18)
For each hole:

Par (3, 4, or 5)
Yardage from preferred tees
Handicap ranking (1-18, optional)



User Actions:

Swipes or taps through holes 1-18
Enters par and yardage for each
Can skip holes and return later
Saves when complete

2.2 Multiple Tee Setup (Advanced)
Screen: Tee Options

"Add different tee boxes?" prompt
Simple list: Front, Middle, Back tees
For each tee set:

Name (e.g., "Red Tees", "White Tees")
Course rating (optional, for handicap accuracy)
Slope rating (optional, for handicap accuracy)



User Actions:

Adds additional tee options
Enters ratings if known (can lookup later)
Sets default tee preference


Journey 3: Starting and Playing a Round
3.1 Quick Start from Home
Screen: Home Dashboard

Large "Start Round" button
Current handicap display (if established)
Recent courses list (last 2-3 played)
Quick stats: Last round score, rounds this month

User Actions:

Taps "Start Round"
Or selects recent course for quick start

3.2 Course Selection
Screen: Course Picker

"My Courses" list (user's saved courses)
Each course shows: Name, par, last played date
"Add New Course" button at bottom
Search bar (searches user's courses only)

User Actions:

Selects existing course
Or adds new course (goes to Journey 2)

3.3 Pre-Round Setup
Screen: Round Configuration

Selected course name at top
Tee selection (if multiple tees available)
Date/time (auto-filled with current)
Round type: Practice, Casual, or Tournament
"Add playing partners" (optional, just names)

User Actions:

Confirms tee selection
Adjusts date if needed
Adds playing partner names (optional)
Taps "Start Round"

3.4 Scorecard Interface
Screen: Active Scorecard

Current hole prominently displayed (large number)
Hole info: Par, yardage, handicap
Score entry: Large +/- buttons and number display
Running totals: Front 9, Back 9, Total
Score vs Par display
Navigation: Previous/Next hole buttons

Key Features:

Swipe left/right to change holes
Tap score number for direct entry
Visual indicators for birdies/bogeys (colors)
"Finish Hole" confirmation for large scores

User Actions:

Enters score for each hole
Navigates between holes
Views running totals
Continues through all 18 holes

3.5 Round Completion
Screen: Round Summary

Final score prominently displayed
Score breakdown: Front 9, Back 9, Total
Score vs Par
Basic stats: Pars, Birdies, Bogeys, Others
Handicap differential calculation (if course ratings available)
Notes field for round comments

User Actions:

Reviews final score
Adds round notes (optional)
Confirms and saves round
Options to share or start new round


Journey 4: Handicap Management (Simplified)
4.1 Viewing Current Handicap
Screen: Handicap Dashboard

Current handicap index (large display)
"How this is calculated" info button
Recent rounds used in calculation (last 8-20 rounds)
Simple trend: Improving/Stable/Increasing

User Actions:

Views current handicap
Taps info to understand calculation
Reviews recent rounds

4.2 Manual Handicap Calculation
Behind the scenes:

Uses standard USGA formula
Calculates differentials: (Score - Course Rating) × 113 / Slope Rating
Takes best 8 of last 20 rounds
Multiplies by 0.96
Updates after each round

User sees:

Simple handicap number
"Rounds needed for official handicap" counter
Basic explanation of how it works


Journey 5: Round History and Basic Stats
5.1 Round History View
Screen: My Rounds

Chronological list of all rounds
Each entry shows:

Date and course name
Final score and score vs par
Round type indicator


Search and filter options (by course, date range)

User Actions:

Scrolls through round history
Taps round for detailed view
Uses search to find specific rounds

5.2 Individual Round Details
Screen: Round Scorecard

Full hole-by-hole scorecard
Round information (date, course, partners)
Round notes
Statistics for that round
Options: Edit, Delete, Share

User Actions:

Reviews detailed scorecard
Edits scores if needed (with confirmation)
Shares round via iOS share sheet


Journey 6: Basic Course Management
6.1 Course List Management
Screen: My Courses

List of all saved courses
Each shows: Name, location, par, times played
Options: Edit, Delete, Set as Favorite
"Add New Course" button

User Actions:

Views all saved courses
Edits course information
Marks favorites for quick access
Deletes unused courses

6.2 Editing Course Information
Screen: Edit Course

All course details editable
Hole-by-hole information
Tee box options
Course ratings (if known)

User Actions:

Updates course information
Adds missing hole details
Corrects any errors
Saves changes


Journey 7: Simple Score Sharing
7.1 Share Round
Screen: iOS Share Sheet

Triggered from round summary or history
Formats scorecard as:

Text summary with key stats
Simple image of scorecard
Option to include course and date



User Actions:

Selects sharing method (Messages, Mail, etc.)
Customizes message
Sends to friends or social media