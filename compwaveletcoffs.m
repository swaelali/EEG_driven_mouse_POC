function  reduced_feature_dataset = compwaveletcoffs(feature_dataset)
Me1=[]; S1=[]; Ma1=[]; Mi1=[];
Me2=[]; S2=[]; Ma2=[]; Mi2=[];
Me3=[]; S3=[]; Ma3=[]; Mi3=[];
Me4=[]; S4=[]; Ma4=[]; Mi4=[];
for i=1:100
    X=feature_dataset(i,:);
    [c,s]=wavedec2(X,4,'db4');
    [H1,V1,D1] = detcoef2('all',c,s,1);
    A1 = appcoef2(c,s,'db4',1);
    [H2,V2,D2] = detcoef2('all',c,s,2);
    A2 = appcoef2(c,s,'db4',2);
    [H3,V3,D3] = detcoef2('all',c,s,3);
    A3 = appcoef2(c,s,'db4',3);
    [H4,V4,D4] = detcoef2('all',c,s,4);
    A4 = appcoef2(c,s,'db4',4);
    MeH1 = mean(H1(1,:));
    MeV1 = mean(V1(1,:));
    MeD1 = mean(D1(1,:));
    Mean1 = MeH1+MeV1+MeD1;
    Me1=[Me1;Mean1];
    stdH1 = std(H1(1,:));
    stdV1 = std(V1(1,:));
    stdD1 = std(D1(1,:));
    Std1 = stdH1+stdV1+stdD1;
    S1=[S1;Std1];
    MxH1 = max(H1(1,:));
    MxV1 = max(V1(1,:));
    MxD1 = max(D1(1,:));
    Max1 = MxH1+MxV1+MxD1;
    Ma1=[Ma1;Max1];
    MiH1 = min(H1(1,:));
    MiV1 = min(V1(1,:));
    MiD1 = min(D1(1,:));
    Min1 = MiH1+MiV1+MiD1;
    Mi1=[Mi1;Min1];
    
    MeH2 = mean(H2(1,:));
    MeV2 = mean(V2(1,:));
    MeD2 = mean(D2(1,:));
    Mean2 = MeH2+MeV2+MeD2;
    Me2=[Me2;Mean2];
    stdH2 = std(H2(1,:));
    stdV2 = std(V2(1,:));
    stdD2 = std(D2(1,:));
    Std2 = stdH2+stdV2+stdD2;
    S2=[S2;Std2];
    MxH2 = max(H2(1,:));
    MxV2 = max(V2(1,:));
    MxD2 = max(D1(1,:));
    Max2 = MxH2+MxV2+MxD2;
    Ma2=[Ma2;Max2];
    MiH2 = min(H2(1,:));
    MiV2 = min(V2(1,:));
    MiD2 = min(D2(1,:));
    Min2 = MiH2+MiV2+MiD2;
    Mi2=[Mi2;Min2];
    
    MeH3 = mean(H3(1,:));
    MeV3 = mean(V3(1,:));
    MeD3 = mean(D3(1,:));
    Mean3 = MeH3+MeV3+MeD3;
    Me3=[Me3;Mean3];
    stdH3 = std(H3(1,:));
    stdV3 = std(V3(1,:));
    stdD3 = std(D3(1,:));
    Std3 = stdH3+stdV3+stdD3;
    S3=[S3;Std3];
    MxH3 = max(H3(1,:));
    MxV3 = max(V3(1,:));
    MxD3 = max(D3(1,:));
    Max3 = MxH3+MxV3+MxD3;
    Ma3=[Ma3;Max3];
    MiH3 = min(H3(1,:));
    MiV3 = min(V3(1,:));
    MiD3 = min(D3(1,:));
    Min3 = MiH3+MiV3+MiD3;
    Mi3=[Mi3;Min3];
    
    MeH4 = mean(H4(1,:));
    MeV4 = mean(V4(1,:));
    MeD4 = mean(D4(1,:));
    Mean4 = MeH4+MeV4+MeD4;
    Me4=[Me4;Mean4];
    stdH4 = std(H4(1,:));
    stdV4 = std(V4(1,:));
    stdD4 = std(D4(1,:));
    Std4 = stdH4+stdV4+stdD4;
    S4=[S4;Std4];
    MxH4 = max(H4(1,:));
    MxV4 = max(V4(1,:));
    MxD4 = max(D4(1,:));
    Max4 = MxH4+MxV4+MxD4;
    Ma4=[Ma4;Max4];
    MiH4 = min(H4(1,:));
    MiV4 = min(V4(1,:));
    MiD4 = min(D4(1,:));
    Min4 = MiH4+MiV4+MiD4;
    Mi4=[Mi4;Min4];
    
    MeA4 = mean(A4(1,:));
    stdA4 = std(A4(1,:));
    MxA4 = max(A4(1,:));
    MiA4 = min(A4(1,:));

end
reduced_feature_dataset=[Me1 S1 Ma1 Mi1 Me2 S2 Ma2 Mi2 Me3 S3 Ma3 Mi3 Me4 S4 Ma4 Mi4];
end

