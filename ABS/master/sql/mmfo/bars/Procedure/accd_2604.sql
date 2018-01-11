

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ACCD_2604.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ACCD_2604 ***

  CREATE OR REPLACE PROCEDURE BARS.ACCD_2604 (p_dat2 date) is
 acc_2600  INTEGER ;
 nls_7     varchar2(15);
 S6110_    varchar2(15);
 n_cli     integer;
 OB22_     varchar2(2);
 nls_      accounts.NLS%type;
 tag_      varchar2(15);
begin
-------------------------------------------------------------------------
--                 "Плата за РО" и Проц.Карточки по 2600.
--             Процедура включена в список Закрытия Дня:
--
--  1). Удаляем RKO_LST.ACCD - счет списания, если он неГривневый или Закрыт.
--
--  2). Проставляем счетам 2603,2604,2600/не01 в качестве "Рахункiв
--      списання" счет 2600/01 (2650) этого же Клиента (берем 2600/01 с
--      максимальным остатком)
--
--  3). Довносим в RKO_LST вновь-открывшиеся 2620\07,32
--      Обнуляем 70 тариф для по всем 2620\07.
--
--  4). Удаляем 3570 у счетов, которые сидят в "Плате за РО", если этот же
--      3570 встречается в счетах, сидящих в "Плате за РО-только 3570"
--
--
--  6). В проц.карточках ЗАКРЫТЫХ счетов 2600,2603,2604,2650,2620/07
--      проставляем      "Дата закiнчення" = Дата "Нараховано по"
--      Это для того, что бы закрытые счета 2600 с недоначисленными %%
--      не "лезли" в последующие начисления %%
--
--  7). Проставление ИНДИВИДУАЛЬНЫХ 6510 по Корпор.Клиентам
--
--  8). Счета 2603 Клиентов, у которых нет 2600,2650, автом-ки
--      вносим в справочник RKO_3570
--
--  9). Дозаполнение парметра CASH02 - счета кассы 1001/02, 1002/02.
--
-- 10). Удаляем из RKO_LST счета, закрывшиеся более 2-ух месяцев назад.
--
----=========================================================================


--  1). Удаляем ACCD, если он неГривневый или Закрыт.


 For k in (SELECT r.ACC
           FROM   RKO_LST r, Accounts a
           WHERE  r.ACCD is not NULL    and
                  r.ACCD=a.ACC          and
                  (a.KV<>980 or a.DAZS is not NULL)
          )
 Loop
      Update RKO_LST set ACCD=null  where ACC=k.ACC ;
 End Loop;

-----------------------------------------------------------------------

--  2). Проставляем счетам 2603, 2604, 2600/не01 в качестве "Рахункiв
--      списання" счет 2600/01 (или 2650) этого же Клиента.


 -----------------------------------


 For k in ( SELECT ACC
            FROM   RKO_LST
            where  ACC = ACCD and ACCD is not NULL
          )

 Loop

    Update RKO_LST set ACCD=null  where ACC=k.ACC ;

 End Loop;

 -----------------------------------


 For k in (SELECT r.ACC, a.RNK
           FROM   RKO_LST r, ACCOUNTS a
           WHERE
                  r.ACC=a.ACC
             and  ( a.NBS in ('2603','2604')
                     or
                    a.NBS='2600' and a.OB22 is not NULL and a.OB22<>'01'
                  )
             and  r.ACCD is NULL
          )

 Loop

    BEGIN           ---  Ищем 2600/01

       Select ACC into acc_2600
       From   Accounts
       Where  NBS='2600' and  OB22='01'
          and RNK=k.RNK  and  DAZS is NULL and KV=980 and
              OSTC=(Select max(OSTC)
                    from   Accounts
                    where  NBS='2600' and  OB22='01'
                       and RNK=k.RNK  and  DAZS is NULL and KV=980
                   )
          and rownum=1;

       Update RKO_LST set ACCD=acc_2600  where ACC=k.ACC ;

    EXCEPTION WHEN OTHERS then

       Begin        ---  Ищем просто 2600

          Select ACC into acc_2600
          From   Accounts
          Where  NBS='2600'
             and RNK=k.RNK  and DAZS is NULL and KV=980 and
                 OSTC=(Select max(OSTC)
                       from   Accounts
                       where  NBS='2600'
                          and RNK=k.RNK and DAZS is NULL and KV=980
                       )
             and rownum=1;

         Update RKO_LST set ACCD=acc_2600  where ACC=k.ACC ;

       EXCEPTION WHEN OTHERS then

          Begin        ---  Ищем 2650

             Select ACC into acc_2600
             From   Accounts
             Where  NBS='2650'
                and RNK=k.RNK  and DAZS is NULL and KV=980 and
                    OSTC=(Select max(OSTC)
                          from   Accounts
                          where  NBS='2650'
                             and RNK=k.RNK and DAZS is NULL and KV=980
                          )
                and rownum=1;

            Update RKO_LST set ACCD=acc_2600  where ACC=k.ACC ;

          EXCEPTION WHEN OTHERS then

            null;

          End;

       End;

    END;

 End Loop;

----=========================================================================

--  3). Довносим в RKO_LST вновь-открывшиеся 2620\07,32


 For k in (Select ACC From ACCOUNTS
           WHERE  NBS='2620' and OB22 in ('07','32')
              and DAZS is NULL and KV=980
              and ACC not in (Select ACC from RKO_LST)
          )
 Loop
    INSERT INTO rko_lst (ACC) values (k.ACC);
 End Loop;

-------------------------------------------

 For k in (Select ACC From ACCOUNTS
           WHERE  NBS='2620' and OB22='07' and DAZS is NULL and KV=980
          )
 Loop
    UPDATE acc_tarif  SET  PR=0, TAR=0, SMIN=0  WHERE  ACC=k.acc and KOD=70;
    IF SQL%rowcount = 0 THEN
       INSERT INTO acc_tarif ( ACC,   TAR,  KOD,  PR, SMIN )
       VALUES                ( k.acc, 0,    70,   0 , 0    );
    END IF;
 End Loop;

---=========================================================================

--  4). Удаляем 3570 у счетов, которые сидят в "Плате за РО", если этот же
--      3570 встречается в счетах, сидящих в "Плате за РО - только на 3570"

UPDATE RKO_LST set ACC1=null where
   ACC not in (Select ACC from RKO_3570)   and
   ACC1 in (Select ACC1 from RKO_LST where ACC in (Select ACC from RKO_3570));


UPDATE RKO_LST set ACC2=null where
   ACC not in (Select ACC from RKO_3570)   and
   ACC2 in (Select ACC2 from RKO_LST where ACC in (Select ACC from RKO_3570));

---======================================================================
--  6). В проц.карточках ЗАКРЫТЫХ счетов 2600,2603,2604,2650,2620/07
--      проставляем      "Дата закiнчення" =  "Нараховано по"

 For k in (Select ACC,NBS,BRANCH
           from   Accounts
           where
                  ( NBS in ('2600','2603','2604','2650')
                      or
                    NBS='2620' and OB22 in ('07','32')
                  )
              and ACC not in (Select ACC from DPU_DEAL)
              and ACC in (Select ACC from INT_ACCN where ID=1)
              and DAZS is not NULL
                  ----------------
          )

 Loop

   Update INT_ACCN set STP_DAT=ACR_DAT where ACC=k.ACC and ID=1;

 End Loop;



---======================================================================

--  7).  Проставление ИНДИВИДУАЛЬНЫХ 6510 по Корпор.Клиентам


 For n in ( Select KOD_CLI
            From   KOD_CLI
            Where  KOD_CLI in (1,2,5,6,8,11,17)
          )
 LOOP

    If     n.KOD_CLI =  1  then  OB22_ := '73';    --- ПФУ
    elsif  n.KOD_CLI =  2  then  OB22_ := '77';    --- Укрпошта
    elsif  n.KOD_CLI =  5  then  OB22_ := '99';    --- ОблЕнерго
    elsif  n.KOD_CLI =  6  then  OB22_ := 'A4';    --- ПЕК
    elsif  n.KOD_CLI =  8  then  OB22_ := 'A6';    --- ГАЗ
    elsif  n.KOD_CLI = 11  then  OB22_ := 'A7';    --- Тепловики
    elsif  n.KOD_CLI = 17  then  OB22_ := 'E3';    --- Укрзалізниця
    End If;


    For k in (Select ACC, NLS, BRANCH
              From   ACCOUNTS
              Where  NBS  in ('2560','2565','2600','2603','2604')
                and  DAZS is NULL and   KV=980
                and  RNK in (Select nvl(RNK,-1) from RNKP_KOD where KODK=n.KOD_CLI)
                and  ACC not in (Select ACC from AccountsW where TAG='S6110' and substr(trim(VALUE),1,4)='6510')
             )
    LOOP

      BEGIN

         Select NLS into  S6110_
         from   Accounts
         where  DAZS is NULL                   and
                BRANCH = substr(k.BRANCH,1,15) and
                NBS='6510' and OB22=OB22_      and
                rownum=1;

         Begin
            insert into AccountsW (ACC, TAG, VALUE) values
                                  (k.ACC, 'S6110', S6110_);
         EXCEPTION WHEN OTHERS then
            update AccountsW set VALUE=S6110_ where ACC=k.ACC and TAG='S6110';
         End;

      EXCEPTION WHEN OTHERS then

        Begin

            Select NLS into  S6110_
            from   Accounts
            where  DAZS is NULL                   and
                   BRANCH like '/______/000000/'  and
                   NBS='6510' and OB22=OB22_      and
                   rownum=1;

            Begin
               insert into AccountsW (ACC, TAG, VALUE) values
                                     (k.ACC, 'S6110', S6110_);
            EXCEPTION WHEN OTHERS then
               update AccountsW set VALUE=S6110_ where ACC=k.ACC and TAG='S6110';
            End;

        EXCEPTION WHEN OTHERS then

           null;

        End;

      END;

    End Loop;


 END LOOP;

---=====================================================================
--
--  8). Счета 2603 Клиентов, у которых нет 2600,2650, автом-ки
--      вносим в справочник RKO_3570

 For k in ( SELECT r.ACC
            FROM   RKO_LST r, Accounts a
            WHERE  r.ACC = a.ACC
              and  a.NBS='2603' and a.DAZS is NULL
              and  a.RNK not in
                      ( Select RNK
                        from   Accounts
                        where  NBS in ('2600','2650') and KV=980
                          and  DAZS is NULL
                      )
              and  r.ACC not in (Select ACC from RKO_3570)
          )
 Loop

   BEGIN
      insert into RKO_3570 (ACC) values ( k.ACC );
   EXCEPTION WHEN OTHERS then
      null;
   END;

 End Loop;

---================================================================
--
--  9). Дозаполнение парметра CASH02 - счета кассы 1001/02, 1002/02.
--


 tag_:= 'CASH02' ;

 For k in (select BRANCH from BRANCH where length(BRANCH) > 8)
 LOOP

   BEGIN

     Select NLS into nls_
     from   ACCOUNTS
     where  (NBS='1001' or NBS='1002') and  OB22='02'
        and DAZS is NULL
        and KV=980
        and BRANCH=k.BRANCH
        and abs(OSTC)=
               (Select max(abs(a.OSTC))
                from   Accounts a
                where  (a.NBS='1001' or a.NBS='1002') and a.OB22='02'
                   and a.DAZS is NULL
                   and a.KV=980
                   and a.BRANCH=k.BRANCH
               )
        and rownum=1;

   EXCEPTION WHEN NO_DATA_FOUND THEN

     BEGIN

        Select NLS into nls_
        from   ACCOUNTS
        where  (NBS='1001' or NBS='1002') and OB22='02'
           and DAZS is NULL
           and KV=980
           and BRANCH=substr(k.BRANCH,1,15)
           and abs(OSTC)=
                  (Select max(abs(a.OSTC))
                   from   Accounts a
                   where  (a.NBS='1001' or a.NBS='1002') and a.OB22='02'
                      and a.DAZS is NULL
                      and a.KV=980
                      and a.BRANCH=substr(k.BRANCH,1,15)
                  )
           and rownum=1;

     EXCEPTION WHEN NO_DATA_FOUND THEN

        nls_:=null;

     END;

   END;

   ---  Запись в  BRANCH_PARAMETERS:

   If nls_ is not null then

      Begin
         insert into BRANCH_PARAMETERS (BRANCH,   TAG , VAL )
         values     (k.BRANCH, tag_, nls_);
      EXCEPTION WHEN OTHERS then
         null;
      End;

   End If;

 END LOOP;

---================================================================
--
-- 10). Удаляем из RKO_LST счета, закрывшиеся более 2-ух месяцев назад 
--

  FOR k IN  ( Select r.ACC
              FROM   RKO_LST r, ACCOUNTS a
              WHERE  r.ACC = a.ACC
                 and a.DAZS is not NULL and a.DAZS < gl.BD - 60
            )
  LOOP
     DELETE from  RKO_LST where ACC=k.ACC;
  END LOOP;


end ACCD_2604;
/
show err;

PROMPT *** Create  grants  ACCD_2604 ***
grant EXECUTE                                                                on ACCD_2604       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ACCD_2604       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ACCD_2604.sql =========*** End ***
PROMPT ===================================================================================== 
