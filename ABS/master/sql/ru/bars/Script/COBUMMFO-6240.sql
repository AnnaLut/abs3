

---------------------         Заявка   COBUMMFO-6240         ----------------------------------

--------- Изменение условия на визу 7 в операциях 'IB1','IB2','IBO','IBS','IBB' 

---   IB1 :

UPDATE chklist_tts set 
sqlval = '((KV=980 and substr(nlsA,1,4) in (''2600'',''2650'',''2603'',''2530'',''2541'',''2542'',''2544'',''2545'') and nvl(f_get_ob22(kv, nlsB),''02'')=''04'' and substr(nlsB,1,4)=''1919'')  OR  (KV<>980 and not (substr(nlsA,1,2) in (''25'',''26'') and ( substr(nlsB,1,3) in (''261'',''263'') or substr(nlsB,1,4) in (''2651'',''2652'',''2653'',''2656'',''2657'',''2658'')))))'
where  idchk=7 and TT = 'IB1' ;
                  ------------

---   IB2, IBO, IBS, IBB:

UPDATE chklist_tts set 
sqlval = '( KV<>980 and not (substr(nlsA,1,2) in (''25'',''26'') and (substr(nlsB,1,3) in (''261'',''263'') or substr(nlsB,1,4) in (''2651'',''2652'',''2653'',''2656'',''2657'',''2658''))))'
where  idchk=7 and TT in ('IB2','IBO','IBS','IBB') ;
                          -------------------------


COMMIT;



