CREATE OR REPLACE procedure p_f3kx_nc(Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования 3KX     для КБ (универсальная)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :   v.18.001          15.02.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f3kx_NN (Dat_,'C');
end;
/

show err;

create or replace public synonym p_f3kx_nc for bars.p_f3kx_nc;
grant execute on p_f3kx_nc to rpbn002;
/

