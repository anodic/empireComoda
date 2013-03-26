%% settings
dataLocation = 'LDOS-CoMoDa-forEMPIRE.xls';
personalityProfileLocation = 'big5_working.xlsx';

minRatingsPerUser = 25;
minRatingsPerClass = 10;
persThreshold = 50;

data = xlsread(dataLocation);
personality = xlsread(personalityProfileLocation);
%% counting occurences
% contingency table dVert = neutral/notneutral; dHor = alone/notAlone

% column 14 = endEmo; column 13 = social;

persParams = [1,2,4];

for k = 1:length(persParams)
    
    personalityParam = persParams(k);
    
    emotionAndSocialTable = zeros(2,2);
    
    
    % personality param < 50
    for i = 1: size(data,1)
        % data(i,[1,2,3,13,14])
        if (data(i,13)==1 && data(i,14)==7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)<persThreshold )
            emotionAndSocialTable(1,1) = emotionAndSocialTable(1,1)+1;
            
        elseif (data(i,13)==1 && data(i,14)~=7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)<persThreshold )
            emotionAndSocialTable(2,1) = emotionAndSocialTable(2,1)+1;
            
        elseif (data(i,13)~=1 && data(i,14)==7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)<persThreshold )
            emotionAndSocialTable(1,2) = emotionAndSocialTable(1,2)+1;
            
        elseif (data(i,13)~=1 && data(i,14)~=7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)<persThreshold )
            emotionAndSocialTable(2,2) = emotionAndSocialTable(2,2)+1;
        else
            continue;
        end
    end
    
    disp(['emotion/social table for  persParam ' num2str(personalityParam) ';<50:'])
    disp(emotionAndSocialTable);
    
    notNeutralProportionAverage = sum(emotionAndSocialTable(2,:))/(sum(sum(emotionAndSocialTable)));
    notNeutralProportionAlone = emotionAndSocialTable(2,1)/sum(emotionAndSocialTable(:,1));
    notNeutralProportionNotAlone = emotionAndSocialTable(2,2)/sum(emotionAndSocialTable(:,2));
    
    disp(['For persParam '  num2str(personalityParam) '; <50: emotion average = ' num2str(notNeutralProportionAverage), '%; emotion when alone =  ' num2str(notNeutralProportionAlone) '%; emotion when with company = ' num2str(notNeutralProportionNotAlone) '%.']);
    emotionAndSocialTable = zeros(2,2);
    
    % personality param >= 50
    for i = 1: size(data,1)
        % data(i,[1,2,3,13,14])
        if (data(i,13)==1 && data(i,14)==7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)>=persThreshold )
            emotionAndSocialTable(1,1) = emotionAndSocialTable(1,1)+1;
            
        elseif (data(i,13)==1 && data(i,14)~=7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)>=persThreshold )
            emotionAndSocialTable(2,1) = emotionAndSocialTable(2,1)+1;
            
        elseif (data(i,13)~=1 && data(i,14)==7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)>=persThreshold )
            emotionAndSocialTable(1,2) = emotionAndSocialTable(1,2)+1;
            
        elseif (data(i,13)~=1 && data(i,14)~=7 && any(personality(:,1) == data(i,1)) &&  personality(find(personality(:,1)==data(i,1)),1+personalityParam)>=persThreshold )
            emotionAndSocialTable(2,2) = emotionAndSocialTable(2,2)+1;
        else
            continue;
        end
    end
    
    disp(['emotion/social table for  persParam ' num2str(personalityParam) ';>=50:'])
    disp(emotionAndSocialTable);
    
    notNeutralProportionAverage = sum(emotionAndSocialTable(2,:))/(sum(sum(emotionAndSocialTable)));
    notNeutralProportionAlone = emotionAndSocialTable(2,1)/sum(emotionAndSocialTable(:,1));
    notNeutralProportionNotAlone = emotionAndSocialTable(2,2)/sum(emotionAndSocialTable(:,2));
    
    disp(['For persParam ' num2str(personalityParam) '; >= 50: emotion average = ' num2str(notNeutralProportionAverage), '%; emotion when alone =  ' num2str(notNeutralProportionAlone) '%; emotion when with company = ' num2str(notNeutralProportionNotAlone) '%.']);
    
end