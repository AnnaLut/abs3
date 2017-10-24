CREATE OR REPLACE procedure p_f2K_ng(Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #2K ��� ����� "G" 
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 09.06.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f2K_NN (Dat_,'G');
end;
/

show err;

begin
    execute immediate 'DROP PUBLIC SYNONYM p_f2K_ng';
exception
    when others then null;
end;
/    

create or replace public synonym p_f2K_ng for bars.p_f2K_ng;
grant execute on p_f2K_ng to rpbn002;
/


