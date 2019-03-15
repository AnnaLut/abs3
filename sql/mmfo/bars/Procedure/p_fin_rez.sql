
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/p_fin_rez.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.P_FIN_REZ 
(kor_  int , -- =10 - кол-во дней корр.пров.
 DAT1_ date, -- дата "С"
 DAT2_ date  -- дата "По"
 ) Is

--04-10-2011 Внесено в еталон.

  -- процедура пересмотрена  Сухова 05-07-2010
  -- финансовые результаты по реальным бранчам
  -- в т.ч. до низового уровня

  ACC_    accounts.acc%type   ;
  BRANCH_ accounts.branch%type;

  vob_    oper.vob%type       ;
  vdat_   oper.vdat%type      ;
  mfoa_   oper.mfoa%type      ;
  mfob_   oper.mfoa%type      ;
  nlsk_   oper.nlsb%type      ;
  kvk_    oper.kv%type        ;

  n1_ number  ; n2_ number    ;

  a_NAME1  varchar2(17) := 'F' || to_char ( DAT1_, 'YYYYMMDD' ) ||
                                  to_char ( DAT2_, 'YYYYMMDD' ) ;
  b_NAME1  varchar2(17) ;

begin

  -- дважды не пересчитываем. т.к.разница только в сортировке
  begin
     select NAME1 into b_NAME1 from CCK_AN_TMP where rownum=1;
     If b_NAME1 = a_NAME1 then
        goto KIN;
     else
        delete from CCK_AN_TMP;
     end if;
  exception when no_data_found then  NULL;
  end;

  for k in (select a.NBS, a.nls, a.branch, substr(a.nbs,2,1) B2,
                   o.fdat, o.acc, o.dk, o.s, o.ref
            from opldok o, accounts a
            where a.acc=o.acc
              and a.nbs  >  '5999'
              and a.nbs  <  '8000'
              and o.fdat >= DAT1_
              and o.fdat <= (DAT2_+ kor_)
               )
  loop
   begin --2018.10.17 MDom для тестування звіту про доходи та витрати (БР+Вiддiлення), т.я. не вдавалося згенерувати
     select branch , vdat , vob , mfoa , mfob ,
            decode(nlsb,k.nls, nlsa, nlsb),
            decode(nlsb,k.nls, kv  , kv2 )
     into   BRANCH_, vdat_, vob_, mfoa_, mfob_, nlsk_, kvk_
     from   oper
     where  ref=k.ref;

     If vob_ in (96,99)  then
        -- это коррект прошлого периода
        If vdat_< DAT1_  then   goto NextRec;
        end if;
     else
        -- это обычные будущего периода
        If k.fdat>DAT2_  then goto NextRec;
        end if;
     end if;

     -- надо определить бранч, кому принадлежат эти дох/расх
-------------------------------------------------------------------
     -- 1) по месту рег договора (контрсчета)
     --    Процентные
     --    Комиссионные (по методу начисления)
     If k.b2 = '0'     OR
        k.b2 = '1' and nlsk_ like '3__8%'   then
        begin
          select branch into BRANCH_ from accounts where kv=KVK_ and nls=NLSK_;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;
-------------------------------------------------------------------
     -- 2) по прописке счета 6/7 класса
     ElsIf k.b2 > '2'  OR
           mfoa_ <> mfob_ OR
           length(branch_) = 8 then
           BRANCH_ := k.branch;
     end if;
-------------------------------------------------------------------
     -- 3) Остальное - по умолчанию - от места возникновения операции
     --    BRANCH_  := oper.branch
-------------------------------------------------------------------

     If k.dk=0 then n1_ := k.S ; n2_ := 0   ;
     else           n1_ := 0   ; n2_ := k.s ;
     end if;

     update CCK_AN_TMP
        set n1 = n1 + n1_,
            n2 = n2 + n2_
      where branch = branch_ and nbs = k.nbs;

     if SQL%rowcount = 0 then
        insert into CCK_AN_TMP (nbs, branch , n1,  n2,    NAME1 )
                      values (k.nbs, branch_, n1_, n2_, a_NAME1 ) ;
     end if;

     <<NextRec>> NULL;
   --2018.10.17 MDom для тестування звіту про доходи та витрати (БР+Вiддiлення), т.я. не вдавалося згенерувати
   exception
     when no_data_found then
       null; --якщо не знаходить ref в oper, наступна ітерація
   end;
   ----
  end loop;
  ----------------------
  <<KIN>> null;
  commit;

end p_FIN_REZ;
/
 show err;
 
PROMPT *** Create  grants  P_FIN_REZ ***
grant EXECUTE                                                                on P_FIN_REZ       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_FIN_REZ       to RPBN001;
grant EXECUTE                                                                on P_FIN_REZ       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/p_fin_rez.sql =========*** End ***
 PROMPT ===================================================================================== 
 
