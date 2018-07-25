SET SERVEROUTPUT ON 
BEGIN
    BRANCH_ATTRIBUTE_UTL.CREATE_ATTRIBUTE(P_ATTRIBUTE_CODE => 'ADR_BRANCH_ENG', 
                                          P_ATTRIBUTE_NAME => 'Àäðåñà ô³ë³¿ àíãë³éñüêîþ ìîâîþ', 
                                          P_ATTRIBUTE_DATATYPE => 'C');

    BRANCH_ATTRIBUTE_UTL.CREATE_ATTRIBUTE(P_ATTRIBUTE_CODE => 'TOWN_ENG', 
                                          P_ATTRIBUTE_NAME => 'Ì³ñòî ô³ë³¿ àíãë³éñüêîþ ìîâîþ', 
                                          P_ATTRIBUTE_DATATYPE => 'C');

    BRANCH_ATTRIBUTE_UTL.CREATE_ATTRIBUTE(P_ATTRIBUTE_CODE => 'BRANCH_NAME_ENG', 
                                          P_ATTRIBUTE_NAME => 'Íàçâà ô³ë³¿ àíãë³éñüêîþ ìîâîþ', 
                                          P_ATTRIBUTE_DATATYPE => 'C');
    
    --äîáàâëÿåì àíãë.íàçâàíèå ÐÓ ïî ñïèñêó âñåì, êòî óæå â ììôî 
    FOR K IN (SELECT MFO,ENG FROM (
                    select '/322669/' mfo,'ô³ë³¿ - ÃÓ ïî ì. Êèºâó òà Êè¿âñüê³é îáë. ÀÒ "Îùàäáàíê"' name   ,'the PJSC “State Savings Bank of Ukraine” Kyiv Regional Directorate' eng from dual union
                    select '/302076/','ô³ë³¿ - Â³ííèöüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'        ,'the PJSC “State Savings Bank of Ukraine” Vinnitsa Regional Directorate'         from dual union
                    select '/303398/','ô³ë³¿ - Âîëèíñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'        ,'the PJSC “State Savings Bank of Ukraine” Volyn Regional Directorate'            from dual union
                    select '/305482/','ô³ë³¿ - Äí³ïðîïåòðîâñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"' ,'the PJSC “State Savings Bank of Ukraine” Dnipropetrovsk Regional Directorate'   from dual union
                    select '/335106/','ô³ë³¿ - Äîíåöüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'         ,'the PJSC “State Savings Bank of Ukraine” Donetsk Regional Directorate'          from dual union
                    select '/311647/','ô³ë³¿ - Æèòîìèðñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'      ,'the PJSC “State Savings Bank of Ukraine” Zhytomyr Regional Directorate'         from dual union
                    select '/312356/','ô³ë³¿ - Çàêàðïàòñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'     ,'the PJSC “State Savings Bank of Ukraine” Zakarpattia Regional Directorate'      from dual union
                    select '/313957/','ô³ë³¿ - Çàïîð³çüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'       ,'the PJSC “State Savings Bank of Ukraine” Zaporizhzhia Regional Directorate'     from dual union
                    select '/336503/','ô³ë³¿ - ²âàíî-Ôðàíê³âñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"','the PJSC “State Savings Bank of Ukraine” Ivano-Frankivsk Regional Directorate'  from dual union
                    select '/323475/','ô³ë³¿ - Ê³ðîâîãðàäñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'   ,'the PJSC “State Savings Bank of Ukraine” Kirovohrad Regional Directorate'       from dual union
                    select '/304665/','ô³ë³¿ - Ëóãàíñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'        ,'the PJSC “State Savings Bank of Ukraine” Luhansk Regional Directorate'          from dual union
                    select '/325796/','ô³ë³¿ - Ëüâ³âñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê" '       ,'the PJSC “State Savings Bank of Ukraine” Lviv Regional Directorate'             from dual union
                    select '/326461/','ô³ë³¿ - Ìèêîëà¿âñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'     ,'the PJSC “State Savings Bank of Ukraine” Mykolaiv Regional Directorate'         from dual union
                    select '/328845/','ô³ë³¿ - Îäåñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'          ,'the PJSC “State Savings Bank of Ukraine” Odesa Regional Directorate'            from dual union
                    select '/331467/','ô³ë³¿ - Ïîëòàâñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'       ,'the PJSC “State Savings Bank of Ukraine” Poltava Regional Directorate'          from dual union
                    select '/333368/','ô³ë³¿ - Ð³âíåíñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'       ,'the PJSC “State Savings Bank of Ukraine” Rivne Regional Directorate'            from dual union
                    select '/337568/','ô³ë³¿ - Ñóìñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'          ,'the PJSC “State Savings Bank of Ukraine” Sumy Regional Directorate'             from dual union
                    select '/338545/','ô³ë³¿ - Òåðíîï³ëüñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'    ,'the PJSC “State Savings Bank of Ukraine” Ternopil Regional Directorate'         from dual union
                    select '/351823/','ô³ë³¿ - Õàðê³âñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'       ,'the PJSC “State Savings Bank of Ukraine” Kharkiv Regional Directorate'          from dual union
                    select '/352457/','ô³ë³¿ - Õåðñîíñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'       ,'the PJSC “State Savings Bank of Ukraine” Kherson Regional Directorate'          from dual union
                    select '/315784/','ô³ë³¿ - Õìåëüíèöüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'      ,'the PJSC “State Savings Bank of Ukraine” Khmelnytskyi Regional Directorate'     from dual union
                    select '/354507/','ô³ë³¿ - ×åðêàñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'        ,'the PJSC “State Savings Bank of Ukraine” Cherkasy Regional Directorate'         from dual union
                    select '/356334/','ô³ë³¿ - ×åðí³âåöüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'      ,'the PJSC “State Savings Bank of Ukraine” Chernivtsi Regional Directorate'       from dual union
                    select '/353553/','ô³ë³¿ - ×åðí³ã³âñüêå îáëàñíå óïðàâë³ííÿ ÀÒ "Îùàäáàíê"'     ,'the PJSC “State Savings Bank of Ukraine” Chernihiv Regional Directorate'        from dual) en
                JOIN MV_KF ON '/'||KF||'/' = MFO)
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Äîáàâëÿåì â àòðèáóòû BRANCH_NAME_ENG äëÿ '||K.MFO || '-'||K.ENG);
        BRANCH_ATTRIBUTE_UTL.set_attribute_value(P_BRANCH_CODE    => K.MFO, 
                                         P_ATTRIBUTE_CODE => 'BRANCH_NAME_ENG', 
                                         P_ATTRIBUTE_VALUE => K.ENG);
    END LOOP;
	COMMIT;
END;
/
SET SERVEROUTPUT OFF
    