update BARS.TICKETS_PAR set TXT = 'select o.sq from opldok o,oper a where a.ref=:nRecID and o.ref=a.ref and o.sq>14999999 and o.dk=1 and a.tt in(''115'',''125'',''130'',''140'',''112'',''113'',''123'',''132'',''133'',''142'',''DPA'',''DPC'')'
    where par = 'SUM_CH150';
commit;
