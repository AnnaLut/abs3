PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_F601.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  $RM_F601 ***
set define off 
declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_F601';
begin   
     -- C������/�������� ���
    umu.cor_arm( l_codearm, '��� "����� 601"', 1);   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '�������� �������� ����� �� ���� 601 � ���',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=v_nbu_601_protocol&accessCode=1&sPar=[PROC=>PUL_DAT(to_char(:Par1,''dd.mm.yyyy''),to_char(:Par2,''dd.mm.yyyy''))][PAR=>:Par1(SEM=��� ���� ���i��� dd_mm_yyyy>,TYPE=D),:Par2(SEM=�i� ���� ���i��� dd_mm_yyyy>,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]', -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );      --(1/0 - ��������������/���������������� ������)
    commit;
	
	-- C������/�������� ���
    umu.cor_arm( l_codearm, '��� "����� 601"', 1);   
    -- ������� �������� �������
    l_codeoper := operlist_adm.add_new_func
                   (p_name      =>     '�������� �������� ����� �� ���� 601 � ��� ������������',          -- ������������ �������
                    p_funcname  =>     '/barsroot/ndi/referencebook/GetRefBookData/?tableName=v_nbu_601_protocol_detail&accessCode=1&sPar=[PROC=>PUL_DAT(to_char(:Par1,''dd.mm.yyyy''),to_char(:Par2,''dd.mm.yyyy''))][PAR=>:Par1(SEM=��� ���� ���i��� dd_mm_yyyy>,TYPE=D),:Par2(SEM=�i� ���� ���i��� dd_mm_yyyy>,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]',  -- ������ ������ �������
                    p_frontend  =>      1 );                       -- 1 - web ���������, 0 - desctop
 
    -- �������� �������� ���
    umu.add_func2arm(l_codeoper, l_codearm, 1 );      --(1/0 - ��������������/���������������� ������)
    commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** END *** ========== Scripts /Sql/Bars/Data/Applist/codeapp_$RM_F601.sql =========*
PROMPT ===================================================================================== 