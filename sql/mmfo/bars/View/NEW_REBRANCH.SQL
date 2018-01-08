CREATE OR REPLACE FORCE VIEW BARS.NEW_REBRANCH as 
select branch BR_OLD,                       
       nls    NLSO,                         
       nms    NMSO,                         
       ostc/100 S,                          
       Substr(PUL.get('BRN'), 1, 15) BR_NEW,   
       nbs_ob22_bra (nbs,ob22, Substr(PUL.get('BRN'), 1, 15)  ) NLSN ,          
       substr( PUL.get('NZN'),1,160) NAZN, KV, ob22  
from accounts 
where dazs is null and branch = PUL.get('BRO') and substr(nbs,1,1) in ('6','7') ;

grant select on NEW_REBRANCH to BARS_ACCESS_DEFROLE ;