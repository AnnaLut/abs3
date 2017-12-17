update BARS.PS
   set D_CLOSE = null
 where D_CLOSE is not null
   and NBS in ( select R020 from BARS.KL_R020 where D_CLOSE is null );

commit;
