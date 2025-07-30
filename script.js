// Greensheet Golf App - JavaScript for iOS Prototype

// Global state management
let currentScreen = 'welcome-screen';
let currentSlide = 1;
let currentHole = 1;
let currentScore = 4;
let navigationHistory = ['welcome-screen']; // Track navigation history
let roundData = {
    course: '',
    date: '',
    scores: {},
    totalScore: 0,
    frontNine: 0,
    backNine: 0
};

// Screen navigation functions
function showScreen(screenId) {
    // Add to navigation history
    if (screenId !== currentScreen) {
        navigationHistory.push(screenId);
    }
    
    // Hide all screens
    document.querySelectorAll('.screen').forEach(screen => {
        screen.classList.remove('active');
    });
    
    // Show target screen
    const targetScreen = document.getElementById(screenId);
    if (targetScreen) {
        targetScreen.classList.add('active');
        currentScreen = screenId;
        
        // Add animation
        targetScreen.classList.add('fade-in');
        setTimeout(() => {
            targetScreen.classList.remove('fade-in');
        }, 300);
        
        // Update tab bar active states
        updateTabBarActiveState(screenId);
    }
}

// Update tab bar active states
function updateTabBarActiveState(screenId) {
    // Remove active class from all tab items
    document.querySelectorAll('.tab-item').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Add active class to appropriate tab based on screen
    const tabMapping = {
        'home-dashboard': 0,
        'round-history': 1,
        'handicap-dashboard': 2,
        'course-management': 3
    };
    
    if (tabMapping.hasOwnProperty(screenId)) {
        const tabIndex = tabMapping[screenId];
        const tabItems = document.querySelectorAll('.tab-item');
        if (tabItems[tabIndex]) {
            tabItems[tabIndex].classList.add('active');
        }
    }
}

// Global back button functionality
function goBack() {
    if (navigationHistory.length > 1) {
        navigationHistory.pop(); // Remove current screen
        const previousScreen = navigationHistory[navigationHistory.length - 1];
        showScreen(previousScreen);
    } else {
        // If no history, go to home dashboard
        showScreen('home-dashboard');
    }
}

// Journey 1: First-Time User Onboarding

function showFeatureOverview() {
    showScreen('feature-overview');
}

function showReturningUser() {
    // For prototype, just go to home dashboard
    showScreen('home-dashboard');
}

function goToSlide(slideNumber) {
    // Hide all slides
    document.querySelectorAll('.overview-slide').forEach(slide => {
        slide.classList.remove('active');
    });
    
    // Remove active from all dots
    document.querySelectorAll('.dot').forEach(dot => {
        dot.classList.remove('active');
    });
    
    // Show target slide
    const targetSlide = document.querySelector(`[data-slide="${slideNumber}"]`);
    if (targetSlide) {
        targetSlide.classList.add('active');
    }
    
    // Activate corresponding dot
    const targetDot = document.querySelector(`.dot:nth-child(${slideNumber})`);
    if (targetDot) {
        targetDot.classList.add('active');
    }
    
    currentSlide = slideNumber;
}

function showAccountSetup() {
    showScreen('account-setup');
}

function showLocationPermission() {
    showScreen('location-permission');
}

function grantLocationPermission() {
    // Simulate location permission granted
    showFirstCourseSetup();
}

function skipLocationPermission() {
    showFirstCourseSetup();
}

function showFirstCourseSetup() {
    showScreen('first-course-setup');
}

function findNearbyCourses() {
    showScreen('nearby-courses');
}

function addCourseManually() {
    // Clear any existing form data
    document.getElementById('course-name').value = '';
    document.getElementById('course-par').value = '72';
    document.getElementById('course-yardage').value = '';
    document.getElementById('course-holes').value = '18';
    document.getElementById('add-holes-later').checked = false;
    
    showScreen('course-details');
}

function selectCourse(courseName) {
    // Pre-fill course name in course details
    document.getElementById('course-name').value = courseName;
    // Reset other form fields to defaults
    document.getElementById('course-par').value = '72';
    document.getElementById('course-yardage').value = '';
    document.getElementById('course-holes').value = '18';
    document.getElementById('add-holes-later').checked = false;
    
    showScreen('course-details');
}

function saveCourse() {
    const courseName = document.getElementById('course-name').value;
    const coursePar = document.getElementById('course-par').value;
    const addHolesLaterCheckbox = document.getElementById('add-holes-later');
    const addHolesLater = addHolesLaterCheckbox ? addHolesLaterCheckbox.checked : false;
    
    console.log('saveCourse function called');
    console.log('Course name:', courseName);
    console.log('Course par:', coursePar);
    console.log('Add holes later checkbox found:', !!addHolesLaterCheckbox);
    console.log('Add holes later checked:', addHolesLater);
    
    if (!courseName) {
        alert('Please enter a course name');
        return;
    }
    
    // Save course data (in real app, this would be stored)
    console.log(`Course saved: ${courseName}, Par ${coursePar}, Add holes later: ${addHolesLater}`);
    
    if (addHolesLater) {
        console.log('Going to home dashboard (skipping hole details)');
        // Skip hole details and go to home dashboard
        showScreen('home-dashboard');
    } else {
        console.log('Going to hole details entry');
        // Go to hole details entry
        showScreen('hole-details');
    }
}

// Journey 2: Adding Detailed Course Information

function showHoleDetails() {
    showScreen('hole-details');
    updateHoleDisplay();
}

function updateHoleDisplay() {
    document.querySelector('.current-hole').textContent = `Hole ${currentHole}`;
    document.querySelector('.header h2').textContent = `Hole ${currentHole}`;
}

function previousHole() {
    if (currentScreen === 'scorecard') {
        // Scorecard navigation
        if (currentHole > 1) {
            currentHole--;
            updateScorecardDisplay();
            updateScorecardHoleInfo();
        }
    } else {
        // Course setup navigation
        if (currentHole > 1) {
            currentHole--;
            updateHoleDisplay();
        }
    }
}

function nextHole() {
    if (currentScreen === 'scorecard') {
        // Scorecard navigation
        const maxHoles = roundData.holes || 18;
        if (currentHole < maxHoles) {
            currentHole++;
            updateScorecardDisplay();
            updateScorecardHoleInfo();
        } else {
            // Round complete
            showRoundSummary();
        }
    } else {
        // Course setup navigation
        if (currentHole < 18) {
            currentHole++;
            updateHoleDisplay();
        }
    }
}

function skipHole() {
    if (currentHole < 18) {
        nextHole();
    } else {
        showTeeSetup();
    }
}

function saveHole() {
    const holePar = document.getElementById('hole-par').value;
    const holeYardage = document.getElementById('hole-yardage').value;
    const holeHandicap = document.getElementById('hole-handicap').value;
    
    // Save hole data (in real app, this would be stored)
    console.log(`Hole ${currentHole}: Par ${holePar}, Yardage ${holeYardage}, Handicap ${holeHandicap}`);
    
    if (currentHole < 18) {
        nextHole();
    } else {
        showTeeSetup();
    }
}

function showTeeSetup() {
    showScreen('tee-setup');
}

function editTee(teeType) {
    // In real app, this would open tee editing modal
    console.log(`Editing ${teeType} tees`);
}

function addNewTee() {
    // In real app, this would open add tee modal
    console.log('Adding new tee option');
}

function finishCourseSetup() {
    // In real app, this would save the course setup
    console.log('Course setup completed');
    showScreen('home-dashboard');
}

// Journey 3: Starting and Playing a Round

function showHomeDashboard() {
    showScreen('home-dashboard');
}

function showSettings() {
    // In real app, this would show settings screen
    console.log('Settings clicked');
}

function showCourseSelection() {
    showScreen('course-selection');
}

function quickStartRound(courseName) {
    roundData.course = courseName;
    showPreRoundSetup();
}

function selectCourseForRound(courseName) {
    roundData.course = courseName;
    showPreRoundSetup();
}

function showPreRoundSetup() {
    showScreen('pre-round-setup');
    
    // Pre-fill current date/time
    const now = new Date();
    const dateTimeString = now.toISOString().slice(0, 16);
    document.getElementById('round-date').value = dateTimeString;
    
    // Set default active states
    selectHoles(18);
    selectTeeOption('white');
    selectStartingHole(1);
}

function startRound() {
    const teeSelection = roundData.selectedTee || 'white';
    const activeHolesTab = document.querySelector('.holes-tab.active');
    const holesSelection = activeHolesTab ? parseInt(activeHolesTab.dataset.holes) : 18;
    const roundDate = document.getElementById('round-date').value;
    const roundType = roundData.roundType || 'stroke';
    const players = roundData.players || [];
    
    roundData.teeSelection = teeSelection;
    roundData.holes = holesSelection;
    roundData.date = roundDate;
    roundData.type = roundType;
    roundData.players = players;
    
    currentHole = 1;
    showScorecard();
    updateScorecardHoleInfo();
}

function selectHoles(holes) {
    // Remove active class from all tabs
    document.querySelectorAll('.holes-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // Add active class to clicked tab
    const clickedTab = document.querySelector(`[data-holes="${holes}"]`);
    if (clickedTab) {
        clickedTab.classList.add('active');
    }
}

function showTeeActionSheet() {
    const actionSheet = document.getElementById('tee-action-sheet');
    if (actionSheet) {
        actionSheet.classList.add('active');
    }
}

function closeTeeActionSheet() {
    const actionSheet = document.getElementById('tee-action-sheet');
    if (actionSheet) {
        actionSheet.classList.remove('active');
    }
}

function selectTeeOption(tee) {
    // Update header display
    const header = document.querySelector('.selected-option');
    const teeColor = header.querySelector('.tee-color');
    const teeText = header.querySelector('.tee-text');
    
    // Update color class
    teeColor.className = `tee-color ${tee}`;
    
    // Update text
    const teeLabels = {
        'red': 'Red Tees',
        'gold': 'Gold Tees',
        'white': 'White Tees',
        'blue': 'Blue Tees',
        'black': 'Black Tees'
    };
    teeText.textContent = teeLabels[tee];
    
    // Store the selected tee
    roundData.selectedTee = tee;
    
    // Close action sheet
    closeTeeActionSheet();
}

function showRoundTypeActionSheet() {
    const actionSheet = document.getElementById('round-type-action-sheet');
    if (actionSheet) {
        actionSheet.classList.add('active');
    }
}

function closeRoundTypeActionSheet() {
    const actionSheet = document.getElementById('round-type-action-sheet');
    if (actionSheet) {
        actionSheet.classList.remove('active');
    }
}

function selectRoundType(type) {
    // Update the round type selector display
    const roundTypeText = document.querySelector('.round-type-text');
    if (roundTypeText) {
        const typeLabels = {
            'stroke': 'Stroke Play',
            'match': 'Match Play'
        };
        roundTypeText.textContent = typeLabels[type];
    }
    
    // Store the selected round type
    roundData.roundType = type;
    
    // Close the action sheet
    closeRoundTypeActionSheet();
}

// Player management functions
function showAddPlayerActionSheet() {
    console.log('showAddPlayerActionSheet called');
    const actionSheet = document.getElementById('add-player-action-sheet');
    console.log('actionSheet element:', actionSheet);
    if (actionSheet) {
        actionSheet.classList.add('active');
        console.log('Action sheet activated');
        // Clear previous input
        const nameInput = document.getElementById('player-name-input');
        const handicapInput = document.getElementById('player-handicap-input');
        if (nameInput) {
            nameInput.value = '';
            // Add keyboard event listener
            nameInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    addPlayer();
                }
            });
        }
        if (handicapInput) {
            handicapInput.value = '';
            // Add keyboard event listener
            handicapInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    addPlayer();
                }
            });
        }
    } else {
        console.log('Action sheet not found');
    }
}

function closeAddPlayerActionSheet() {
    const actionSheet = document.getElementById('add-player-action-sheet');
    if (actionSheet) {
        actionSheet.classList.remove('active');
    }
}

function addPlayer() {
    console.log('addPlayer called');
    const nameInput = document.getElementById('player-name-input');
    const handicapInput = document.getElementById('player-handicap-input');
    
    if (!nameInput || !handicapInput) {
        console.log('Input elements not found');
        return;
    }
    
    const playerName = nameInput.value.trim();
    const playerHandicap = handicapInput.value.trim();
    
    console.log('Player name:', playerName);
    console.log('Player handicap:', playerHandicap);
    
    if (!playerName) {
        alert('Please enter a player name');
        return;
    }
    
    // Add player to roundData
    if (!roundData.players) {
        roundData.players = [];
    }
    
    const player = {
        name: playerName,
        handicap: playerHandicap || null
    };
    
    roundData.players.push(player);
    console.log('Player added:', player);
    console.log('All players:', roundData.players);
    
    // Update the display
    updatePlayersDisplay();
    
    // Close action sheet
    closeAddPlayerActionSheet();
}

function removePlayer(playerIndex) {
    if (roundData.players && roundData.players[playerIndex]) {
        roundData.players.splice(playerIndex, 1);
        updatePlayersDisplay();
    }
}

function updatePlayersDisplay() {
    console.log('updatePlayersDisplay called');
    const container = document.getElementById('players-container');
    if (!container) {
        console.log('Players container not found');
        return;
    }
    
    console.log('Container found, clearing content');
    container.innerHTML = '';
    
    if (roundData.players && roundData.players.length > 0) {
        console.log('Updating display for', roundData.players.length, 'players');
        roundData.players.forEach((player, index) => {
            const playerElement = document.createElement('div');
            playerElement.className = 'player-item';
            
            const handicapText = player.handicap ? `Handicap: ${player.handicap}` : '';
            
            playerElement.innerHTML = `
                <div class="player-info">
                    <div class="player-name">${player.name}</div>
                    ${handicapText ? `<div class="player-handicap">${handicapText}</div>` : ''}
                </div>
                <button class="remove-player-btn" onclick="removePlayer(${index})">×</button>
            `;
            
            container.appendChild(playerElement);
            console.log('Player element added:', player.name);
        });
    } else {
        console.log('No players to display');
    }
}

function showStartingHoleActionSheet() {
    console.log('showStartingHoleActionSheet called');
    const actionSheet = document.getElementById('starting-hole-action-sheet');
    console.log('actionSheet element:', actionSheet);
    if (actionSheet) {
        actionSheet.classList.add('active');
        console.log('Action sheet activated');
    } else {
        console.log('Action sheet not found');
    }
}

function closeStartingHoleActionSheet() {
    const actionSheet = document.getElementById('starting-hole-action-sheet');
    if (actionSheet) {
        actionSheet.classList.remove('active');
    }
}

function selectStartingHole(hole) {
    // Update selected hole in action sheet
    document.querySelectorAll('.hole-option').forEach(option => {
        option.classList.remove('active');
    });
    
    const selectedOption = document.querySelector(`[data-hole="${hole}"]`);
    if (selectedOption) {
        selectedOption.classList.add('active');
    }
    
    // Update the starting hole selector display
    const startingHoleText = document.querySelector('.starting-hole-text');
    if (startingHoleText) {
        startingHoleText.textContent = `Starting Hole ${hole}`;
    }
    
    // Store the selected starting hole
    roundData.startingHole = hole;
    
    // Close the action sheet
    closeStartingHoleActionSheet();
}



function showScorecard() {
    showScreen('scorecard');
    updateScorecardDisplay();
    updateHoleInputDisplay();
    updateScorecardHoleInfo();
    
    // Update running totals display based on number of holes
    updateRunningTotalsDisplay();
}

function updateScorecardHoleInfo() {
    const holeNumberElement = document.querySelector('#scorecard .hole-number-compact');
    const holeParElement = document.querySelector('#scorecard .hole-par-compact');
    const holeYardageElement = document.querySelector('#scorecard .hole-yardage-compact span');
    const teeDotElement = document.querySelector('#scorecard .tee-dot');
    
    if (!holeNumberElement || !holeParElement || !holeYardageElement || !teeDotElement) {
        return;
    }
    
    // Update hole number
    holeNumberElement.textContent = currentHole || 1;
    
    // Update par based on hole (this would come from course data)
    const holePars = {
        1: 4, 2: 5, 3: 4, 4: 3, 5: 4, 6: 3, 7: 4, 8: 5, 9: 4,
        10: 4, 11: 4, 12: 3, 13: 5, 14: 4, 15: 5, 16: 3, 17: 4, 18: 4
    };
    const par = holePars[currentHole] || 4;
    holeParElement.textContent = `PAR ${par}`;
    
    // Update yardage based on selected tees
    const teeYardages = {
        'red': { 1: 280, 2: 520, 3: 380, 4: 150, 5: 360, 6: 140, 7: 380, 8: 480, 9: 360,
                10: 360, 11: 380, 12: 130, 13: 480, 14: 360, 15: 480, 16: 130, 17: 360, 18: 360 },
        'gold': { 1: 300, 2: 540, 3: 400, 4: 160, 5: 380, 6: 150, 7: 400, 8: 500, 9: 380,
                 10: 380, 11: 400, 12: 140, 13: 500, 14: 380, 15: 500, 16: 140, 17: 380, 18: 380 },
        'white': { 1: 320, 2: 560, 3: 420, 4: 170, 5: 400, 6: 160, 7: 420, 8: 520, 9: 400,
                  10: 400, 11: 420, 12: 150, 13: 520, 14: 400, 15: 520, 16: 150, 17: 400, 18: 400 },
        'blue': { 1: 340, 2: 580, 3: 440, 4: 180, 5: 420, 6: 170, 7: 440, 8: 540, 9: 420,
                 10: 420, 11: 440, 12: 160, 13: 540, 14: 420, 15: 540, 16: 160, 17: 420, 18: 420 },
        'black': { 1: 360, 2: 600, 3: 460, 4: 190, 5: 440, 6: 180, 7: 460, 8: 560, 9: 440,
                  10: 440, 11: 460, 12: 170, 13: 560, 14: 440, 15: 560, 16: 170, 17: 440, 18: 440 }
    };
    
    const selectedTee = roundData.selectedTee || 'white';
    const yardage = teeYardages[selectedTee]?.[currentHole] || 420;
    holeYardageElement.textContent = `${yardage}y`;
    
    // Update tee dot color based on selected tees
    const teeColors = {
        'red': '#ff6b6b',
        'gold': '#ffd93d',
        'white': '#ffffff',
        'blue': '#4ecdc4',
        'black': '#2c3e50'
    };
    
    const teeColor = teeColors[selectedTee] || '#8e8e93';
    teeDotElement.style.background = teeColor;
    teeDotElement.style.border = selectedTee === 'white' ? '1px solid var(--separator)' : 'none';
}

function updateScorecardDisplay() {
    document.querySelector('.header h2').textContent = `Hole ${currentHole}`;
    document.querySelector('.current-score').textContent = currentScore;
    
    // Update score vs par
    const par = 4; // This would come from course data
    const vsPar = currentScore - par;
    let vsParText = '';
    if (vsPar === 0) vsParText = 'E';
    else if (vsPar > 0) vsParText = `+${vsPar}`;
    else vsParText = `${vsPar}`;
    
    document.querySelector('.vs-par').textContent = vsParText;
}

function updateRunningTotalsDisplay() {
    const totalSections = document.querySelectorAll('.total-section');
    
    if (roundData.holes === 9) {
        // For 9-hole rounds, hide the "Back 9" section and update labels
        if (totalSections.length >= 2) {
            totalSections[0].querySelector('.total-label').textContent = 'Total';
            totalSections[1].style.display = 'none'; // Hide Back 9
        }
    } else {
        // For 18-hole rounds, show both sections
        if (totalSections.length >= 2) {
            totalSections[0].querySelector('.total-label').textContent = 'Front 9';
            totalSections[1].style.display = 'flex'; // Show Back 9
        }
    }
}

function decreaseScore() {
    if (currentScore > 1) {
        currentScore--;
        updateScorecardDisplay();
    }
}

function increaseScore() {
    currentScore++;
    updateScorecardDisplay();
}

// Hole input interactive functions
let currentStrokes = 4;
let currentPutts = 2;
let currentFairway = 'none';
let currentGIR = 'none';
let currentHazards = [];

function decreaseStrokes() {
    if (currentStrokes > 1) {
        currentStrokes--;
        updateHoleInputDisplay();
    }
}

function increaseStrokes() {
    currentStrokes++;
    updateHoleInputDisplay();
}

function decreasePutts() {
    if (currentPutts > 0) {
        currentPutts--;
        updateHoleInputDisplay();
    }
}

function increasePutts() {
    currentPutts++;
    updateHoleInputDisplay();
}

function setFairway(direction) {
    // If clicking the same button, toggle it off
    if (currentFairway === direction) {
        currentFairway = 'none';
    } else {
        currentFairway = direction;
    }
    updateHoleInputDisplay();
}

function setGIR(direction) {
    // If clicking the same button, toggle it off
    if (currentGIR === direction) {
        currentGIR = 'none';
    } else {
        currentGIR = direction;
    }
    updateHoleInputDisplay();
}

function setHazard(hazardType) {
    const index = currentHazards.indexOf(hazardType);
    if (index > -1) {
        currentHazards.splice(index, 1);
    } else {
        currentHazards.push(hazardType);
    }
    updateHoleInputDisplay();
}

function updateHoleInputDisplay() {
    // Update strokes display
    const strokesElement = document.querySelector('.hole-input-card .input-section:nth-child(1) .input-value');
    if (strokesElement) {
        strokesElement.textContent = currentStrokes;
    }
    
    // Update putts display
    const puttsElement = document.querySelector('.hole-input-card .input-section:nth-child(3) .input-value');
    if (puttsElement) {
        puttsElement.textContent = currentPutts;
    }
    
    // Update fairway buttons
    document.querySelectorAll('.fairway-controls .control-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    const fairwayBtn = document.querySelector(`.fairway-controls .control-btn[onclick*="'${currentFairway}'"]`);
    if (fairwayBtn) {
        fairwayBtn.classList.add('active');
    }
    
    // Update GIR buttons
    document.querySelectorAll('.gir-controls .control-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    const girBtn = document.querySelector(`.gir-controls .control-btn[onclick*="'${currentGIR}'"]`);
    if (girBtn) {
        girBtn.classList.add('active');
    }
    
    // Update hazard buttons
    document.querySelectorAll('.hazard-controls .control-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    currentHazards.forEach(hazard => {
        const hazardBtn = document.querySelector(`.hazard-controls .control-btn[onclick*="'${hazard}'"]`);
        if (hazardBtn) {
            hazardBtn.classList.add('active');
        }
    });
}

function showScorecardMenu() {
    // In real app, this would show a menu with options
    console.log('Scorecard menu clicked');
}

function showPreRoundSetup() {
    showScreen('pre-round-setup');
}

function showRoundSummary() {
    showScreen('round-summary');
    updateRoundSummaryDisplay();
}

function updateRoundSummaryDisplay() {
    const breakdownItems = document.querySelectorAll('.breakdown-item');
    
    if (roundData.holes === 9) {
        // For 9-hole rounds, hide the "Back 9" breakdown and update the first one
        if (breakdownItems.length >= 2) {
            breakdownItems[0].querySelector('.breakdown-label').textContent = 'Total';
            breakdownItems[1].style.display = 'none'; // Hide Back 9
        }
    } else {
        // For 18-hole rounds, show both sections
        if (breakdownItems.length >= 2) {
            breakdownItems[0].querySelector('.breakdown-label').textContent = 'Front 9';
            breakdownItems[1].style.display = 'flex'; // Show Back 9
        }
    }
}

// Journey 4: Handicap Management

function showHandicapInfo() {
    // In real app, this would show handicap calculation info
    alert('Handicap is calculated using the USGA formula based on your best 8 of last 20 rounds.');
}

// Journey 5: Round History and Basic Stats

function showRoundHistory() {
    showScreen('round-history');
}

function showHistoryFilter() {
    // In real app, this would show filter options
    console.log('History filter clicked');
}

function showRoundDetails(roundId) {
    showScreen('round-details');
}

function showHoleByHoleView() {
    showScreen('hole-by-hole');
    updateHoleInfoCompact();
}

// Add navigation functions for hole-by-hole view
function nextHoleInView() {
    if (currentHole < 18) {
        currentHole++;
        updateHoleInfoCompact();
        updateHoleByHoleTable();
    }
}

function previousHoleInView() {
    if (currentHole > 1) {
        currentHole--;
        updateHoleInfoCompact();
        updateHoleByHoleTable();
    }
}

function updateHoleByHoleTable() {
    // This function would update the table to highlight the current hole
    // For now, we'll just update the hole info
    updateHoleInfoCompact();
}

function updateHoleInfoCompact() {
    const holeNumberElement = document.querySelector('.hole-number-compact');
    const holeParElement = document.querySelector('.hole-par-compact');
    const holeYardageElement = document.querySelector('.hole-yardage-compact span');
    const teeDotElement = document.querySelector('.tee-dot');
    
    if (!holeNumberElement || !holeParElement || !holeYardageElement || !teeDotElement) {
        return;
    }
    
    // Update hole number (for now, we'll use currentHole from the global state)
    holeNumberElement.textContent = currentHole || 1;
    
    // Update par based on hole (this would come from course data)
    const holePars = {
        1: 4, 2: 5, 3: 4, 4: 3, 5: 4, 6: 3, 7: 4, 8: 5, 9: 4,
        10: 4, 11: 4, 12: 3, 13: 5, 14: 4, 15: 5, 16: 3, 17: 4, 18: 4
    };
    const par = holePars[currentHole] || 4;
    holeParElement.textContent = `PAR ${par}`;
    
    // Update yardage based on selected tees
    const teeYardages = {
        'red': { 1: 280, 2: 520, 3: 380, 4: 150, 5: 360, 6: 140, 7: 380, 8: 480, 9: 360,
                10: 360, 11: 380, 12: 130, 13: 480, 14: 360, 15: 480, 16: 130, 17: 360, 18: 360 },
        'gold': { 1: 300, 2: 540, 3: 400, 4: 160, 5: 380, 6: 150, 7: 400, 8: 500, 9: 380,
                 10: 380, 11: 400, 12: 140, 13: 500, 14: 380, 15: 500, 16: 140, 17: 380, 18: 380 },
        'white': { 1: 320, 2: 560, 3: 420, 4: 170, 5: 400, 6: 160, 7: 420, 8: 520, 9: 400,
                  10: 400, 11: 420, 12: 150, 13: 520, 14: 400, 15: 520, 16: 150, 17: 400, 18: 400 },
        'blue': { 1: 340, 2: 580, 3: 440, 4: 180, 5: 420, 6: 170, 7: 440, 8: 540, 9: 420,
                 10: 420, 11: 440, 12: 160, 13: 540, 14: 420, 15: 540, 16: 160, 17: 420, 18: 420 },
        'black': { 1: 360, 2: 600, 3: 460, 4: 190, 5: 440, 6: 180, 7: 460, 8: 560, 9: 440,
                  10: 440, 11: 460, 12: 170, 13: 560, 14: 440, 15: 560, 16: 170, 17: 440, 18: 440 }
    };
    
    const selectedTee = roundData.selectedTee || 'white';
    const yardage = teeYardages[selectedTee]?.[currentHole] || 320;
    holeYardageElement.textContent = `${yardage}y`;
    
    // Update tee dot color based on selected tees
    const teeColors = {
        'red': '#ff6b6b',
        'gold': '#ffd93d',
        'white': '#ffffff',
        'blue': '#4ecdc4',
        'black': '#2c3e50'
    };
    
    const teeColor = teeColors[selectedTee] || '#8e8e93';
    teeDotElement.style.background = teeColor;
    teeDotElement.style.border = selectedTee === 'white' ? '1px solid var(--separator)' : 'none';
}

function shareRoundDetails() {
    showShareModal();
}

function editRound() {
    // In real app, this would allow editing the round
    console.log('Edit round clicked');
}

function deleteRound() {
    if (confirm('Are you sure you want to delete this round?')) {
        showRoundHistory();
    }
}

// Journey 6: Basic Course Management

function showCourseManagement() {
    showScreen('course-management');
}

function editCourse(courseId) {
    // In real app, this would show course editing screen
    console.log(`Editing course ${courseId}`);
}

function toggleFavorite(courseId) {
    const btn = event.target;
    if (btn.textContent === 'FAV') {
        btn.textContent = 'FAV';
        btn.style.fontWeight = '400';
    } else {
        btn.textContent = 'FAV';
        btn.style.fontWeight = '700';
    }
}

// Journey 7: Simple Score Sharing

function shareRound() {
    showShareModal();
}

function showShareModal() {
    const modal = document.getElementById('share-modal');
    modal.classList.add('active');
}

function closeShareModal() {
    const modal = document.getElementById('share-modal');
    modal.classList.remove('active');
}

function shareViaMessage() {
    // In real app, this would open Messages app
    console.log('Sharing via Messages');
    closeShareModal();
}

function shareViaMail() {
    // In real app, this would open Mail app
    console.log('Sharing via Mail');
    closeShareModal();
}

function shareViaSocial() {
    // In real app, this would open social media sharing
    console.log('Sharing via Social Media');
    closeShareModal();
}

// Utility functions

function saveRound() {
    // In real app, this would save the round to storage
    console.log('Round saved:', roundData);
    showHomeDashboard();
}

// Initialize the app
document.addEventListener('DOMContentLoaded', function() {
    // Set initial screen
    showScreen('welcome-screen');
    
    // Add keyboard navigation for scorecard
    document.addEventListener('keydown', function(event) {
        if (currentScreen === 'scorecard') {
            if (event.key === 'ArrowLeft') {
                previousHole();
            } else if (event.key === 'ArrowRight') {
                nextHole();
            } else if (event.key === 'ArrowUp') {
                increaseScore();
            } else if (event.key === 'ArrowDown') {
                decreaseScore();
            }
        }
    });
    
    // Add touch/swipe support for mobile
    let touchStartX = 0;
    let touchEndX = 0;
    
    document.addEventListener('touchstart', function(event) {
        touchStartX = event.changedTouches[0].screenX;
    });
    
    document.addEventListener('touchend', function(event) {
        touchEndX = event.changedTouches[0].screenX;
        handleSwipe();
    });
    
    function handleSwipe() {
        const swipeThreshold = 50;
        const diff = touchStartX - touchEndX;
        
        if (Math.abs(diff) > swipeThreshold) {
            if (currentScreen === 'scorecard') {
                if (diff > 0) {
                    // Swipe left - next hole
                    nextHole();
                } else {
                    // Swipe right - previous hole
                    previousHole();
                }
            } else if (currentScreen === 'feature-overview') {
                if (diff > 0) {
                    // Swipe left - next slide
                    const nextSlide = Math.min(currentSlide + 1, 3);
                    goToSlide(nextSlide);
                } else {
                    // Swipe right - previous slide
                    const prevSlide = Math.max(currentSlide - 1, 1);
                    goToSlide(prevSlide);
                }
            }
        }
    }
    
    // Add form validation
    document.querySelectorAll('input[required], select[required]').forEach(input => {
        input.addEventListener('blur', function() {
            if (!this.value) {
                this.style.borderColor = '#666666';
            } else {
                this.style.borderColor = '#d0d0d0';
            }
        });
    });
    
    // Add search functionality
    const courseSearch = document.getElementById('course-search');
    if (courseSearch) {
        courseSearch.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const courseItems = document.querySelectorAll('.course-item');
            
            courseItems.forEach(item => {
                const courseName = item.querySelector('h3').textContent.toLowerCase();
                if (courseName.includes(searchTerm)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    }
    
    const roundSearch = document.getElementById('round-search');
    if (roundSearch) {
        roundSearch.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const roundItems = document.querySelectorAll('.round-item');
            
            roundItems.forEach(item => {
                const courseName = item.querySelector('h3').textContent.toLowerCase();
                if (courseName.includes(searchTerm)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    }
    
    // Add smooth scrolling for iOS
    document.querySelectorAll('.screen').forEach(screen => {
        screen.style.webkitOverflowScrolling = 'touch';
    });
    
    // Add haptic feedback simulation (for prototype)
    function simulateHapticFeedback() {
        // In real iOS app, this would trigger haptic feedback
        console.log('Haptic feedback');
    }
    
    // Add checkbox functionality
    const addHolesLaterCheckbox = document.getElementById('add-holes-later');
    if (addHolesLaterCheckbox) {
        addHolesLaterCheckbox.addEventListener('change', function() {
            console.log('Checkbox changed:', this.checked);
        });
        
        // Also add click handler to label
        const checkboxLabel = document.querySelector('label[for="add-holes-later"]');
        if (checkboxLabel) {
            checkboxLabel.addEventListener('click', function() {
                addHolesLaterCheckbox.checked = !addHolesLaterCheckbox.checked;
                console.log('Label clicked, checkbox now:', addHolesLaterCheckbox.checked);
            });
        }
    }
    
    // Add haptic feedback to important interactions
    document.querySelectorAll('.btn-primary, .start-round-btn, .score-btn').forEach(btn => {
        btn.addEventListener('click', simulateHapticFeedback);
    });
    
    // Add global back button functionality
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape' || (event.ctrlKey && event.key === '[')) {
            goBack();
        }
    });
    
    // Action Sheet Functions - moved outside DOMContentLoaded for global access
    window.showAddCourseActionSheet = function() {
        const actionSheet = document.getElementById('add-course-action-sheet');
        if (actionSheet) {
            actionSheet.classList.add('active');
        }
    };
    
    window.closeAddCourseActionSheet = function() {
        const actionSheet = document.getElementById('add-course-action-sheet');
        if (actionSheet) {
            actionSheet.classList.remove('active');
        }
    };
    
    window.showAddRoundActionSheet = function() {
        const actionSheet = document.getElementById('add-round-action-sheet');
        if (actionSheet) {
            actionSheet.classList.add('active');
        }
    };
    
    window.closeAddRoundActionSheet = function() {
        const actionSheet = document.getElementById('add-round-action-sheet');
        if (actionSheet) {
            actionSheet.classList.remove('active');
        }
    };
    
    window.startNewRound = function() {
        window.closeAddRoundActionSheet();
        showCourseSelection();
    };
    
    window.addPastRound = function() {
        window.closeAddRoundActionSheet();
        // For prototype, just show a message
        alert('Add Past Round functionality would be implemented here');
    };
    
    // Close action sheets when clicking outside
    document.querySelectorAll('.action-sheet').forEach(sheet => {
        sheet.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('active');
            }
        });
    });
    
    // Close action sheets when clicking outside
    document.addEventListener('click', function(e) {
        const startingHoleActionSheet = document.getElementById('starting-hole-action-sheet');
        if (startingHoleActionSheet && startingHoleActionSheet.classList.contains('active') && !startingHoleActionSheet.contains(e.target)) {
            startingHoleActionSheet.classList.remove('active');
        }
        
        // Close all action sheets when clicking outside
        document.querySelectorAll('.action-sheet').forEach(sheet => {
            if (sheet.classList.contains('active') && !sheet.contains(e.target)) {
                sheet.classList.remove('active');
            }
        });
    });
    
    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
        const dropdown = document.getElementById('tee-dropdown');
        if (dropdown && !dropdown.contains(e.target)) {
            dropdown.classList.remove('open');
        }
    });
    
    // Close action sheets when clicking outside
    document.addEventListener('click', function(e) {
        const startingHoleActionSheet = document.getElementById('starting-hole-action-sheet');
        if (startingHoleActionSheet && startingHoleActionSheet.classList.contains('active') && !startingHoleActionSheet.contains(e.target)) {
            startingHoleActionSheet.classList.remove('active');
        }
        
        // Close all action sheets when clicking outside
        document.querySelectorAll('.action-sheet').forEach(sheet => {
            if (sheet.classList.contains('active') && !sheet.contains(e.target)) {
                sheet.classList.remove('active');
            }
        });
    });
});

// Export functions for global access (for onclick handlers)
window.showFeatureOverview = showFeatureOverview;
window.showReturningUser = showReturningUser;
window.goToSlide = goToSlide;
window.showAccountSetup = showAccountSetup;
window.showLocationPermission = showLocationPermission;
window.grantLocationPermission = grantLocationPermission;
window.skipLocationPermission = skipLocationPermission;
window.showFirstCourseSetup = showFirstCourseSetup;
window.findNearbyCourses = findNearbyCourses;
window.addCourseManually = addCourseManually;
window.selectCourse = selectCourse;
window.saveCourse = saveCourse;
window.showHoleDetails = showHoleDetails;
window.previousHole = previousHole;
window.nextHole = nextHole;
window.skipHole = skipHole;
window.saveHole = saveHole;
window.showTeeSetup = showTeeSetup;
window.editTee = editTee;
window.addNewTee = addNewTee;
window.finishCourseSetup = finishCourseSetup;
window.showHomeDashboard = showHomeDashboard;
window.showSettings = showSettings;
window.showCourseSelection = showCourseSelection;
window.quickStartRound = quickStartRound;
window.selectCourseForRound = selectCourseForRound;
window.startRound = startRound;
window.showScorecard = showScorecard;
window.decreaseScore = decreaseScore;
window.increaseScore = increaseScore;
window.showScorecardMenu = showScorecardMenu;
window.showRoundSummary = showRoundSummary;
window.showHandicapInfo = showHandicapInfo;
window.showRoundHistory = showRoundHistory;
window.showHistoryFilter = showHistoryFilter;
window.showRoundDetails = showRoundDetails;
window.shareRoundDetails = shareRoundDetails;
window.editRound = editRound;
window.deleteRound = deleteRound;
window.showCourseManagement = showCourseManagement;
window.editCourse = editCourse;
window.toggleFavorite = toggleFavorite;
window.shareRound = shareRound;
window.showShareModal = showShareModal;
window.closeShareModal = closeShareModal;
window.shareViaMessage = shareViaMessage;
window.shareViaMail = shareViaMail;
window.shareViaSocial = shareViaSocial;
window.saveRound = saveRound;
window.goBack = goBack; 