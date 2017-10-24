

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/RA_KWT_2924.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view RA_KWT_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.RA_KWT_2924 ("DAT31", "ACC", "KV", "NLS", "OST31", "NMS", "OSTC", "DATVZ") AS 
  select "DAT31","ACC","KV","NLS","OST31","NMS","OSTC","DATVZ" from
 (
select to_date('01-03-2017','dd-mm-yyyy') -1 dat31, acc, kv, nls, fost(acc, to_date('01-03-2017','dd-mm-yyyy')  -1 )/100 ost31 ,  nms  , ostc/100 ostc, 
(select max(fdat)  from saldoa where ostf=0 and dos<>kos and acc=aa.ACC ) datvz
from accounts aa 
where nbs = '2924' and
 ob22 in ( '01', '14', '15', '16', '17', '18', '23', '25', '26', '27', '28' ) ) 
   where datvz <to_date('01-03-2017','dd-mm-yyyy')  and ost31 <>0;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/RA_KWT_2924.sql =========*** End *** ==
PROMPT ===================================================================================== 
