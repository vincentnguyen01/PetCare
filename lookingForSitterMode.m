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