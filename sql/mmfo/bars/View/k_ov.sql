

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/K_OV.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view K_OV ***

  CREATE OR REPLACE FORCE VIEW BARS.K_OV ("ACC", "KV", "NLS", "FDAT", "FDAT1", "KOS", "KOS2", "KOS1", "KOM", "KOM2", "KOM1", "OVR") AS 
  select acck,kv,nlsk,bankdate-90,bankdate-30,
 to_char(KOS,     '999,999,999.99'),
 to_char(KOS2,    '999,999,999.99'),
 to_char(KOS-KOS2,'999,999,999.99'),
 to_char(KOM,     '999,999,999.99'),
 to_char(KOM2,    '999,999,999.99'),
 to_char(KOM-KOM2,'999,999,999.99'),
 to_char(round(0.3*((KOS-KOS2)/3+KOM-KOM2)/2,2),'999,999,999.99')
from ( select acck, kv, nlsk,
              SUM(s)   KOS,
              SUM(decode(substr(nlsd,1,4),2000,s,0))  KOS2,
              SUM(iif_d(fdat,bankdate-30,0,0,s))      KOM,
              SUM(iif_d(fdat,bankdate-30,0,0,
                  decode(substr(nlsd,1,4),2000,s,0))) KOM2
      from  provodki
      where substr(nlsk,1,4)=2600 and kv=980 and fdat>=bankdate-90
      group by acck,kv,nlsk
      );

PROMPT *** Create  grants  K_OV ***
grant SELECT                                                                 on K_OV            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on K_OV            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/K_OV.sql =========*** End *** =========
PROMPT ===================================================================================== 
