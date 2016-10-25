
Vsvfiles = dir('WCUS_Shen_2012/Vsv_obs/WUSA/*.mod.1');
for i= 1: size(Vsvfiles,1) % original lat lon number
    scanstring = '%f %f %f %f'; % format lat lon Vsv
    gpsfid = fopen(['WCUS_Shen_2012/Vsv_obs/WUSA/',Vsvfiles(i,1).name],'r');
    if(gpsfid == -1)
        error(strcat('Could not read file'), Vsvfiles(i,1).name);
    end
    
    E = textscan(gpsfid, scanstring, 'CommentStyle','#');
    
    
    fclose(gpsfid);
    
    x = E{1};
    y = E{2};
    z = E{3};
    d = E{4};
    
    lon = x(1);
    lat = y(1);
    fprintf('lon is %4.2f, lat is %4.2f\n',lon, lat);
    depth = x(2:end);
    Vsv = y(2:end);
    
    for m= 1:length(depth)
        for n = m+1:length(depth)
            if(depth(m)==depth(n))
                depth(m)=400;
                depth(n)=400;
            end
        end
    end
    %remove the same values
    Vsv(depth==400)=[];
    depth(depth==400) =[];
    
    % GEt the original velocity matrix
    %     VsvM(i,1:length(Vsv)) = Vsv;
    %     depthM(i,1:length(depth)) = depth;
    lont(i) = lon;
    latt(i) = lat;
    depthint = [0:5:200]';
    %     lont(i)=lon;
    %     latt(i)=lat;
    %     lonf = lont';
    %     latf = latt';
    Vsvint(i,:) = interp1(depth,Vsv,depthint,'pchip');
    
    %      if((lont(i)>=244 ) && (lont(i)<=257) && (latt(i)>=31) && (latt(i)<=44))
    %          lontNew(i) = lont(i);
    %          latNew(i) = latt(i);
    %         VsvintNew(i,:) = Vsvint(i,:);
    %      else
    %          lontNew(i)=[];
    %          latNew(i) = [];
    %          VsvintNew(i,:) = [];
    %      end
    %     figure;
    %     plot(depth, Vsv, 'or',depthint,Vsvint,'*b');
    
end


%
%  % IF there is no data for that lat lon, depth, put a Nan there.
%  [row,col] = size(VsvM);
%  for i = 1: row
%     for j  = 1: col
%        if(VsvM(i,j)==0)
%            VsvM(i,j)=nan;
%        end
%     end
%  end
%
%  for i  = 1: row
%      for j = 2:col
%          if(depthM(i,j)==0)
%              depthM(i,j)=nan;
%          end
%      end
%  end
%
%  save('Vsv_observation','latt','lont','depthM','VsvM');

depth = [0:5:200]';
for q = 1:length(depth)
    % Do the interpolation
    [latobs,lonobs] = meshgrid(31:0.25:44, 244:0.25:257);
    numlat = length(latobs(1,:));
    numlon = length(lonobs(:,1));
    
    Vs_obsN = zeros(numlon,numlat);
    
    for s = 1: numlon
        for j = 1:numlat
            for t = 1:length(Vsvint(:,q)) % loop through all the observation points for certain depth
                if((latobs(s,j)==latt(t)) && (lonobs(s,j)==lont(t)))
                    Vs_obsN(s,j) = Vsvint(t,q);
                end
            end
        end
    end
    
    for s = 1:numlon
       for j = 1:numlat
          if(Vs_obsN(s,j)==0)
             Vs_obsNEW(s,j) = nan;
          else
              Vs_obsNEW(s,j) = Vs_obsN(s,j);
          end
       end
        
    end
    
%     
%     [latobsInt,lonobsInt] =  meshgrid(31:0.2:44,244:0.2:257);
%     numlat1 = length(latobsInt(1,:));
%     numlon1 = length(lonobsInt(:,1));
%     Vs_obsInt = interp2(latobs,lonobs,Vs_obsN,latobsInt,lonobsInt,'cubic');
% %     
% %     surf(latobsInt, lonobsInt,Vs_obsInt)
    r = 1;
    % convert matrix to vector;
    for j = 1:numlon
        for s = 1:numlat
            latobsIntF(r,q) = latobs(s,j);
            lonobsIntF(r,q) = lonobs(s,j);
            Vs_obsIntF(r,q) = Vs_obsNEW(s,j);
            r = r +1;
        end
        
    end
%  
end

save('Vs_observation_DepthInt','latobsIntF','lonobsIntF','Vs_obsIntF');