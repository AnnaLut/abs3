

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RET_S.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RET_S ***

  CREATE OR REPLACE PROCEDURE BARS.RET_S 
(DAT_MOM date , -- :=to_date('31-01-2009','dd-mm-yyyy'); -- дата миграции, которую сделал Ѕор€ - стартова€
 DAT_STA date   -- :=to_date('01-01-2009','dd-mm-yyyy'); -- сама€ нижн€€ дата, котора€ может остатьс€
) IS

 fdat_ date  ; ostf_ number; dos_  number;  kos_  number;
 kv_   int   ; OST_  number;

 nTmp_ number:=0;

begin

FOR k1 in ( select unique(acc) acc from opldok )
LOOP
   -- »щем код вал
   select kv into KV_ from accounts where acc=k1.ACC;


   FOR f in (select fdat from fdat order by fdat desc)
   loop

--LOGGER.INFO('**1  K1.ACC='||K1.ACC ||' KV='||KV_);

      for k in (select sum(decode(dk,0,s ,0)) DOS, sum(decode(dk,1,s ,0)) KOS,
                       sum(decode(dk,0,sq,0)) DOSq,sum(decode(dk,1,sq,0)) KOSq
                from opldok
                where acc=k1.ACC and fdat=f.FDAT)
      loop

IF K.DOS IS NULL OR K.KOS IS NULL THEN GOTO nexrec; END IF;

--LOGGER.INFO('**2 DOS='||K.DOS|| ' KOS='|| K.KOS|| ' DOSQ='||K.DOSQ||' KOSQ='||K.KOSQ);
         begin
            -- »щем самый меньший известный день
            select fdat, ostf, dos, kos   into  fdat_,ostf_,dos_,kos_
            from saldoA s
            where s.acc=k1.ACC and (s.acc,s.fdat)=
               (select acc,min(fdat) from saldoA where acc=s.acc group by acc);
         EXCEPTION WHEN NO_DATA_FOUND THEN   GOTO nexrec;
         end;

--LOGGER.INFO('**3 FDAT='||FDAT_ ||' OSTF='||OSTF_||' DOS='||DOS_||' KOS='||KOS_);

         -- таким д.б. вход ост Ќќћ»ЌЋј на F.FDAT
         OST_ := ostf_+k.dos-k.kos;
--LOGGER.INFO('**4  OST_='||OST_);

         If k.dos>0 OR k.kos>0  then
            --вставка новой даты
            insert into saldoA (fdat, acc, ostf, dos, kos ) values
                               (F.FDAT,k1.acc, OST_, k.dos, k.kos );
--LOGGER.INFO('**5  вставка');
         end if;
         ----------------------------
         If kv_=980  OR (k.dosq=0 and k.kosq=0 ) then
--LOGGER.INFO('**6  nexrec');
            GOTO nexrec;
         end if;
         --------------------------------
         -- »щем последний известный день
         begin
           select fdat, ostf, dos, kos  into   fdat_,ostf_,dos_,kos_
           from saldoB s
           where s.acc=k1.ACC and (s.acc,s.fdat)=
              (select acc, min(fdat) from saldoB  where acc=s.acc group by acc);
         EXCEPTION WHEN NO_DATA_FOUND THEN
           fdat_:=null; ostf_:=0; dos_:=0;kos_:=0;
         end;
--logger.info('**7 FDAT='||fdat_||' OSTF_='||OSTF_);
         -- таким д.б. вход ост Ё ¬»¬јЋ≈Ќ“ј на F.FDAT
         OST_ := ostf_+k.dosQ-k.kosQ;

--logger.info('** 8 OST '||OST_);

         --вставка новой даты
         insert into saldoB (fdat, acc, ostf, dos, kos ) values
                          (F.FDAT,k1.acc, OST_, k.dosQ, k.kosQ );
--logger.info('**9 новой д');

         <<nexrec>> null;

      end loop;

      nTmp_:=nTmp_+1;
   END LOOP;

   logger.info('**99 '||nTmp_);

END LOOP;

 ---------------
commit;
logger.info('**********');

 -- все оствшиес€ стартовые записи опустить вниз
 delete from saldoA where fdat=DAT_STA;
 insert into saldoA  (fdat,acc, ostf,dos,kos)
     select DAT_STA, a.acc, s.ostf,0,0
     from saldoA s, accounts a
     where  a.acc=s.acc and (s.acc,s.fdat) =
      (select acc,min(fdat) from saldoa where acc=s.ACC group by acc);
 delete from saldoA where fdat=DAT_MOM;

  delete from saldoB where fdat=DAT_STA;
 insert into saldoB  (fdat,acc, ostf,dos,kos)
     select DAT_STA, a.acc, s.ostf,0,0
     from saldoB s, accounts a
     where  a.kv<>980 and a.acc=s.acc and (s.acc,s.fdat) =
      (select acc,min(fdat) from saldoB where acc=s.ACC group by acc);
 delete from saldoB where fdat=DAT_MOM;

 --построить PDAT saldoA saldoB
 update saldoA s
    set pdat=(select max(fdat) from saldoA where acc=s.acc and fdat< s.FDAT);
 update saldoB s
    set pdat=(select max(fdat) from saldoB where acc=s.acc and fdat< s.FDAT);

commit;

end RET_S;
 
/
show err;

PROMPT *** Create  grants  RET_S ***
grant EXECUTE                                                                on RET_S           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RET_S.sql =========*** End *** ===
PROMPT ===================================================================================== 
