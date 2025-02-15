% Function to load database from file
function database = loadDatabase()
    database = [];
    if exist('database.mat', 'file')
        load('database.mat', 'database');
    end
end