

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PROC_SET_INT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PROC_SET_INT ***

  CREATE OR REPLACE PROCEDURE BARS.P_PROC_SET_INT (p_kodf_ IN VARCHAR2, p_sheme_ IN VARCHAR2,
                                o_nbuc_ OUT VARCHAR2, o_typ_ OUT NUMBER) IS
 ------------------------------------------------------------------------------------
 -- ��� ���������� ������ ���������� ��������� 
 -- 25-05-2012 �� ��������� - ����� �
 -- ������:  28/02/2017 (25.05.2012)
 ------------------------------------------------------------------------------------
 -- ������� ����������
 -- ������������� ��������� ��� ����������� ����������
 -- ���������: p_kodf_ - ��� �������
 --            p_sheme_ - ����� ������������
 -- ������������ ��������: o_typ_ - ������ ������������ ������ � ������� �����
 --                 �������� � ����� �������������
 --        o_nbuc_ - ��� �������, ��� ��� ��� ������� + ��� ������������� (��� o_typ_=3)
 ------------------------------------------------------------------------------------
    b041_ VARCHAR2(20);
    kf_   VARCHAR2(20) := bc.current_mfo;    
BEGIN
    begin
        SELECT DISTINCT ZZZ, NVL(pr_tobo, 0)
        INTO o_nbuc_, o_typ_
        FROM KL_F00_INT
        WHERE KODF=p_kodf_ AND
              A017 in (p_sheme_,'C','G');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             o_nbuc_:='';
             o_typ_:=0;
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20001,'Error in procedure p_proc_set: '||SQLERRM);
    end;
    
    if kf_ in ('324805', '322669') and
       o_typ_ = 0
    then
       o_typ_ := 4;
    end if;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PROC_SET_INT.sql =========*** En
PROMPT ===================================================================================== 