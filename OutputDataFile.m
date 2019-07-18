output_file = fopen('subj_data.txt', 'w');
factorM = [1 1 1 1;
           1 1 2 1;
           1 2 1 1;
           1 2 2 1;
           1 3 1 1;
           1 3 2 1;
           2 1 1 1;
           2 1 2 1;
           2 2 1 1;
           2 2 2 1;
           2 3 1 1;
           2 3 2 1;
           1 1 1 2;
           1 1 2 2;
           1 2 1 2;
           1 2 2 2;
           1 3 1 2;
           1 3 2 2;
           2 1 1 2;
           2 1 2 2;
           2 2 1 2;
           2 2 2 2;
           2 3 1 2;
           2 3 2 2];

for subj = 7
    file = fopen(strcat('subj', int2str(subj), '.txt'));
    % columnNames = textscan(file,'%s %s %s %s %s', 1);
   % fprintf(output_file, 'Subject\t Trial\t ProbeL\t RT\t StimulusType\t\n');
    data = cell2mat(textscan(file, '%d %d %d %d %d', 'Delimiter', '\t'));
    new = zeros(96,9);
    for i = 1:96
        new(i,:) = [data(i,:),factorM(data(i,5),:)];
    end
    fprintf(output_file, '%d %d %d %d %d\n', new');
end






factor1 = 1:2; % Factor "Shape" has 2 levels
factor2 = 1:3; % Factor "Specularity" has 2 levels
factor3 = 1:2; % Environment has 2 levels
factor4 = 1:2; % Dot position has 2 levels

       
1 = 1,1,1,1
2 = 1,1,2,1
3 = 1,2,1,1
4 = 1,2,2,1
5 = 1,3,1,1
6 = 1,3,2,1
7 = 2,1,1,1
8 = 2,1,2,1
9 = 2,2,1,1
10 = 2,2,2,1
11 = 2,3,1,1
12 = 2,3,2,1

13 = 1,1,1,2
14 = 1,1,2,2
15 = 1,2,1,2
16 = 1,2,2,2
17 = 1,3,1,2
18 = 1,3,2,2
19 = 2,1,1,2
20 = 2,1,2,2
21 = 2,2,1,2
22 = 2,2,2,2
23 = 2,3,1,2
24 = 2,3,2,2

