

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PK_2600.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PK_2600 ***

  CREATE OR REPLACE PROCEDURE BARS.PK_2600 (p_dat2 date) is
  acc_2608  integer;
  nls_2608  varchar2(15);
  nbs_2608  varchar2(4);
  segm_     varchar2(1);
  ob22_     varchar2(2);
  tmp_      NUMBER;
  nls_7020  varchar2(15);
  acc_7020  varchar2(15);
  nbs_7020  varchar2(4);
  stavka    number(20,4);
  kkk_      NUMERIC ;
  acr_dat1  date ;
-------------------------------------------------------------------
--                        О Щ А Д Б А Н К
--
--  Процедура дозаполнения Проц.Карточек по 2560,2600,2603,2604,2650
--                (работает в списке Закрытия Дня)
--
-------------------------------------------------------------------
Begin

---***IF to_char(gl.bdate,'DD')='27' or to_char(gl.bdate,'DD')='28' then


begin   ---  1).  Дозаполнение ACRA

  FOR k IN  ( Select a.ACC, a.NLS, a.NBS, a.KV, a.RNK, a.NMS,
                     a.ISP, a.BRANCH, a.TOBO,
                     i.ACRA, i.ACRB, a.OB22
              FROM   Accounts a, INT_ACCN i, Accounts s
              WHERE
                     a.ACC=i.ACC  and  i.ID=1
                 and ACRN.FPROCN(a.ACC,1,gl.BDATE)>0
                 and a.DAZS is NULL
                 and (
                       a.NBS in ('2560','2600','2603','2604','2650')
                          or
                       a.NBS='2620' and a.OB22 in ('07','32')
                     )
                 and a.ACC not in (Select ACC from DPU_DEAL)
                 and i.ACRA is not NULL
                 and i.ACRA=s.ACC
                 and (s.RNK<>a.RNK
                       or
                      substr(s.NLS,1,4) not in
                                    ('2568','2628','2608','2658')
                     )
                 and a.RNK in (Select RNK from Customer where DATE_OFF is NULL)
    UNION ALL
              Select a.ACC, a.NLS, a.NBS, a.KV, a.RNK, a.NMS,
                     a.ISP, a.BRANCH, a.TOBO,
                     i.ACRA, i.ACRB, a.OB22
              FROM   Accounts a, INT_ACCN i
              WHERE
                     a.ACC=i.ACC  and  i.ID=1
                 and ACRN.FPROCN(a.ACC,1,gl.BDATE)>0
                 and a.DAZS is NULL
                 and (
                       a.NBS in ('2560','2600','2603','2604','2650')
                          or
                       a.NBS='2620' and a.OB22 in ('07','32')
                     )
                 and a.ACC not in (Select ACC from DPU_DEAL)
                 and a.RNK in (Select RNK from Customer where DATE_OFF is NULL)
                 and i.ACRA is NULL
            )

  LOOP

    ob22_:='01';

    If     k.NBS='2560' then
           nbs_2608:='2568';

    elsif  k.NBS='2650' then
           nbs_2608:='2658';

    elsif  k.NBS='2620' and k.OB22='07' then
           nbs_2608:='2628';
           ob22_:='07';

    elsif  k.NBS='2620' and k.OB22='32' then
           nbs_2608:='2628';
           ob22_:='47';
    else
           nbs_2608:='2608';
    End if;


--- Ищем/Открываем счет 2608* на РНК этого же Клиента:

    BEGIN

       Select ACC into acc_2608
       from   Accounts
       where  NBS=nbs_2608 and KV=k.KV  and  DAZS is NULL  and
              RNK=k.RNK  and rownum=1;

    EXCEPTION WHEN OTHERS then

       nls_2608:= VKRZN(SUBSTR(gl.aMFO,1,5),nbs_2608||SUBSTR(k.NLS,5));

       Begin

          Select ACC into acc_2608
          from   Accounts
          where  NLS=nls_2608 and KV=k.KV and DAZS is not NULL;

          -- Счет nls_2608 оказался закрытым - ПЕРЕОТКРЫВАЕМ ЕГО !

          Update Accounts set DAZS=null,
                              RNK=k.RNK,
                              NMS=substr('Нарах.%% '||k.NMS,1,70),
                              ISP=k.ISP
                  where ACC=acc_2608;

       Exception WHEN OTHERS then

          OP_REG(99,0,0,NULL, tmp_, k.RNK, nls_2608, k.KV,
                              substr('Нарах.%% '||k.NMS,1,70),'ODB',k.ISP,acc_2608);

       End;

       sec.addAgrp(acc_2608,39);
       sec.addAgrp(acc_2608,61);

       UPDATE Accounts set TOBO=k.TOBO where ACC=acc_2608;


       BEGIN
         INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc_2608, ob22_);
       EXCEPTION WHEN OTHERS THEN
         UPDATE Specparam_INT SET OB22=ob22_  WHERE  ACC=acc_2608;
       END;

       BEGIN
         INSERT INTO Specparam (ACC,   R011, S180, S240) VALUES
                             (acc_2608, '1',  '1', '1' );
       EXCEPTION WHEN OTHERS THEN
         UPDATE Specparam SET  R011='1',S180='1',S240='1' WHERE  ACC=acc_2608;
       END;

    END;

    Update INT_ACCN set   ACRA=acc_2608   where ACC=k.ACC and ID=1;

  END LOOP;

end;    --- end 1)

------------------------------------------------------------------------

begin   ---  2).  Дозаполнение ACRB

  FOR k IN  ( Select a.ACC, a.NLS, a.NBS, a.KV, a.RNK, a.NMS,
                     a.ISP, a.BRANCH, a.TOBO, a.OB22,
                     i.ACRA, i.ACRB, r.IR, r.BR
              FROM   Accounts a, INT_ACCN i, INT_RATN r
              WHERE  length(a.BRANCH) > 8
                 and a.ACC=i.ACC  and  i.ID=1
                 and a.ACC=r.ACC  and  r.ID=1
                 and ACRN.FPROCN(a.ACC,1,gl.BDATE)>0
                 and a.DAZS is NULL
                 and ( a.NBS in ('2560','2600','2603','2604','2650')
                          or
                       a.NBS='2620' and a.OB22 in ('07','32')
                     )
                 and a.ACC not in (Select ACC from DPU_DEAL)
                 and ( i.ACRB is NULL
                          or
                       i.ACRB not in (Select ACC
                                      from   Accounts
                                      where  substr(NLS,1,1)='7' and DAZS is NULL
                                     )
                     )
                 and a.RNK in (Select RNK from Customer where DATE_OFF is NULL)
            )

  LOOP

  kkk_:=0;       ----  Определяем kkk_  -  Kод Корп. Клиента
  BEGIN
    Select KODK  Into  kkk_
    From   RNKP_KOD
    Where  RNK=k.RNK and RNK is not NULL and KODK is not NULL and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    kkk_:=0;
  END;


---  Ищем счет 7020 на BRANCH-е этого счета:

    BEGIN

      nbs_7020:='7020';

      If      k.NBS='2560'                then        ---  ПФУ 2560:  7030/06
              --------------
              nbs_7020:='7030';
              ob22_:='06';


      Elsif   k.NBS in ('2600','2603') and k.KV=980 then --- 2600/ГРН: 7020/06
              --------------------------------------     --- 2603/ГРН

         if    kkk_=0  then     --  Обычные ЮЛ
               ob22_:='06';
         elsif kkk_=2  then     --  Укрпошта
               ob22_:='13';
         elsif kkk_=5  then     --  ОблЕнерго
               ob22_:='17';
         elsif kkk_=6  then     --  ПЕК
               ob22_:='19';
         elsif kkk_=8  then     --  ГАЗ
               ob22_:='20';
         elsif kkk_=11 then     --  Тепло
               ob22_:='21';
         else
               ob22_:='06';
         end if;


      Elsif   k.NBS='2600' and k.KV<>980  then   ---  2600/ВАЛ:  7020/07
              --------------------------

         if    kkk_=2  then     --  Укрпошта
               ob22_:='18';
         else
               ob22_:='07';
         end if;


      Elsif   k.NBS='2604'                then   ---  2604:  7020/03
             ----------------
         if    kkk_=2  then        --  Укрпошта

               if nvl(k.IR,0)>5.00 or nvl(k.BR,0)=100 then
                  ob22_:='12';         -- ставка НБУ 7.5%
               else
                  ob22_:='14';         -- 4%
               end if;

         else
               ob22_:='03';
         end if;


      Elsif   k.NBS='2650'                then   ---  2650:  7070/01
              --------------
              nbs_7020:='7070';
              ob22_:='01';


      Elsif   k.NBS='2620'                then   ---  2620/07
              ---------------
              nbs_7020:='7040';
              ob22_:='08';

      End If;

      Select ACC into acc_7020
      from   Accounts
      where  BRANCH = substr(k.BRANCH,1,15) and
             NBS=nbs_7020  and  OB22=ob22_  and
             DAZS is NULL and rownum=1;

      UPDATE INT_ACCN set  ACRB=acc_7020   where ACC=k.ACC and ID=1;

    EXCEPTION WHEN OTHERS then

       Begin

          Select ACC into acc_7020
          from   Accounts
          where  BRANCH = substr(k.BRANCH,1,15) and
                 NBS='7020' and OB22='06'  and
                 DAZS is NULL and rownum=1;

          UPDATE INT_ACCN set  ACRB=acc_7020   where ACC=k.ACC and ID=1;

       EXCEPTION WHEN OTHERS then
          null;
       END;

    END;

  END LOOP;

end;   --- end 2)

---***END IF;     ---  IF to_char(gl.bdate,'DD')='27','28'

END PK_2600;
/
show err;

PROMPT *** Create  grants  PK_2600 ***
grant EXECUTE                                                                on PK_2600         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PK_2600         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PK_2600.sql =========*** End *** =
PROMPT ===================================================================================== 
