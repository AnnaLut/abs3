
---  Меняем формулу суммы операции KD1   
---  с    EQV_OBS ( #(KVA),F_TARIF(20, #(KVA),#(NLSA), #(S)),SYSDATE)
---  на   F_TARIF_DPV(#(REF),#(KVA),#(NLSA),#(S))



UPDATE TTS set S = 'F_TARIF_DPV(#(REF),#(KVA),#(NLSA),#(S))' where TT='KD1';

commit;



---------------------------------------------------------------
--             Заявка COBUMMFO-5686  -  вариант для РУ !!!
--
-- 1). Тарифы для операции CAA:
--
--   12  1.2.10.1  Вiдправлення переказiв ІВ по SWIFT (в межах України)
--  119  1.2.10.2  Вiдправлення переказiв IВ по SWIFT (за межі України)
--  120  1.6.2.3.1 Вiдправлення переказiв IВ по SWIFT VIP-кл. (в межах України) 
--  121  1.6.2.3.2 Вiдправлення переказiв IВ по SWIFT VIP-кл. (за межі України) 
--
--  Тариф   12:    1% + 15USD,  MIN=0       MAX=500 USD  -  в грн-экв !
--  Тариф  119:    1%,          MIN=15 USD, MAX=500 USD  -  в грн-экв !

--  Тарифы 120,121 -  У Д А Л Я Е М  !
--
--
-- 2). Тарифы 20 для операции DPV:   1%,  MIN=5 USD, MAX=500 USD   
--
---------------------------------------------------------------


UPDATE TARIF set PR=1, TAR=1500, SMIN=0, SMAX=50000
  where KOD = 12 ;

UPDATE TARIF set PR=1, TAR=0, SMIN=500, SMAX=50000
  where KOD = 20 ;


Exec Tuda;
  DELETE from ACC_TARIF where KOD in (120,121);
Exec Suda;

DELETE from  TARIF where KOD in (120,121);

commit;
