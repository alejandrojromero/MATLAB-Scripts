close all
clear
data{1,10} = [];


file = fopen('data_with_factors2.txt');
columnNames = textscan(file,'%s %s %s %s %s %s %s %s', 1);
all_data = cell2mat(textscan(file, '%d %d %d %d %d %d %d %d', 'Delimiter', '\t'));
    
fclose(file);


celldisp(columnNames);

% Using the console output of the above function, link the cell position numbers to recognizable names
subject_num = 1; 
trial = 2;
probe_length = 3;
react_time = 4;
stiumulus_type = 5;
depth = 6;
specularity = 7;
dot_pos = 8;

dot1_spec1_const = zeros(0,2);
dot2_spec1_const = zeros(0,2);

dot1_spec2_const = zeros(0,2);
dot2_spec2_const = zeros(0,2);

dot1_spec3_const = zeros(0,2);
dot2_spec3_const = zeros(0,2);

num_trials = length(all_data);

for i = 1: num_trials
    
    % Shape 1:
    if all_data(i, specularity) == 1 && all_data(i, dot_pos) == 1
        dot1_spec1_const = cat(1, dot1_spec1_const, [all_data(i,probe_length), all_data(i, depth)]);
    elseif all_data(i, specularity) == 1 && all_data(i, dot_pos) == 2
        dot2_spec1_const = cat(1, dot2_spec1_const, [all_data(i,probe_length), all_data(i, depth)]);
        
    elseif all_data(i, specularity) == 2 && all_data(i, dot_pos) == 1
        dot1_spec2_const = cat(1, dot1_spec2_const, [all_data(i,probe_length), all_data(i, depth)]);
    elseif all_data(i, specularity) == 2 && all_data(i, dot_pos) == 2
        dot2_spec2_const = cat(1, dot2_spec2_const, [all_data(i,probe_length), all_data(i, depth)]);
        
    elseif all_data(i, specularity) == 3 && all_data(i, dot_pos) == 1
        dot1_spec3_const = cat(1, dot1_spec3_const, [all_data(i,probe_length), all_data(i, depth)]);
    elseif all_data(i, specularity) == 3 && all_data(i, dot_pos) == 2
        dot2_spec3_const = cat(1, dot2_spec3_const, [all_data(i,probe_length), all_data(i, depth)]);
    

        
  %  elseif all_data(i, env_type) == 1 && all_data(i, shape) == 2 && all_data(i, dot_pos) == 1
   %     dot1_shape2_env1_const = cat(1, dot1_shape2_env1_const, [all_data(i,probe_length), all_data(i, specularity)]);
   % elseif all_data(i, env_type) == 1 && all_data(i, shape) == 2 && all_data(i, dot_pos) == 2
    %    dot2_shape2_env1_const = cat(1, dot2_shape2_env1_const, [all_data(i,probe_length), all_data(i, specularity)]);
        
    %elseif all_data(i, env_type) == 2 && all_data(i, shape) == 2 && all_data(i, dot_pos) == 1
     %   dot1_shape2_env2_const = cat(1, dot1_shape2_env2_const, [all_data(i,probe_length), all_data(i, specularity)]);
    %elseif all_data(i, env_type) == 2 && all_data(i, shape) == 2 && all_data(i, dot_pos) == 2
     %   dot2_shape2_env2_const = cat(1, dot2_shape2_env2_const, [all_data(i,probe_length), all_data(i, specularity)]);
    end
end
 

figure('Name','Dot Position 1');

num = length(dot1_spec1_const);
total_trials = num/4;
columnMean1 = 0.0;
columnMean2 = 0.0;
columnMean3 = 0.0;
columnMean4 = 0.0;

for i = 1:num
    if dot1_spec1_const(i, 2) == 1
        columnMean1 = columnMean1 + dot1_spec1_const(i, 1);
    end
    if dot1_spec1_const(i, 2) == 2
        columnMean3 = columnMean3 + dot1_spec1_const(i, 1);
    end
    if dot1_spec1_const(i, 2) == 3
        columnMean2 = columnMean2 + dot1_spec1_const(i, 1);
    end
    if dot1_spec1_const(i, 2) == 4
        columnMean4 = columnMean4 + dot1_spec1_const(i, 1);
    end
    
end


columnMean1 = columnMean1 / total_trials;
columnMean2 = columnMean2 / total_trials;
columnMean3 = columnMean3 / total_trials;
columnMean4 = columnMean4 / total_trials;
scatter([1 2 3 4], [columnMean1 columnMean2 columnMean3 columnMean4]);
    

hold on 


num = length(dot1_spec2_const);
total_trials = num/4;
columnMean1 = 0.0;
columnMean2 = 0.0;
columnMean3 = 0.0;
columnMean4 = 0.0;

for i = 1:num
    if dot1_spec2_const(i, 2) == 1
        columnMean1 = columnMean1 + dot1_spec2_const(i, 1);
    end
    if dot1_spec2_const(i, 2) == 2
        columnMean3 = columnMean3 + dot1_spec2_const(i, 1);
    end
    if dot1_spec2_const(i, 2) == 3
        columnMean2 = columnMean2 + dot1_spec2_const(i, 1);
    end
    if dot1_spec2_const(i, 2) == 4
        columnMean4 = columnMean4 + dot1_spec2_const(i, 1);
    end
    
end


columnMean1 = columnMean1 / total_trials;
columnMean2 = columnMean2 / total_trials;
columnMean3 = columnMean3 / total_trials;
columnMean4 = columnMean4 / total_trials;
scatter([1 2 3 4], [columnMean1 columnMean2 columnMean3 columnMean4]);
    

hold on 


num = length(dot1_spec3_const);
total_trials = num/4;
columnMean1 = 0.0;
columnMean2 = 0.0;
columnMean3 = 0.0;
columnMean4 = 0.0;

for i = 1:num
    if dot1_spec3_const(i, 2) == 1
        columnMean1 = columnMean1 + dot1_spec3_const(i, 1);
    end
    if dot1_spec3_const(i, 2) == 2
        columnMean3 = columnMean3 + dot1_spec3_const(i, 1);
    end
    if dot1_spec3_const(i, 2) == 3
        columnMean2 = columnMean2 + dot1_spec3_const(i, 1);
    end
    if dot1_spec3_const(i, 2) == 4
        columnMean4 = columnMean4 + dot1_spec3_const(i, 1);
    end
    
end


columnMean1 = columnMean1 / total_trials;
columnMean2 = columnMean2 / total_trials;
columnMean3 = columnMean3 / total_trials;
columnMean4 = columnMean4 / total_trials;
scatter([1 2 3 4], [columnMean1 columnMean2 columnMean3 columnMean4]);
    



figure('Name','Dot Position 2');

num = length(dot2_spec1_const);
total_trials = num/4;
columnMean1 = 0.0;
columnMean2 = 0.0;
columnMean3 = 0.0;
columnMean4 = 0.0;

for i = 1:num
    if dot2_spec1_const(i, 2) == 1
        columnMean1 = columnMean1 + dot2_spec1_const(i, 1);
    end
    if dot2_spec1_const(i, 2) == 2
        columnMean2 = columnMean2 + dot2_spec1_const(i, 1);
    end
    if dot2_spec1_const(i, 2) == 3
        columnMean3 = columnMean3 + dot2_spec1_const(i, 1);
    end
    if dot2_spec1_const(i, 2) == 4
        columnMean4 = columnMean4 + dot2_spec1_const(i, 1);
    end
    
end


columnMean1 = columnMean1 / total_trials;
columnMean2 = columnMean2 / total_trials;
columnMean3 = columnMean3 / total_trials;
columnMean4 = columnMean4 / total_trials;
scatter([1 2 3 4], [columnMean1 columnMean2 columnMean3 columnMean4]);
    

hold on 


num = length(dot2_spec2_const);
total_trials = num/4;
columnMean1 = 0.0;
columnMean2 = 0.0;
columnMean3 = 0.0;
columnMean4 = 0.0;

for i = 1:num
    if dot2_spec2_const(i, 2) == 1
        columnMean1 = columnMean1 + dot2_spec2_const(i, 1);
    end
    if dot2_spec2_const(i, 2) == 2
        columnMean2 = columnMean2 + dot2_spec2_const(i, 1);
    end
    if dot2_spec2_const(i, 2) == 3
        columnMean3 = columnMean3 + dot2_spec2_const(i, 1);
    end
    if dot2_spec2_const(i, 2) == 4
        columnMean4 = columnMean4 + dot2_spec2_const(i, 1);
    end
    
end


columnMean1 = columnMean1 / total_trials;
columnMean2 = columnMean2 / total_trials;
columnMean3 = columnMean3 / total_trials;
columnMean4 = columnMean4 / total_trials;
scatter([1 2 3 4], [columnMean1 columnMean2 columnMean3 columnMean4]);
    

hold on 


num = length(dot2_spec3_const);
total_trials = num/4;
columnMean1 = 0.0;
columnMean2 = 0.0;
columnMean3 = 0.0;
columnMean4 = 0.0;

for i = 1:num
    if dot2_spec3_const(i, 2) == 1
        columnMean1 = columnMean1 + dot2_spec3_const(i, 1);
    end
    if dot2_spec3_const(i, 2) == 2
        columnMean2 = columnMean2 + dot2_spec3_const(i, 1);
    end
    if dot2_spec3_const(i, 2) == 3
        columnMean3 = columnMean3 + dot2_spec3_const(i, 1);
    end
    if dot2_spec3_const(i, 2) == 4
        columnMean4 = columnMean4 + dot2_spec3_const(i, 1);
    end
    
end


columnMean1 = columnMean1 / total_trials;
columnMean2 = columnMean2 / total_trials;
columnMean3 = columnMean3 / total_trials;
columnMean4 = columnMean4 / total_trials;
scatter([1 2 3 4], [columnMean1 columnMean2 columnMean3 columnMean4]);
    
% /////////////////////////////////////////////////////////////////////////////////
% /////////////////////////////////////////////////////////////////////////////////



%Data Analysis


clear % clean up the workspace

% Read in data to a cell object
file = fopen('data_with_factors2.txt');
columnNames = textscan(file,'%s %s %s %s %s %s %s %s', 1);
data = cell2mat(textscan(file, '%d %d %d %d %d %d %d %d', 'Delimiter', '\t'));
    
fclose(file);
celldisp(columnNames);
% Give the cell position numbers more useful names
% perc_depth = 1; 
% distance = 2;
% objSize = 3; % *** can't call this one "size" because SIZE is an important built-in function ***
% sample = 4;
% repetition = 5;
% trialN = 6;
% subjName = 7;

subject_num = 1; 
trial = 2;
probe_length = 3;
react_time = 4;
stiumulus_type = 5;
depth = 6;
specularity = 7;
dot_pos = 8;

% This time, we need the matrix to have three dimensions: SUBJECT x DISTANCE x SIZE
subjects = unique(data(:,subject_num)); % What are the unique values of variable "subjName"?
nSubj = length(subjects); % How many subjects?
depths = unique(data(:,depth)); % What are the unique values of variable "distance"?
nDepths = numel(depths); % How many distances?
objSpecularities = unique(data(:,specularity)); % What are the unique values of variable "size"?
nSpecularities = numel(objSpecularities); % How many sizes
objDot = unique(data(:,dot_pos)); % What are the unique values of variable "size"?
nDot = numel(objDot);

mean_sbXdistXsz = zeros(nSubj,nDepths,nSpecularities, nDot); % initialize the output matrix

%%%%%%%%%%%%%%%%%%%
%%%% QUESTIONS %%%%
%%%%%%%%%%%%%%%%%%%

% 7a. Complete the 3rd nested for-loop so that we compute averages for subject-distance-size combinations.
% Loop over dimension 1 variable (index values starting at 1)
for sb = 1:nSubj
    % Find out which observations belong to the current level of variable 1
    rows_sb = find(data(:, 1) == subjects(sb));
    % Loop over dimension 2 variable (index values starting at 1)
    for dep = 1:nDepths
        % Find out which observations belong to the current level of variable 2
        rows_depth = find(data(:,depth) == depths(dep));
        % Loop over dimension 3 variable (index values starting at 1)
        for sz = 1:nSpecularities
            % Find out which observations belong to the current level of variable 2
            rows_specularity = find(data(:,specularity) == objSpecularities(sz));
            % for env = 1:nEnvs
             %   rows_envs = find(data(:, env_type) == objEnv(env)); 
            for dot = 1: nDot
                    rows_dot = find(data(:,dot_pos) == objDot(dot));
                    % Get the subset of data you are interested in by using the row index vectors you obtained above
                    %intersections = intersect(intersect(intersect(
                    intersections = intersect(rows_sb, rows_depth);
                    intersections2 = intersect(intersections, rows_specularity);
                    intersections3 = intersect(intersections, rows_dot);
                    %, rows_specularity), rows_envs), rows_dot);
                    probLength = data(:,probe_length);
                    cellData = probLength(intersections3);
                    % Compute the cell mean and store it in the table in the right place
                    mean_sbXdistXsz(sb,dep,sz,dot) = mean(cellData);
                
            end
        end
    end
end


t = table(subjects, mean_sbXdistXsz(:,1,1,1), mean_sbXdistXsz(:,2,1,1), ...
    mean_sbXdistXsz(:,1,2,1), mean_sbXdistXsz(:,2,2,1), mean_sbXdistXsz(:,1,3,1),mean_sbXdistXsz(:,2,3,1), mean_sbXdistXsz(:,1,1,2), ...
    mean_sbXdistXsz(:,2,1,2), mean_sbXdistXsz(:,1,2,2), mean_sbXdistXsz(:,2,2,2), mean_sbXdistXsz(:,1,3,2),  ...
    mean_sbXdistXsz(:,2,3,2), ...
    mean_sbXdistXsz(:,3,1,1), mean_sbXdistXsz(:,4,1,1), ...
    mean_sbXdistXsz(:,3,2,1), mean_sbXdistXsz(:,4,2,1), mean_sbXdistXsz(:,3,3,1),mean_sbXdistXsz(:,4,3,1), mean_sbXdistXsz(:,3,1,2), ...
    mean_sbXdistXsz(:,4,1,2), mean_sbXdistXsz(:,3,2,2), mean_sbXdistXsz(:,4,2,2), mean_sbXdistXsz(:,3,3,2),  ...
    mean_sbXdistXsz(:,4,3,2), ...
    'VariableNames',{'subject','c1','c2','c3','c4', 'c5', 'c6','c7','c8', 'c9', 'c10', 'c11', 'c12', 'c13', 'c14', 'c15', 'c16', 'c17', 'c18', 'c19', 'c20', 'c21', 'c22', 'c23', 'c24' });

WD = table({'D1';'D2';'D1';'D2';'D1';'D2';'D1';'D2';'D1';'D2';'D1';'D2';'D3';'D4';'D3';'D4';'D3';'D4';'D3';'D4';'D3';'D4';'D3';'D4'}, {'LowSpec';'LowSpec';'MedSpec';'MedSpec';'HighSpec';'HighSpec';'LowSpec';'LowSpec';'MedSpec';'MedSpec';'HighSpec';'HighSpec';'LowSpec';'LowSpec';'MedSpec';'MedSpec';'HighSpec';'HighSpec';'LowSpec';'LowSpec';'MedSpec';'MedSpec';'HighSpec';'HighSpec'}, {'Dot1';'Dot1';'Dot1';'Dot1';'Dot1';'Dot1';'Dot2';'Dot2';'Dot2';'Dot2';'Dot2';'Dot2';'Dot1';'Dot1';'Dot1';'Dot1';'Dot1';'Dot1';'Dot2';'Dot2';'Dot2';'Dot2';'Dot2';'Dot2';}, ...
    'VariableNames', {'depth','specularity','dot'});

RM = fitrm(t, 'c1-c24 ~ 1', 'WithinDesign',WD);

ranova(RM, 'WithinModel', 'depth*specularity*dot')

