SET SERVEROUTPUT ON 
BEGIN
    BRANCH_ATTRIBUTE_UTL.CREATE_ATTRIBUTE(P_ATTRIBUTE_CODE => 'ADR_BRANCH_ENG', 
                                          P_ATTRIBUTE_NAME => '������ ��볿 ���������� �����', 
                                          P_ATTRIBUTE_DATATYPE => 'C');

    BRANCH_ATTRIBUTE_UTL.CREATE_ATTRIBUTE(P_ATTRIBUTE_CODE => 'TOWN_ENG', 
                                          P_ATTRIBUTE_NAME => '̳��� ��볿 ���������� �����', 
                                          P_ATTRIBUTE_DATATYPE => 'C');

    BRANCH_ATTRIBUTE_UTL.CREATE_ATTRIBUTE(P_ATTRIBUTE_CODE => 'BRANCH_NAME_ENG', 
                                          P_ATTRIBUTE_NAME => '����� ��볿 ���������� �����', 
                                          P_ATTRIBUTE_DATATYPE => 'C');
    
    --��������� ����.�������� �� �� ������ ����, ��� ��� � ���� 
    FOR K IN (SELECT MFO,ENG FROM (
                    select '/322669/' mfo,'��볿 - �� �� �. ���� �� ������� ���. �� "��������"' name   ,'the PJSC �State Savings Bank of Ukraine� Kyiv Regional Directorate' eng from dual union
                    select '/302076/','��볿 - ³������� ������� ��������� �� "��������"'        ,'the PJSC �State Savings Bank of Ukraine� Vinnitsa Regional Directorate'         from dual union
                    select '/303398/','��볿 - ��������� ������� ��������� �� "��������"'        ,'the PJSC �State Savings Bank of Ukraine� Volyn Regional Directorate'            from dual union
                    select '/305482/','��볿 - ��������������� ������� ��������� �� "��������"' ,'the PJSC �State Savings Bank of Ukraine� Dnipropetrovsk Regional Directorate'   from dual union
                    select '/335106/','��볿 - �������� ������� ��������� �� "��������"'         ,'the PJSC �State Savings Bank of Ukraine� Donetsk Regional Directorate'          from dual union
                    select '/311647/','��볿 - ����������� ������� ��������� �� "��������"'      ,'the PJSC �State Savings Bank of Ukraine� Zhytomyr Regional Directorate'         from dual union
                    select '/312356/','��볿 - ������������ ������� ��������� �� "��������"'     ,'the PJSC �State Savings Bank of Ukraine� Zakarpattia Regional Directorate'      from dual union
                    select '/313957/','��볿 - ��������� ������� ��������� �� "��������"'       ,'the PJSC �State Savings Bank of Ukraine� Zaporizhzhia Regional Directorate'     from dual union
                    select '/336503/','��볿 - �����-���������� ������� ��������� �� "��������"','the PJSC �State Savings Bank of Ukraine� Ivano-Frankivsk Regional Directorate'  from dual union
                    select '/323475/','��볿 - ʳ������������ ������� ��������� �� "��������"'   ,'the PJSC �State Savings Bank of Ukraine� Kirovohrad Regional Directorate'       from dual union
                    select '/304665/','��볿 - ��������� ������� ��������� �� "��������"'        ,'the PJSC �State Savings Bank of Ukraine� Luhansk Regional Directorate'          from dual union
                    select '/325796/','��볿 - �������� ������� ��������� �� "��������" '       ,'the PJSC �State Savings Bank of Ukraine� Lviv Regional Directorate'             from dual union
                    select '/326461/','��볿 - ����������� ������� ��������� �� "��������"'     ,'the PJSC �State Savings Bank of Ukraine� Mykolaiv Regional Directorate'         from dual union
                    select '/328845/','��볿 - ������� ������� ��������� �� "��������"'          ,'the PJSC �State Savings Bank of Ukraine� Odesa Regional Directorate'            from dual union
                    select '/331467/','��볿 - ���������� ������� ��������� �� "��������"'       ,'the PJSC �State Savings Bank of Ukraine� Poltava Regional Directorate'          from dual union
                    select '/333368/','��볿 - г�������� ������� ��������� �� "��������"'       ,'the PJSC �State Savings Bank of Ukraine� Rivne Regional Directorate'            from dual union
                    select '/337568/','��볿 - ������� ������� ��������� �� "��������"'          ,'the PJSC �State Savings Bank of Ukraine� Sumy Regional Directorate'             from dual union
                    select '/338545/','��볿 - ������������ ������� ��������� �� "��������"'    ,'the PJSC �State Savings Bank of Ukraine� Ternopil Regional Directorate'         from dual union
                    select '/351823/','��볿 - ��������� ������� ��������� �� "��������"'       ,'the PJSC �State Savings Bank of Ukraine� Kharkiv Regional Directorate'          from dual union
                    select '/352457/','��볿 - ���������� ������� ��������� �� "��������"'       ,'the PJSC �State Savings Bank of Ukraine� Kherson Regional Directorate'          from dual union
                    select '/315784/','��볿 - ����������� ������� ��������� �� "��������"'      ,'the PJSC �State Savings Bank of Ukraine� Khmelnytskyi Regional Directorate'     from dual union
                    select '/354507/','��볿 - ��������� ������� ��������� �� "��������"'        ,'the PJSC �State Savings Bank of Ukraine� Cherkasy Regional Directorate'         from dual union
                    select '/356334/','��볿 - ���������� ������� ��������� �� "��������"'      ,'the PJSC �State Savings Bank of Ukraine� Chernivtsi Regional Directorate'       from dual union
                    select '/353553/','��볿 - ���������� ������� ��������� �� "��������"'     ,'the PJSC �State Savings Bank of Ukraine� Chernihiv Regional Directorate'        from dual) en
                JOIN MV_KF ON '/'||KF||'/' = MFO)
    LOOP
        DBMS_OUTPUT.PUT_LINE ('��������� � �������� BRANCH_NAME_ENG ��� '||K.MFO || '-'||K.ENG);
        BRANCH_ATTRIBUTE_UTL.set_attribute_value(P_BRANCH_CODE    => K.MFO, 
                                         P_ATTRIBUTE_CODE => 'BRANCH_NAME_ENG', 
                                         P_ATTRIBUTE_VALUE => K.ENG);
    END LOOP;
	COMMIT;
END;
/
SET SERVEROUTPUT OFF
    