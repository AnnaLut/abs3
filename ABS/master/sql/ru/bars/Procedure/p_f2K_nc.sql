CREATE OR REPLACE procedure p_f2K_nc(Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #2K для схема "C" 
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 09.06.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f2K_NN (Dat_,'C');
end;
/

show err;

begin
    execute immediate 'DROP PUBLIC SYNONYM p_f2K_nc';
exception
    when others then null;
end;
/    

create or replace public synonym p_f2K_nc for bars.p_f2K_nc;
grant execute on p_f2K_nc to rpbn002;
/


