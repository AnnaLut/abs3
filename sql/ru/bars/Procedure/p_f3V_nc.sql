CREATE OR REPLACE procedure p_f3V_nc(Dat_ DATE, pr_op_ Number default 1)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #3V для схема "C" 
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 16.02.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f3V_NN (Dat_,'C',1);
end;
/

begin
    execute immediate 'DROP PUBLIC SYNONYM p_f3V_nc';
exception
    when others then null;
end;
/    

create public synonym p_f3V_nc for bars.p_f3V_nc;
grant execute on p_f3V_nc to rpbn002;
/

show err;
