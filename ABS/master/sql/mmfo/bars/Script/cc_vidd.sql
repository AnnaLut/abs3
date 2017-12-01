begin
   update cc_vidd set CUSTTYPE = 2, tipd=2, NAME = 'Залучення 2700 - Короткостр.кредити що отримані від міжнар. та ін.орг.' where vidd =2700;
   IF SQL%ROWCOUNT=0 then
      Insert into BARS.CC_VIDD (VIDD, CUSTTYPE, TIPD, NAME) Values (2700, 2, 2, 'Залучення 2700 - Короткостр.кредити що отримані від міжнар. та ін.орг.');
   end if; 

   update cc_vidd set CUSTTYPE = 2, tipd=2, NAME = 'Залучення 2701 - Довгостр.кредити отримані від фінінст.' where vidd =2701; 
   IF SQL%ROWCOUNT=0 then
      Insert into BARS.CC_VIDD (VIDD, CUSTTYPE, TIPD, NAME) Values (2701, 2, 2, 'Залучення 2701  - Довгостр.кредити отримані від фінінст.');
   end if; 

   update cc_vidd set CUSTTYPE = 2, tipd=2, NAME = 'Залучення 3660 - Субординован. борг' where vidd =3660;
   IF SQL%ROWCOUNT=0 then
      Insert into BARS.CC_VIDD (VIDD, CUSTTYPE, TIPD, NAME) Values (3660, 2, 2, 'Залучення 3660 - Субординован. борг');
   end if; 
   commit;
end;
/