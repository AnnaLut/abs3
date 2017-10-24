

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_UPD_R012.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_UPD_R012 ***

  CREATE OR REPLACE PROCEDURE BARS.P_UPD_R012 (kodf_ in varchar2 default 'A7',
                                            mfou_ in number default null) as
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура заповнення параметру R012 по довіднику з Ощаду
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.17.001        10.02.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
    merge into specparam s
    using (select unique a.acc, nvl(b.r012, '0') r012
           from otcn_saldo a, spr_r020_r012 b
           where a.ost <> 0 and
               a.nbs = b.r020 and
               (decode(sign(ost),-1,1,2) = b.t020 or b.t020 = '3') and
               trim(b.r012) is not null and
               not exists (select 1 
                           from specparam z
                           where z.acc = a.acc and
                                 z.r012 = b.r012) 
           ) c
    on (s.acc = c.acc)
    WHEN MATCHED THEN 
        UPDATE SET s.r012 = c.r012
    WHEN NOT MATCHED THEN 
        INSERT (s.acc, s.r012)
        values (c.acc, c.r012); 
    commit;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_UPD_R012.sql =========*** End **
PROMPT ===================================================================================== 
