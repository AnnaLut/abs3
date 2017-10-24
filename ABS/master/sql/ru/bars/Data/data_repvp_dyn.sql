begin
insert into REPVP_DYNSQL t (t.sqlid, t.descript, t.sqltxt) values (4,'Виписка рахунки на РУ', 'select s.acc, s.nls, s.kv, s.tip, s.fdat, s.dos, s.kos,
           s.ost - s.kos + s.dos ostf, s.dapp, s.isp, s.nms, nmk, cus.okpo
      from sal s, cust_acc c, customer cus, tmp_lic v
     where s.fdat between  :p_date1 and :p_date2
       and s.acc = c.acc and cus.rnk = c.rnk
       and (s.dazs is null or s.dazs >= :p_dat1)
       and s.acc = v.acc
       and (s.dos+s.kos) != 0');
exception when dup_val_on_index then null;
end;
/
commit;
  