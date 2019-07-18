 % CLPS 1590 - Visualizing Vision

clear % Clear the workspace at the start

%% OPEN OUTPUT FILE FOR RECORDING DATA

% Using console to collect input
subid = input('Enter subject ID number: ');

% Where will the output file be stored? This is a relative path from the
% current directory when you run this file (see Current Folder panel at left).
% Notice how adding the square brackets lets you concatenate multiple strings,
% and how we do a num2str ("number-to-string") on the subject ID that was input above. 
outputFileName = ['subj' num2str(subid) '.txt'];
    
% Check to AVOID OVERWRITING an existing file
% If this happens, the program displays (disp) a message in the command window
% and the script stops executing here.
% To stop this, you need to enter a different subid or delete the old file.
if exist(outputFileName, 'file')==2
    disp('That file already exists!');
    return; % Exit from the program
end

% OPEN a file stream for writing data out
% this function returns a number, which is the file "handle"
% i.e., a way to grab the open file when you want to use it
outfile = fopen(outputFileName,'wt'); 
 
% In the fprintf command below, we use the file handle to write to this file.
% We will print the data as a table, where each trial is a row, and each column 
% holds a different piece of identifying information needed for analysis. 

% Here we'll just print the Column Headers, separated by tab characters ('\t').
% When we print the data during the experiment, we will supply variables
% that change values during the experiment. Since we're only doing the
% headers here, we type a single string, composed of identifying titles for the
% columns of our data table, tab characters ('\t'), and a new line character ('\n') at the end.
fprintf(outfile, 'Subject\t Trial\t ProbeL\t RT\t Type\t Depth\t Spec\t DP\t \n');

% Here is a visual example of how we are setting up this output file to look in the end
%
% subject    trial    size    distance    probeLength    RT
%       1        1       2           2             56  2.82
%       1        2       2           1             64  1.62
%       1        3       1           2             23  2.42
%     ...      ...     ...         ...            ...   ...
%       1       11       1           2             26  1.12
%       1       12       1           1             30  1.32

%% FACTORIAL DESIGN

% Factors are the variables that you want to measure the effect of.
% You will create numerical representations of your factors in this section.
% We can use these to control the presentation of stimuli in the experiment,
%  and to keep track what was shown on each trial so we can print it in the output file.
% This example is a two-factor experiment, Size and Distance.
% Each factor has 2 levels, so there are 4 cells in the design.
%
%      -------------   % Cell 1 = near small [1 1]
%      | Distance  |   % Cell 2 = far  small [2 1]
% ------------------   % Cell 3 = near large [1 2]
% |    |  1  |  2  |   % Cell 4 = far  large [2 2]
% | Sz |------------   
% |    |  3  |  4  |   
% ------------------   

% We can define our factors with vectors of numerical labels (1 to numLevels)
factor1 = 1:4; % Factor "Depth" has 4 levels
factor2 = 1:3; % Factor "Specularity" has 3 levels
factor3 = 1:2; % Dot position has 2 levels
numCells = length(factor1) * length(factor2) * length(factor3); % number of cells in design
factorsMap = CombVec(factor1, factor2, factor3); % function to get all combinations of factor levels

% By indexing into factorsMap using the number of a specific cell in our design,
%  we can obtain identifying information about the factors being shown on that trial.
% >> factorsMap(:,1)    % >> factorsMap(:,2)    % >> factorsMap(:,3)    % >> factorsMap(:,4)
%     1                 %     2                 %     1                 %     2 
%     1                 %     1                 %     2                 %     2

%% LOAD IN YOUR STIMULUS IMAGES
% In this experiment, the stimuli are pre-made image files.


% Specularity 1
A1B1C1 = imread (['images' filesep '1specular1_depth1.png']);
A1B1C2 = imread (['images' filesep '1specular1_depth2.png']);

A1B2C1 = imread (['images' filesep '1specular1_depth3.png']);
A1B2C2 = imread (['images' filesep '1specular1_depth4.png']);

% Specularity 2
A1B3C1 = imread (['images' filesep '1specular2_depth1.png']);
A1B3C2 = imread (['images' filesep '1specular2_depth2.png']);

A2B1C1 = imread (['images' filesep '1specular2_depth3.png']);
A2B1C2 = imread (['images' filesep '1specular2_depth4.png']);

% Specularity 3
A2B2C1 = imread (['images' filesep '1specular3_depth1.png']);
A2B2C2 = imread (['images' filesep '1specular3_depth2.png']);

A2B3C1 = imread (['images' filesep '1specular3_depth3.png']);
A2B3C2 = imread (['images' filesep '1specular3_depth4.png']);



% CHANGE DOT POSITIONS:


% Specularity 1
nA1B1C1 = imread (['images' filesep '2specular1_depth1.png']);
nA1B1C2 = imread (['images' filesep '2specular1_depth2.png']);

nA1B2C1 = imread (['images' filesep '2specular1_depth3.png']);
nA1B2C2 = imread (['images' filesep '2specular1_depth4.png']);

% Specularity 2
nA1B3C1 = imread (['images' filesep '2specular2_depth1.png']);
nA1B3C2 = imread (['images' filesep '2specular2_depth2.png']);

nA2B1C1 = imread (['images' filesep '2specular2_depth3.png']);
nA2B1C2 = imread (['images' filesep '2specular2_depth4.png']);

% Specularity 3
nA2B2C1 = imread (['images' filesep '2specular3_depth1.png']);
nA2B2C2 = imread (['images' filesep '2specular3_depth2.png']);

nA2B3C1 = imread (['images' filesep '2specular3_depth3.png']);
nA2B3C2 = imread (['images' filesep '2specular3_depth4.png']);

% Here we put the four images, which must all have the same dimensions,
%  into a single 4D matrix (height x width x colorChannel x imageNumber).
stimulus_array = cat(4, A1B1C1, A1B1C2, A1B2C1, A1B2C2, A1B3C1, A1B3C2, A2B1C1, A2B1C2, A2B2C1, A2B2C2, A2B3C1, A2B3C2, nA1B1C1, nA1B1C2, nA1B2C1, nA1B2C2, nA1B3C1, nA1B3C2, nA2B1C1, nA2B1C2, nA2B2C1, nA2B2C2, nA2B3C1, nA2B3C2);
% MAKE SURE THE IMAGES ARE ORDERED ACCORDING TO THE NUMBERING OF THE CELLS IN YOUR FACTORIAL DESIGN!

% This way we can index into this list to grab an image with:
%  >> stimulus_array(:,:,:,cellID)
% See example at end of next section.

% Remember, when indexing into a matrix, the colon operator means "return all
% of the elements along this dimension", so the above command retrieves a 
% single image from the first three dimensions (height X width X colorChannel).

%% CREATE A RANDOM TRIAL ORDER 
% How many repetitions do we want for each cell in our design?
numCellRepetitions = 4; 
% Repeat the cellIDs (1:numCells) to create a longer vector representing the set of trials
cellIDs_byTrial = repmat(1:numCells, 1, numCellRepetitions); 
totalNumberOfTrials = length(cellIDs_byTrial);
% Randomize the order of the cellIDs across the trials
cellIDs_byTrial = Shuffle(cellIDs_byTrial);
% Shuffle returns (for example):
%  [1, 4, 4, 3, 2, 3, 2, 1, 3, 1, 4, 2]
% Notice this ensures that each cell is in there an equal number of times!

% With this representation, we will be able check the cellID number on each
% trial in the trial loop. We can then use the cellID to index the appropriate
% column of "factorMap", which tells us the factor levels being displayed on
% that trial. cellIDs can also be used to index into stimulus_array, where we 
% are holding the stimuli.

% for tr = 1:totalNumberOfTrials
%     ...
%     currentCellID = cellIDs_byTrial(tr);
%     currentSize = factorMap(1,currentCellID);
%     currentDistance = factorMap(2,currentCellID);
%     currentImage = stimulus_array(:,:,:,currentCellID); 
%     ...
% end

%% Keyboard Codes
KbName('UnifyKeyNames'); % Cross-platform compatibility (Mac/Windows/Linux)

% Retrieve numeric codes for response keys
up = KbName('UpArrow');
down = KbName('DownArrow'); 
spaceKey = KbName('space');
escKey = KbName('q');

% To obtain the names that PTB uses for specific keys (like 'UpArrow'):
% 1. Type KbDemo in the Command Window
% 2. Press the key you're interested in
% 3. It will show the name of that key

% We'll also take this time to set some timing parameters for the experiment
interTrialInterval = .5; % Half a second between each trial

%% --OPENING A GRAPHICS WINDOW--
% Get some important settings in place before getting started
AssertOpenGL; % checks that you have the right version
Screen('Preference', 'SkipSyncTests', 1); % Disables timing tests that we don't need

% Now we find the monitor screen with the Psychtoolbox Screen() function
screen_number = Screen('Screens'); % Labels the screen with a number
screen_specs = Screen('Resolution', screen_number); % Gets the resolution

% Unlike typical MATLAB functions, Psychtoolbox's Screen() is more like aa "class" containing
% many different functions. These are accessed via strings given as the first argument to Screen.

% Here we open the graphics window - this is where you can no longer go line-by-line in this code!  
[windowHandle, screenrect] = Screen('OpenWindow', screen_number);

% If you don't want the window to be full-screen, comment out the line above
%  and uncomment the line below, where we've added the optional [rect] parameter
%  to dictate the window position and size (helpful for debugging).
%[windowHandle, screenrect] = Screen('OpenWindow', 0, [], [0 0 640 480]);

% Two different variables are output from this function (hence the square brackets):
% 1. windowHandle: the window handle, needed when using Screen() commands that draw graphics in the window.
% 2. screenrect: list of x,y coordinates, in pixels, for the screen corners
%     screenrect([1 2]) are x,y coordinates of top left corner (usually [0 0]) 
%     screenrect([3 4)) are x,y coordinates of bottom left corner (usually [horizontalResolution verticalResolution])

% It will be helpful to draw things with respect to the window's center, so here we store the coordinates.
center = screenrect([3 4])/2; % Get the x-y coordinates of the center of the window

% Fill the window with a colored rectangle [0 0 0] is black (zero intensities for Red, Green, and Blue)
Screen('FillRect', windowHandle, [0 0 0]);

% Display the contents of the graphics buffer (where we drew the text) on the actual screen
Screen('Flip', windowHandle);
% Until this command is given, drawing operations are not visible on the screen. 
% 'Flip' also creates a new empty buffer to draw in.

% Two more functions that hand over control to the Psychtoolbox program
ListenChar(2); % Re-routes keyboard inputs so they don't get typed in the Command Window
HideCursor; % The mouse disappears from the screen

%% SHOW EXPERIMENT INSTRUCTIONS
% Set up the display (black background, medium size text)
Screen('FillRect', windowHandle, [0 0 0]); % Draw a black rectangle in the graphics buffer
Screen('TextSize', windowHandle, 24); % Set the size of the text

% DrawFormattedText(window handle, text string to display,
%                   x position, y position, text color,
%                   [], [], [], line spacing)
% The []s are "null inputs" for options we don't care about; see 'help DrawFormattedText'
% DrawFormattedText is a Psychtoolbox function, but notice it is not a Screen() command.
% Write your experiment instructions, being mindful of where you put the newline characters
% and the x-y coordinates of the first line so you get a nice display.
% Also notice that the ellipsis (...) allows you to continue commands on the next line
% But you must terminate strings first or it will just concatenate '...' onto them!
DrawFormattedText(windowHandle, ['Adjust the vertical probe line with the Up and Down arrows\n' ... 
    'so it matches the depth in 3D space between the two black dots.\nThese dots lie on the surface of the object.\n\nPress Space to record your response.\n' ...
    'Press Space to start.'], center(1)-500, center(2)-300, [200 200 200],[],[],[],1.5);

% Flip the buffer with the instructions text to the screen.
Screen('Flip', windowHandle); 

%% WAIT FOR KEYPRESS ON INSTRUCTIONS SCREEN

% Infinite loop that checks for keyboard activity
while 1 % 1 always evaluates as true, that's why this is an infinite loop
    % Check for key presses and return variables that help identify the key
    [keyIsDown, secs, keyCode] = KbCheck;
    
    % Clear the event queue of keypress events
    FlushEvents('keyDown'); 
    
    % If some key was pressed
    if keyIsDown
        
        % We check if that key was one of our response keys using if-elseif.
        
        % If it was SPACE (our "continue" button), break out of this loop
        if keyCode(spaceKey) % See "Keyboard Codes" section above for spaceKey definition  
            break ; % Break out of this loop
            
        % If it was 'q', exit the experiment.
        elseif keyCode(escKey)
            ShowCursor; % Display the cursor
            fclose(outfile); % Close the output file
            Screen('CloseAll'); % Close all Psychtoolbox windows
            return; % Stop the script
            
        end
        
    end
    
end

% Wait until all keys are released before continuing to next section
KbReleaseWait;

%% EXPERIMENT AND TRIAL LOOPS - The Most Important Section!
%  The outer loop walks through the trials one by one, running the same code on
%   each trial to set up the trial parameters and write to file.
%  The inner loop controls the flow of each trial, drawing the stimuli, keeping
%   track of the timing of each trial, and controlling mouse/keyboard interactions.

% Each loop iteration is a trial, and tr is assigned the trial number
for tr = 1:totalNumberOfTrials

    % 1. SETTING UP THE TRIAL
    
    % Get the relevant information for the current trial - see first section
    currentCellID = cellIDs_byTrial(tr); % Get the cell ID for this trial
    currentDepth = factorsMap(1,currentCellID); % Get the factor 1 value
    currentSpecularity = factorsMap(2,currentCellID); % Get the factor 2 value
    currentDotPosition = factorsMap(3,currentCellID);
     
    
    currentImage = stimulus_array(:,:,:, currentCellID); % Get the stimulus image
    
    
    

    % Randomize the starting probe length, 10 - 60 pixels
    probeLength = randi(50)+70; % randomize starting length of probe line
    
    % Make sure the program doesn't think any keys are being pressed
    keyIsDown=0;
    
    % Wait during the inter-trial interval
    WaitSecs(interTrialInterval);
    % Record the trial start time
    timeStart = GetSecs;
    
    % TRIAL LOOP - this is an infinite loop until a response is given
    while 1 

        % 2. DRAWING THE STIMULUS AND THE RESPONSE LINE
        
        % Draw image data in the window. Seems to place image in center of screen by default. 
        Screen('PutImage', windowHandle, currentImage);
        
        % Draw the probe line off to the right of the stimulus (x = 1100).
        % Notice that the y coordinate of one end is based on the variable 'probeLength'. 
        Screen('DrawLine', windowHandle, [200 200 200], ...
            500, center(2)-probeLength, ...
            500, center(2), 6);
        % The parameters of this function are:
        % Screen('DrawLine', window handle, color, xPos_start, yPos_start, xPos_end, yPos_end, line width)
        
        % Flip the window to show what you've drawn.
        Screen('Flip', windowHandle);

        % 3. CHECKING FOR KEYBOARD INPUT, RESPONSE HANDLING
        
        % Check for key presses and return variables that help identify the key
        [keyIsDown, secs, keyCode] = KbCheck;
        
        % Clear the event queue of keypress events
        FlushEvents('keyDown');
        
        % If a key was pressed
        if keyIsDown
            
            % keyCode is a logical array, each element corresponds to a key.
            % It is 1 at the key's index if the key was pressed, 0 if not.
            
            % If ESC was pressed, quit and close output file
            if keyCode(escKey)
                ShowCursor; ListenChar(0); fclose(outfile); Screen('CloseAll'); return;
             
            % If Space was pressed, compute RT and escape from the infinite loop
            elseif keyCode(spaceKey)
                rt = 1000*(GetSecs-timeStart); % compute RT in milliseconds
                keyPressed=find(keyCode); % get the key number from the logical array
                break; % escape from this infinite loop
                
            % If the Up/Down Arrow Keys were pressed, change the probe line length
            elseif keyCode(up)
                probeLength = probeLength + 2;
            elseif keyCode(down)
                probeLength = probeLength - 2;
                
            end
            
            keyIsDown=0; keyCode=0; % Reset these variables
        end
    end

    % Draw and Flip another black square to replace the stimulus after the response is given 
    Screen('FillRect', windowHandle, [0 0 0]);
    Screen('Flip', windowHandle);

    % 4. WRITE DATA TO OUTPUT FILE (fprintf)
    % Usage: fprintf(output file handle, formatting string, entry1, entry2, entry3, ..., entryN)
    % The first argument is the handle returned by fopen (see first section).
    % The second argument is a funny-looking string that tells MATLAB what kind of data to expect in the file.
    % The data type of each column is specified by the '%' sign, followed by a letter denoting the format.
    %  (%d for double, %s for string, %6.2f for a 6-digit number where 2 digits follow the decimal point)
    % In our file, the columns are tab-delimited, so we separate the data type specifiers with '\t'. 
    % And finally, again we have a new line character '\n' at the end of the line.
    % Then you just list the variables you want to print in the correct order.
    % Make sure this order is consistent with the order of your headers (see section 1).
    fprintf(outfile, '%d\t %d\t %d\t %6.2f\t %d\t %d\t %d\t %d\t \n', ...
        subid, tr, probeLength, rt, currentCellID, currentDepth, currentSpecularity, currentDotPosition);
    
    % See 'help fprintf' for details about this function
    
    % Again, here's the example of how this output file should look.
    %
    % subject    trial    size    distance    probeLength    RT
    %       1        1       2           2             56  2.82
    %       1        2       2           1             64  1.62
    %       1        3       1           2             23  2.42
    %     ...      ...     ...         ...            ...   ...
    %       1       11       1           2             26  1.12
    %       1       12       1           1             30  1.32
    
    % Wait until all keys are released before beginning next trial
    KbReleaseWait; 
end


%% Ending the experiment
ListenChar(0); % Give up control of the keyboard
Screen('CloseAll'); % Close the Psychtoolbox window
fclose(outfile); % Close output file when you're finished or it could get messed up!

