

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_REZ23.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_REZ23 ***

  CREATE OR REPLACE PROCEDURE BARS.CP_REZ23 (p_dat         IN DATE,
                                      p_ref         IN cp_deal.REF%TYPE,
                                      p_srezerv23   IN NUMBER,
                                      p_count       IN NUMBER,
                                      p_pereoc23    IN NUMBER,
                                      p_FL_ALG23    IN NUMBER )
IS

-- 19-07-2016 LUDA Добавлена функция расчета переоценки по ЦБ (23) f_cp_pereoc23

   title        CONSTANT VARCHAR2 (9) := 'cp_rez23:';
   l_id         cp_kod.id%TYPE;
   cp           cp_pereoc_v%ROWTYPE;
   l_pereoc23   number;

begin
   if p_srezerv23 is null then return; end if;

   begin
      select ID into l_id from cp_deal  where ref = p_ref;
   exception when no_data_found then bars_audit.error(title || 'Ідентифікатор ЦП (та реф) не знайдено для реф = ' || p_ref);
   end;

   select * into cp from cp_pereoc_v where ref=p_ref;
   l_pereoc23 := f_cp_pereoc23(p_fl_alg23 => p_fl_alg23, p_rez23  => p_srezerv23, p_n1   => cp.N1  , p_d1  => cp.D1 , p_p1    => cp.p1   ,
                               p_r1       => cp.r1     , p_unrec1 => cp.unrec1  , p_r21  => cp.r21 , p_r31 => cp.r31, p_expr1 => cp.expr1,
                               p_expn1    => cp.expn1  , p_cena   => cp.cena    , p_kolk => cp.kolk);
   logger.info('CP_REZ 2 : ref = ' || cp.ref || 'l_pereoc23  = '|| l_pereoc23  || 'p_pereoc23  = ' || p_pereoc23  ) ;
   update CP_REZERV23 set S_REZERV23 = p_srezerv23, cp_count = p_count, pereoc23 = l_pereoc23, fl_alg23 = p_FL_ALG23
   where ref = p_ref and DATE_REPORT = p_dat and ID = l_id;

   if sql%rowcount = 0 then
      begin
         insert into CP_REZERV23(ID  , REF  , DATE_REPORT, S_REZERV23 , cp_count, pereoc23  , fl_alg23  )
                         values (l_id, p_ref, p_dat      , p_srezerv23, p_count , l_pereoc23, p_fl_alg23);
      end;
   end if;

end cp_rez23;
/
show err;

PROMPT *** Create  grants  CP_REZ23 ***
grant EXECUTE                                                                on CP_REZ23        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_REZ23        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_REZ23.sql =========*** End *** 
PROMPT ===================================================================================== 
