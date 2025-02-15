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