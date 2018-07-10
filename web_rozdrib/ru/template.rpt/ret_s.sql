CREATE OR REPLACE PROCEDURE RET_S 
(mfo_ varchar,
 DAT_MOM date, -- :=to_date('18-05-2009','dd-mm-yyyy'); -- дата миграции, которую сделал Боря - стартовая
 DAT_STA date  -- :=to_date('01-01-2009','dd-mm-yyyy'); -- самая нижняя дата, которая может остаться 
) IS 

--333368 Ровно
--303398 Луцк
 -- сделать SALDOA + SALDOB  

 fdat_ date  ; ostf_ number; dos_  number;  kos_  number; 
 kv_   int   ; OST_  number;

 nTmp_ number:=0;
begin
 bars_context.subst_branch('/'||MFO_||'/');

FOR k1 in ( select unique(acc) from opldok )
    -- Ищем код вал
    select kv into KV_ from accounts where acc=k1.ACC;

LOOP
  for k in (select FDAT,
                   sum(decode(dk,0,s ,0)) DOS, sum(decode(dk,1,s ,0)) KOS,
                   sum(decode(dk,0,sq,0)) DOSq,sum(decode(dk,1,sq,0)) KOSq
            from opldok  where acc=k1.ACC group by FDAT order by FDAT desc)
  loop
     begin
        -- Ищем самый меньший известный день
        select fdat, ostf, dos, kos   into  fdat_,ostf_,dos_,kos_
        from saldoA s
        where s.acc=k1.ACC and (s.acc,s.fdat)=
            (select acc,min(fdat) from saldoA where acc=s.acc group by acc);
     EXCEPTION WHEN NO_DATA_FOUND THEN  GOTO nexrec;
     end;

     -- таким д.б. вход ост НОМИНЛА на k.FDAT
     OST_ := ostf_+k.dos-k.kos;

     If k.dos>0 OR k.kos>0  then 
        --вставка новой даты
        insert into saldoA (fdat, acc, ostf, dos, kos ) values
                           (k.FDAT,k1.acc, OST_, k.dos, k.kos );
     end if;
     ----------------------------
     If kv_=980  OR (k.dosq=0 and k.kosq=0 ) then GOTO nexrec; end if;
     -------------------------------- 
/* Без saldoB
     -- Ищем последний известный день
     begin
       select fdat, ostf, dos, kos  into   fdat_,ostf_,dos_,kos_
       from saldoB s
       where s.acc=k1.ACC and (s.acc,s.fdat)=
            (select acc, min(fdat) from saldoB  where acc=s.acc group by acc);
     EXCEPTION WHEN NO_DATA_FOUND THEN  fdat_:=null; ostf_:=0; dos_:=0;kos_:=0;
     end;
     -- таким д.б. вход ост ЭКВИВАЛЕНТА на k.FDAT
     OST_ := ostf_+k.dosQ-k.kosQ;
     --вставка новой даты
     insert into saldoB (fdat, acc, ostf, dos, kos ) values
                        (k.FDAT,k1.acc, OST_, k.dosQ, k.kosQ );
*/
    <<nexrec>> null;

  end loop;

  nTmp_:=nTmp_+1;

logger.info('******'||nTmp_);

END LOOP;

 ---------------
commit;
logger.info('**********');

 -- все оствшиеся стартовые записи опустить вниз
 delete from saldoA where fdat=DAT_STA;
 insert into saldoA  (fdat,acc, ostf,dos,kos)
     select DAT_STA, a.acc, s.ostf,0,0
     from saldoA s, accounts a
     where  a.acc=s.acc and (s.acc,s.fdat) = 
      (select acc,min(fdat) from saldoa where acc=s.ACC group by acc);
 delete from saldoA where fdat=DAT_MOM;

/* Без saldoB
  delete from saldoB where fdat=DAT_STA;
 insert into saldoB  (fdat,acc, ostf,dos,kos)
     select DAT_STA, a.acc, s.ostf,0,0
     from saldoB s, accounts a
     where  a.kv<>980 and a.acc=s.acc and (s.acc,s.fdat) = 
      (select acc,min(fdat) from saldoB where acc=s.ACC group by acc);
 delete from saldoB where fdat=DAT_MOM;
*/
 
 --построить PDAT saldoA saldoB
 update saldoA s 
    set pdat=(select max(fdat) from saldoA where acc=s.acc and fdat< s.FDAT);

/* Без saldoB
 update saldoB s 
    set pdat=(select max(fdat) from saldoB where acc=s.acc and fdat< s.FDAT);
*/
commit;

end RET_S;
/
show err;
