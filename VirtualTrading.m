%% Initial Configuration 
% Setting initial number of agents -- so far SPs, RPs, VNBs and SUs
% Resource configuration -- max/min amount of resources per RP, initial
% amount of resources per SP
% Initial traffic configuration - traffic mean for exp distribution and capacity per resource unit
% Initial market configuration -- so far, initial fee that the VNB will
% charge.

%clear all;

global numSPs numRPs numVNBs sp_numSUs rp_numSUs sp rp vnb spSU rpSU entireDemand entireOffer handles demandTotals offerTotals rp_maxResourcAmt rp_minResourcAmt pool_RT
global sp_initRscAmt rscUnitCap trafficMean vnbFee maxTrafficDemand A rscSupplyType1 rscSupplyType2  rscDemandType1 rscDemandType2 marketDemandType1 marketDemandType2 totPartnersMatrix vnb_Demand1 vnb_Demand2
%marketDemandType1 and marketDemandType2 represent the demand of the VNBs
%after they have formed a partnership with the SPs. 
%rscDemandType1 and rscDemandType2 are the demand of all SPs, before they
%form partnerships with the VNBs.


%global supplyRsc1 supplyRsc2

%[numSPs, numRPs, numVNBs, sp_numSUs, rp_numSUs] = VTConfig;

% fileID1 = fopen('VNB_partnerships_test2_e24.csv','a');
% formatSpec1 = '%s, %s, %s, %s, %s, %s, %s\n ';
% fprintf(fileID1,formatSpec1, 'RUN','ID','GROUP','BEHAVIOR','partnersID','totPartners', 'PAYMENT');
% 
% fclose(fileID1);
% 
% fileID2 = fopen('VNBDemand_test2_e24.csv','a');
% formatSpec2 = '%s, %s, %s, %s, %s, %s, %s\n';
% fprintf(fileID2,formatSpec2, 'RUN', 'ID', 'GROUP', 'BEHAVIOR', 'totPartners', 'dType1', 'dType2');
% fclose(fileID2);
% 
% fileID3 = fopen('SP_priceToPay_test2_e24.csv','a');
% formatSpec3 = '%s, %s, %s, %s, %s, %s, %s, %s\n';
% fprintf(fileID3,formatSpec3,'RUN', 'ID', 'GROUP', 'BEHAVIOR', 'vnbPartner', 'maxPrice', 'advPrice', 'FEE');
% fclose(fileID3);
% 
% fileID4 = fopen('SP_demand_test2_e24.csv','a');
% formatSpec4 = '%s, %s, %s, %s, %s, %s, %s\n';
% fprintf(fileID4,formatSpec4, 'RUN', 'ID', 'GROUP', 'BEHAVIOR', 'partnerID', 'TYPE', 'DEMAND');
% fclose(fileID4);

%for i =1:1:3000
[rp_maxResourcAmt, rp_minResourcAmt, sp_initRscAmt] = rscConfig;
[rscUnitCap, trafficMean, maxTrafficDemand] = trafficConfig;
[vnbFee] = marketInitConfig;

%% Initialize RPs, SPs and VNBs

sp = initServProvider(numSPs, sp_numSUs, numVNBs, sp_initRscAmt);
rp = initRscProvider(numRPs, rp_maxResourcAmt, rp_minResourcAmt, numVNBs);
vnb = initVNB(numVNBs, numRPs, numSPs, rp, sp, vnbFee);

%% Configure real and advertised prices
sp = configPrice_SP(sp, numSPs);
vnb = configPrice_VNB(vnb, numVNBs, numRPs, numSPs, rp, sp, vnbFee);
rp = configPrice_RP(rp, numRPs);

%% Initialize customers of RPs and SPs and VNBs
% Set the traffic associated with each of them 
% Define the resulting trafficToServe for both, RPs and SPs

[spSU, sp] = initSPSUs(numSPs, sp_numSUs, trafficMean, sp);
[rpSU, rp] = initRPSUs(numRPs, rp_numSUs, trafficMean, rp);

% This should be done through matching markets - right now is just done for
% the RP - VNB matching.
vnb = vnbCustomerAsgmt(numVNBs, numRPs, numSPs, rp, sp, vnb);

%%
demandTotals = [];
offerTotals = [];
entireOffer = [];
entireDemand = [];
%%
%for i = 1:1:100
    
%% Generate new End user traffic

[spSU] =  genSUTraffic_SP(spSU, trafficMean);
[rpSU] =  genSUTraffic_RP(rpSU, trafficMean);
%% Update the new traffic information in the corresponding SP
[sp, spSU] = updateSUTraffic_SP(sp, spSU);

%% Update the new traffic information in the corresponding RP
[rp, rpSU] = updateSUTraffic_RP(rp, rpSU);

%% Calculate offers from Resource Providers
% This results from calculating the coverable traffic based on the Rsc
% amount of each RP and the capacity per Rsc unit. 
% Offers are the free resources that RPs have after covering their own
% traffic demand

[rpSU, rp] = calcOffers(rp, numRPs, rpSU, rp_numSUs, rscUnitCap);

%% Create pool

[pool_RT, rscSupplyType1, rscSupplyType2, pool_type1, pool_type2, pool1, pool2] = createPool(rp, numRPs);

% %% Define Supply
% [pool_RT, totSupply, supplyRsc1, supplyRsc2] = calcSupply(rp,numRPs,pool_RT, rscAmountType1, rscAmountType2);

%% Calculate demand from Service Providers
% This results from calculating the coverable traffic based on the Rsc that
% each SP has and the capacity per Rsc unit. 
% We calculate the coverable traffic and compare it to the Traffic to
% Serve. An SP demand corresponds to the difference between the traffic to
% serve and the coverable traffic

[spSU, sp, rscDemandType1, rscDemandType2] = calcDemand(sp, numSPs, spSU, sp_numSUs, rscUnitCap, maxTrafficDemand, trafficMean);

%% Update the SP-VNB partnerships
% This part of the code serves to define the matching of the SPs and VNBs
% according to their preferences. 
% First - define the preferences of the SPs looking at the available VNBs.
% Second - define the preferences of the VNBs looking at the available SPs.
% Third  - Create the preference matrix
% Fourth - Find matchings

%[sp,vnb] = defSP_Preferences(sp,vnb, numSPs, numVNBs);
%[sp, vnb] = preferencesSP_VNB(sp, vnb, numSPs, numVNBs);
%[sp,vnb,A,SP_utility, VNB_utility]= preferencesSP_VNB2(sp,vnb,numSPs,numVNBs);
[sp,vnb,A,SP_utility, VNB_utility]= preferencesSP_VNB3(sp,vnb,numSPs,numVNBs);
%%
% Need code for the matching after finding the preferences
%[vnb, sp] = matching_simple(numSPs, numVNBs, vnb,sp);
%[vnb, sp] = matching_simple2(numSPs, numVNBs, vnb,sp);
[vnb, sp] = matching_simple3(numSPs, numVNBs, vnb,sp);
%% Update the Customers of each VNB
% After the matching process, each VNB and SP update their partnership

[vnb,sp] = updatePartnership(vnb,sp);
%% Update the Inventory of the VNB
% The VNB collects the offers and demand of the RPs and SPs

[rp, sp, vnb, marketDemandType1, marketDemandType2] = updateVNBInv(rp, sp, vnb);

%% Auction test

%[rp, vnb, vnb_Demand1, demandInv_type1, demandInv_type2, demand1, supply1, supply2, data, data1, cutoffPrice, unassignedRsc_VNB, unassignedRsc_RP,  matrixTest, matrixDemand1, matrixTest2, matrixDemand2] = auctionTest(rp,vnb,numVNBs,numRPs, pool1, pool2);
[rp, vnb, vnb_Demand1, demandInv_type1, demand1, supply1, initialAssignment1, finalAssign1, cutoffPrice1, unassignedRsc1_VNB, unassignedRsc1_RP, matrixTest, matrixDemand1, winners1_VNB, winners1_RP, servedMatrix_type1, finalWinners_VNB] = auctionTest1(rp,vnb, numVNBs, numRPs, pool1);
[rp, vnb, vnb_Demand2, demandInv_type2, demand2, supply2, initialAssignment2, finalAssign2, cutoffPrice2, unassignedRsc2_VNB, unassignedRsc2_RP, matrixTest2, matrixDemand2, prelimWinners2_VNB, prelimWinners2_RP, servedMatrix_type2, finalWinners2_VNB] = auctionTest2(rp,vnb, numVNBs, numRPs, pool2);

%% Assign resources to SPs

[rp, vnb, sp] = rscAssignment(rp, vnb, sp, numVNBs, numSPs, numRPs, cutoffPrice1, cutoffPrice2);
%% Print results in a file
% % fileID = fopen('myfile.txt','a');
% % formatSpec = 'Demand Type 1 is %4.2f and Demand Type 2 is %8.2f \n';
% % fprintf(fileID,formatSpec,marketDemandType1,marketDemandType2);
% 
% % ** Print results of the number of partnerships per VNB and their expected
% % payment
% % The header of this file is: RUN NUMBER, VNB ID, VNB EXPERIMENT GROUP, PARTNERS IDS, TOTAL NUM.
% % OF PARTNERS, EXPECTED PAYMENT (total from all partners)
% 
% fileID1 = fopen('VNB_partnerships_test2_e24.csv','a');
% %formatSpec1 = '%s\n';
% formatSpec = '%2d, %2d, %2d, %s, %s, %3d, %4.2f \n';
% %fprintf(fileID1,formatSpec1, datestr(now));
% for j = 1:1:numVNBs
%     totPartners = length(vnb(j).SPCustomer);
%     expPayment = vnb(j).expectPayment;
%     fprintf(fileID1,formatSpec, i, vnb(j).id, vnb(j).Group, vnb(j).behavior, num2str(vnb(j).SPCustomer),totPartners, expPayment);
% end
% 
% fclose(fileID1);
% 
% %** Print results of the demand in the market.
% %The header of this file is: RUN NUMBER, VNB ID, VNB EXPERIMENT GROUP, VNB
% %BEHAVIOR, DEMAND TYPE 1, DEMAND TYPE 2
% fileID2 = fopen('VNBDemand_test2_e24.csv','a');
% formatSpec = '%2d, %2d, %2d, %s, %3d, %4.2f, %4.2f \n';
% 
% for l =1:1:numVNBs
%     demand1 = vnb(l).totalDemand_type1;
%     demand2 = vnb(l).totalDemand_type2;
%     totPartners = length(vnb(j).SPCustomer);
%     fprintf(fileID2,formatSpec,i,vnb(l).id, vnb(l).Group, vnb(l).behavior, totPartners, demand1, demand2);
% end
% 
% fclose(fileID2);
% % Print the results of how much each SP would pay 
% %The header of this file is: RUN NUMBER, SP ID, SP EXPERIMENT GROUP, SP
% %BEHAVIOR, VNB ID, SP MAX PRICE, SP ADV PRICE, SP PRICE TO PAY
% fileID3 = fopen('SP_priceToPay_test2_e24.csv','a');
% formatSpec5 = '%2d, %2d, %2d, %s, %s, %4.2f, %4.2f, %4.2f \n';
% 
% for j =1:1:numSPs
%     fprintf(fileID3,formatSpec5,i,sp(j).id, sp(j).Group, sp(j).behavior, num2str(sp(j).vnb_partner), sp(j).maxPriceVNB, sp(j).advPriceVNB, sp(j).priceToPay);
% end
% fclose(fileID3);
% 
% fileID4 = fopen('SP_demand_test2_e24.csv','a');
% formatSpec5 = '%2d, %2d, %2d, %s, %s, %d, %4.2f \n';
% 
% for j =1:1:numSPs
%     fprintf(fileID4,formatSpec5,i,sp(j).id, sp(j).Group, sp(j).behavior, num2str(sp(j).vnb_partner), sp(j).type, sp(j).demand);
% end
% fclose(fileID4);
% 
% 
% 
% 
% %Create a vector with the number of partners that a VNB has
% for k = 1:1:numVNBs
%     totPartnersMatrix(i,k) = length(vnb(k).SPCustomer);
% end
%-------
%end


%% Define Market Conditions
% Check offer and demand in each VNB and define whether a market is viable
% or not

% [rp, sp, vnb] = vnbMarket(rp, sp, vnb);
%     
%         for j =1:1:numVNBs
%             demandTotals(i,j)=vnb(j).totalDemand;
%             offerTotals(i,j) = vnb(j).totalOffer;
%         end

%pause(2);
%end
%%
% figure
% plot(aggregateDemand);
% hold on
% plot(aggregateOffer);
% legend('Demand', 'Offer');
% xlabel('time');
% ylabel('Aggregate Offer and Demand');
% grid on;

% figure(1)
% for i = 1:1:numVNBs
%     demandPlot = plot(demandTotals(:,i));
%     hold on 
% end
% hold off
% title('Total Demand per VNB');
% xlabel('Time');
% ylabel('Total Demand');
% 
% figure(2)
% for i = 1:1:numVNBs
%      offerPlot =  plot(offerTotals(:,i));
%     hold on
% end
% hold off
% title ('Total Offer per VNB');
% xlabel ('Time');
% ylabel ('Total Offer');
% 
% 
% for i = 1:1:length(demandTotals)
%     entireDemand = [entireDemand sum([demandTotals(i,:)])];
%     entireOffer = [entireOffer sum([offerTotals(i,:)])];
% end
% 
% figure(3)
% plot(entireDemand)
% hold on
% plot(entireOffer)
% hold off
% legend('Aggregate Demand', 'Aggregate Supply');
% grid on
% title('Aggregate Supply and Demand in the market');

% x = 1:max([vnb.id]);
% figure(4)
% scatter3(x,vnb.riskLevel,vnb.SPCustomer,'y')


% figure('Name','VNB Partnerships and Risk Level')
% set(gca,'Xlim',[1 numVNBs],'Ylim',[0 2],'Zlim',[0 numSPs],'xtick',1:1:numVNBs,'Ytick',0:1:2,'Ztick',0:1:numSPs)
% for i = 1:1:numVNBs
%     x = i;
%     y = vnb(i).riskLevel;
%     for j = 1:1:length(vnb(i).SPCustomer)
%     z = vnb(i).SPCustomer(j);
%     
%     scatter3(x,y,z,'filled')
%     hold on
%     end
% end
% xlabel('VNB ID');
% ylabel('VNB Risk Level');
% zlabel('VNB Partners')
% hold off
% 
% 
% figure('Name','Partnerships')
% x1 = [];
% y1 = [];
% hp1 = scatter(x1,y1,'*');
% set(gca,'Xlim',[1 numSPs],...
%         'Ylim',[0 numVNBs],'Ytick',0:1:numVNBs)
% set(hp1,'XDataSource', 'x1') 
% set(hp1,'YDataSource', 'y1') 
% for t = 1:numSPs
% x1(t) = sp(t).id;
% y1(t) = sp(t).vnb_partner;
% refreshdata
% drawnow
% end




% handles.singleOffer = offerTotals;
% handles.singleDemand = demandTotals;
% handles.demand = entireDemand;
% handles.offer = entireOffer;
% guidata(hObject, handles);
%     


