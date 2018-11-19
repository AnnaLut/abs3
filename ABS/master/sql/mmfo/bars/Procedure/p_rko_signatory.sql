

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RKO_SIGNATORY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RKO_SIGNATORY ***

  CREATE OR REPLACE PROCEDURE BARS.P_RKO_SIGNATORY (
   p_mod                      number,
   p_id                       number,
   p_full_nm_nom              rko_signatory.full_nm_nom%type,
   p_branch                   varchar2,
   p_full_nm_gen              rko_signatory.full_nm_gen%type,
   p_short_nm_nom             rko_signatory.short_nm_nom%type,
   p_position_prsn_nom        rko_signatory.position_prsn_nom%type,
   p_division_prsn_gen        rko_signatory.division_prsn_gen%type,
   p_position_prsn_gen        rko_signatory.position_prsn_gen%type,
   p_doc_nm_gen               rko_signatory.doc_nm_gen%type,
   p_notary_nm_gen            rko_signatory.notary_nm_gen%type,
   p_notary_tp_gen            rko_signatory.notary_tp_gen%type,
   p_attorney_dt              rko_signatory.attorney_dt%type,
   p_attorney_num             rko_signatory.attorney_num%type,
   p_notarial_district_gen    rko_signatory.notarial_district_gen%type,
   p_active_f                 rko_signatory.active_f%type)
 as
   l_id   number;
   l_branch varchar2(30);
   l_exeption_nn    exception;
   l_field_name     varchar2(100);
 begin
   if p_mod = 1 then

      select branch  into l_branch from rko_signatory where id=p_id;

     if l_branch like  sys_context('bars_context','user_branch')||'%'  then

      update v_rko_signatory
         set branch = p_branch,
             full_nm_nom = p_full_nm_nom,
             full_nm_gen = p_full_nm_gen,
             short_nm_nom = p_short_nm_nom,
             position_prsn_nom = p_position_prsn_nom,
             division_prsn_gen = p_division_prsn_gen,
             position_prsn_gen = p_position_prsn_gen,
             doc_nm_gen = p_doc_nm_gen,
             notary_nm_gen = p_notary_nm_gen,
             notary_tp_gen = p_notary_tp_gen,
             attorney_dt = p_attorney_dt,
             attorney_num = p_attorney_num,
             notarial_district_gen = p_notarial_district_gen,
             active_f = p_active_f
       where branch = p_branch and id = p_id;

     else  bars_error.raise_error('RKO', 3);

    end if;

       if p_active_f = 1 then
            update v_rko_signatory
                set active_f = 0
            where branch = p_branch and id != p_id;
       end if;

   elsif p_mod = 2  then
     select bars_sqnc.get_nextval('s_rko_signatory') into l_id from dual;

        if p_branch is null
           then
            bars_error.raise_error('RKO', 1);
       end if;


    if p_branch like  sys_context('bars_context','user_branch')||'%'  then

      insert into rko_signatory
                              (id, full_nm_nom, branch, full_nm_gen, short_nm_nom, position_prsn_nom, division_prsn_gen,
                               position_prsn_gen, doc_nm_gen, notary_nm_gen, notary_tp_gen, attorney_dt, attorney_num,
                               notarial_district_gen, active_f, kf)

      values                 (l_id, p_full_nm_nom, p_branch, p_full_nm_gen, p_short_nm_nom, p_position_prsn_nom, p_division_prsn_gen,
                               p_position_prsn_gen, p_doc_nm_gen, p_notary_nm_gen, p_notary_tp_gen, p_attorney_dt, p_attorney_num,
                               p_notarial_district_gen, 0, sys_context('bars_context','user_mfo'));

                             --  if p_active_f = 1 then
                               --   update v_rko_signatory
                               --     set active_f = 0
                                 --- where branch = p_branch and p_id != p_id;
                              -- end if;
                  else  bars_error.raise_error('RKO', 1);

     end if;

   elsif p_mod = 3 then

     if p_branch like  sys_context('bars_context','user_branch')||'%'  then

       delete from rko_signatory  where id =p_id;
       else  bars_error.raise_error('RKO', 4);

     end if;

   end if;
end;
/
show err;

PROMPT *** Create  grants  P_RKO_SIGNATORY ***
grant EXECUTE                                                                on P_RKO_SIGNATORY to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_RKO_SIGNATORY to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RKO_SIGNATORY.sql =========*** E
PROMPT ===================================================================================== 
