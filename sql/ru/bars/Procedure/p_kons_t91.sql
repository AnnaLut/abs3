CREATE OR REPLACE PROCEDURE BARS.P_Kons_T91 (Dat_ DATE, kodf_ VARCHAR2, sheme_ VARCHAR2 DEFAULT 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ����. �����������
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 31/07/2017 (07/09/2005)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - ����� ����
               kodf_ - ��� ����
               sheme_ - ����� �����������

31.07.2017 - ��������� ���������������� ������ #D3, #C9, #E2, #70
26.08.2009 - ��������� ���������������� ����� #1A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
pr_tobo_ KL_F00.PR_TOBO%TYPE;

BEGIN
   BEGIN
      SELECT pr_tobo INTO pr_tobo_
      FROM KL_F00
      WHERE kodf=kodf_
        AND a017=sheme_;
   EXCEPTION
             WHEN NO_DATA_FOUND THEN
      pr_tobo_ :=  -1;
   END;

   IF kodf_ = 'D3' THEN
      P_FileD3(Dat_);
   ELSIF kodf_ = 'C9' THEN
      P_FileC9(Dat_);
   ELSIF kodf_ = 'E2' THEN
      P_FileE2(Dat_);
   ELSIF kodf_ = '70' THEN
      P_File70(Dat_);
   -- ����������� ��� ����� � ������
   ELSIF NVL(pr_tobo_, -1) = 0 THEN
      P_Kons_Whole(Dat_, kodf_, sheme_);
   ELSE
      NULL;
   END IF;
END;
/

show err;

begin
    execute immediate 'DROP PUBLIC SYNONYM p_kons_t91';
exception
    when others then null;
end;
/    

create public synonym p_kons_t91 for bars.p_kons_t91;
grant execute on p_kons_t91 to rpbn002;
/
