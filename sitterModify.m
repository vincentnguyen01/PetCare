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
                    saveDatabase(database);
                    break
                elseif strcmpi(userInput, 'gender')
                    database(inputId).gender = input('Please input what you will change it to.', 's');
                    saveDatabase(database);
                    break
                elseif strcmpi(userInput, 'pet type')
                    database(inputId).petpref = input('Please input what you will change it to.', 's');
                    saveDatabase(database);
                    break                    
                elseif strcmpi(userInput, 'experience')
                    database(inputId).experience = input('Please input what you will change it to.');
                    saveDatabase(database);
                    break
                else
                    disp('Invalid input!');
                end
            end
    disp('Your modification has been saved.')
end

                
         
            
           
