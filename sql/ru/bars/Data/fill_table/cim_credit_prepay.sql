update cim_credit_prepay set name = 'Умовами договору не передбачено дострокове погашення' where id = 1;
/
update cim_credit_prepay set name = 'Умовами договору передбачено дострокове погашення' where id = 2;
/
commit;