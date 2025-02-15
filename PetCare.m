%START OF THE MAIN
% Load or initialize the database
database = loadDatabase();

% Check user input
while true
    % Prompt user if they are a sitter or looking for a sitter
    userType = input('Are you a sitter or looking for a sitter? (Type "sitter" or "looking"): ', 's');
    if strcmpi(userType, 'sitter')
        % Sitter mode
        if strcmpi(input('Would you like to modify an existing profile? (Y/N)', 's'), 'y')
        sitterModify();
        else
        database = sitterMode(database);
        end
        break
    elseif strcmpi(userType, 'looking')
        % Looking for sitter mode
        lookingForSitterMode(database);
        break
    else
        disp('Invalid input. Please type "sitter" or "looking".');
    end
end

% Function to modify existing sitter
function sitterModify()
    database = loadDatabase();
    inputId = 0;
    while inputId > length(database) || inputId <= 0
        inputId = input('What is your identification number?');
        if inputId > length(database) || inputId < 0
            disp('Invalid input!')
        end
    end
            while true
                disp('What would you like to modify?');
                disp('(age, gender, pet type, experience)');
                userInput = input('','s');
                if strcmpi(userInput, 'age')
                    database(inputId).age = input('Please input what you will change it to.');
                    break
                else 
                    if strcmpi(userInput, 'gender')
                    database(inputId).gender = input('Please input what you will change it to.', 's');
                    break
                    else 
                        if strcmpi(userInput, 'pet type')
                        database(inputId).petpref = input('Please input what you will change it to.', 's');
                        break                    
                    else 
                        if strcmpi(userInput, 'experience')
                        database(inputId).experience = input('Please input what you will change it to.');
                        break
                        else
                            disp('Invalid input!');
                        end
                        end
                    end
                end
            end
            % Save database
            disp('Your modification has been saved.')
            saveDatabase(database);
end
            


% Function to handle sitter mode
function database = sitterMode(database)
    disp('Welcome to Sitter Mode!');
    % Prompt sitter to enter their information
    sitterInfo.name = input('Enter your name: ', 's');
    sitterInfo.age = input('Enter your age: ');
    sitterInfo.gender = input('Enter your gender: ', 's');
    sitterInfo.petpref = input('Enter your pet type preference (or type any): ', 's');
    sitterInfo.experience = input('Enter your experience (years): ');
    sitterInfo.phonenumber = input('Enter your phone number: ');
    sitterInfo.additional = input('Enter any additional notes: ', 's');

    % Add sitter information to the database
    database = addToDatabase(database, sitterInfo);

    % Save database
    saveDatabase(database);
    
    % Display confirmation message
    disp('Your information has been added to the database.');
    fprintf('Your unique identifier number is %.f\n',numel(database));
end

% Function to handle looking for sitter mode
function lookingForSitterMode(database)
    disp('Welcome to Looking for Sitter Mode!');
    % Prompt user to enter their preferences for a pet sitter
    preferences.age = input('Enter preferred age: ');
    preferences.gender = input('Enter preferred gender (or type "any"): ', 's');
    preferences.petpref = input('Enter your pet type: ', 's');
    preferences.experience = input('Enter preferred experience (years): ');
    
    % Prompt user to change weights
    weightage = 1;
    weightgender = 1;
    weightpref = 1;
    weightexp = 1;
    while true
        weight = input('Which characteristic is the most important for you? (age, gender, pet pref, experience)', 's');
        if strcmpi(weight, 'age')
            weightage = 10;
            break
        elseif strcmpi(weight, 'gender')
            weightgender = 10;
            break
        elseif strcmpi(weight, 'pet pref')
            weightpref = 10;
            break
        elseif strcmpi(weight, 'experience')
            weightexp = 10;
            break
        else
            disp('Please enter a valid input')
        end
    end

    % Find matches in the database based on user preferences
    % ------------
    bestMatchIds = zeros(numel(database), 1);
    for i = 1:numel(database)
        % compares and creates a match score
        % if ages are equal score doesnt change, else sub difference
        % string matches are add 1 or add 0 (logical op)
        
        matchScore = 0;
        matchScore = matchScore - weightage * abs((preferences.age - database(i).age));
        matchScore = matchScore - weightexp * abs(double(preferences.experience) - double(database(i).experience));
        
        if preferences.gender == "any"
            matchScore = matchScore + weightgender;
        else
            matchScore = matchScore + weightgender * (double(strcmpi(preferences.gender, database(i).gender)));
        end
        
        if database(i).petpref == "any"
            matchScore = matchScore + weightpref;
        else
            matchScore = matchScore + weightpref * (double(strcmpi(preferences.petpref, database(i).petpref)));
        end
                
        % store the best matching Id(s)
        bestMatchIds(i) = matchScore;
            
    end
    %%%%%%%%%%%%%%%
    
    %Display match
    disp('Closest match sitter:');
    [~, bestmatch] = maxk(bestMatchIds, length(bestMatchIds));
    disp(database(bestmatch(1)));
    
    if strcmpi(input('Would you like to match? (Y/N)', 's'), 'y')
        disp("Congrats! First try!");
    else
        for attempts = 2:length(bestMatchIds)
            disp("Here is the next best match!")
            disp(database(bestmatch(attempts)));
            if attempts == length(bestMatchIds)
                disp("We can out of users! Please try again later")
                break
            end
            if strcmpi(input('Would you like to match? (Y/N)', 's'), 'y')
                fprintf("Congrats! This took %.f attempts! \n ", attempts)
                break;
            end
        end
    end
 end

% Function to load database from file
function database = loadDatabase()
    database = [];
    if exist('database.mat', 'file')
        load('database.mat', 'database');
    end
end

% Function to add sitter information to the database
function updatedDatabase = addToDatabase(database, sitterInfo)
    updatedDatabase = [database; sitterInfo];
end

% Function to save database to file
function saveDatabase(database)
    save('database.mat', 'database');
end