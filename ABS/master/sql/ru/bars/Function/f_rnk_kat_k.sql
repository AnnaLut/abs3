
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rnk_kat_k.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RNK_KAT_K 
 (p_rnk      number,
  p_kat      number,
  p_k23      number,
  mode_      number,
  istval_    number
--  CH_        number DEFAULT 0
 )  RETURN NUMBER  is
/*
 10-02-2015 LUDA + Портфельный метод
 03-07-2014 LUDA + MBDK + Корсчета
 16-04-2014 LUDA Добавилась дебеторка (mode_ in (3,4))
 mode_ = 1 - возвращает KAT
 mode_ = 2 - возвращает K
 mode_ = 3 - возвращает KAT для дебиторки
 mode_ = 4 - возвращает K   для дебиторки
 mode_ = 5 - возвращает KAT портфельный метод
 mode_ = 6 - возвращает K   портфельный метод
 ISTVAL= 0 - для валютных и нет источника валютной выручки
 ISTVAL= 1 - для всех гривневых и валютных, где есть источник вал.выручки
 ISTVAL= 2 - для коррсчетов и МБДК
*/
kat_ NUMBER;
k_   number;
cHH_ number;

begin
--   chh_:=1;
--   if chh_<>0 THEN
      begin
         select kat into kat_ from tmp_rnk_kat
         where rnk=p_rnk and istval=decode(istval_,2,1,istval_);
      EXCEPTION WHEN NO_DATA_FOUND THEN kat_:=p_kat;
      end;
--   else
  --    begin
    --     select kat23 into kat_ from v_rnk where rnk=p_rnk and istval=istval_;
      --EXCEPTION WHEN NO_DATA_FOUND THEN kat_:=p_kat;
      --end;
--   end if;

   if kat_>p_kat then
      if mode_ in (3,4) THEN  -- Дебиторка
         begin
            select k into k_
            from (select 1 kat,0   k from dual union all
                  select 2 kat,0.2 k from dual union all
                  select 3 kat,0.5 k from dual union all
                  select 4 kat,0.8 k from dual union all
                  select 5 kat,1   k from dual)
            where kat = kat_;
         EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
         end;
      elsif mode_ in (5,6) THEN  -- Портфельный метод
         begin
            select k into k_
            from (select 1 kat,0.02 k from dual union all
                  select 2 kat,0.1  k from dual union all
                  select 3 kat,0.4  k from dual union all
                  select 4 kat,0.8  k from dual union all
                  select 5 kat,1    k from dual)
            where kat = kat_;
         EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
         end;

      else
         if istval_ = 2 THEN
            begin
               select min(k23) into k_ from TMP_OB_KORR where kat23 = kat_;
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            end;
         else

            begin
               select min(k) into k_ from fin_kat where kat23 = kat_;
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            end;
         end if;
      end if;
   else
      kat_:=p_kat;
      k_  :=p_k23;
   end if;
   if mode_ in (1,3,5) THEN
      return kat_;
   else
      return k_;
   end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rnk_kat_k.sql =========*** End **
 PROMPT ===================================================================================== 
 