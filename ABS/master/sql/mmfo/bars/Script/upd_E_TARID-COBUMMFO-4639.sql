BEGIN
   update 
   E_TARIF t
    set t.npk_3570 = replace(t.npk_3570,': R_DATE',':R_DATE' )
   where npk_3570 like '%: R_DATE%';
END;
/

COMMIT;