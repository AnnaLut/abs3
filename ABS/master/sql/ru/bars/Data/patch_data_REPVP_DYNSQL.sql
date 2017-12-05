
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_REPVP_DYNSQL.sql =========**
PROMPT ===================================================================================== 

declare
l_REPVP_DYNSQL  REPVP_DYNSQL%rowtype;

procedure p_merge(p_REPVP_DYNSQL REPVP_DYNSQL%rowtype) 
as
Begin
   insert into REPVP_DYNSQL
      values p_REPVP_DYNSQL; 
 exception when dup_val_on_index then  
   update REPVP_DYNSQL
      set row = p_REPVP_DYNSQL
    where SQLID = p_REPVP_DYNSQL.SQLID;
End;
Begin

l_REPVP_DYNSQL.SQLID :=1;
l_REPVP_DYNSQL.DESCRIPT :='Рахунки пенсійного фонду';
l_REPVP_DYNSQL.SQLTXT :='select s.acc,  s.nls, s.nlsalt, s.kv, s.tip, s.fdat,   s.dos, s.kos,
           s.ost - s.kos + s.dos ostf, s.dapp, s.isp, s.nms,  nmk, cus.okpo
      from sal s,  cust_acc c, customer cus, v_pf_accounts v
     where s.fdat between  :p_date1  and  :p_date2
       and s.acc = c.acc and cus.rnk = c.rnk
       and (s.dazs is null or s.dazs >= :p_dat2)
       and s.acc = v.acc';

 p_merge( l_REPVP_DYNSQL);


l_REPVP_DYNSQL.SQLID :=2;
l_REPVP_DYNSQL.DESCRIPT :='‚иписка позабалансовґ рахунки(1006-1007)';
l_REPVP_DYNSQL.SQLTXT :='select s.acc,  s.nls, s.nlsalt, s.kv, s.tip, s.fdat,   s.dos, s.kos,
           s.ost - s.kos + s.dos ostf, s.dapp, s.isp, s.nms,  nmk, cus.okpo
      from sal s,  cust_acc c, customer cus, tmp_lic v
     where s.fdat between  :p_date1  and  :p_date2
       and s.acc = c.acc and cus.rnk = c.rnk
       and (s.dazs is null or s.dazs >= :p_dat2)
       and s.acc = v.acc';

 p_merge( l_REPVP_DYNSQL);


l_REPVP_DYNSQL.SQLID :=3;
l_REPVP_DYNSQL.DESCRIPT :='Виписка рахунки по РНК';
l_REPVP_DYNSQL.SQLTXT :='select s.acc,  s.nls, s.nlsalt, s.kv, s.tip, s.fdat,   s.dos, s.kos,
           s.ost - s.kos + s.dos ostf, s.dapp, s.isp, s.nms,  nmk, cus.okpo
      from sal s,  cust_acc c, customer cus, tmp_lic v
     where s.fdat between  :p_date1  and  :p_date2
       and s.acc = c.acc and cus.rnk = c.rnk
       and (s.dazs is null or s.dazs >= :p_dat1)
       and s.acc = v.acc';

 p_merge( l_REPVP_DYNSQL);


l_REPVP_DYNSQL.SQLID :=4;
l_REPVP_DYNSQL.DESCRIPT :='Виписка рахунки на РУ';
l_REPVP_DYNSQL.SQLTXT :='select s.acc, s.nls, s.nlsalt, s.kv, s.tip, s.fdat, s.dos, s.kos,
           s.ost - s.kos + s.dos ostf, s.dapp, s.isp, s.nms, nmk, cus.okpo
      from sal s, cust_acc c, customer cus, tmp_lic v
     where s.fdat between  :p_date1 and :p_date2
       and s.acc = c.acc and cus.rnk = c.rnk
       and (s.dazs is null or s.dazs >= :p_dat1)
       and s.acc = v.acc
       and (s.dos+s.kos) != 0';

 p_merge( l_REPVP_DYNSQL);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_REPVP_DYNSQL.sql =========**
PROMPT ===================================================================================== 