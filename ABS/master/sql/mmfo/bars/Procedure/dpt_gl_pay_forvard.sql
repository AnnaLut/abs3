

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_GL_PAY_FORVARD.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_GL_PAY_FORVARD ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_GL_PAY_FORVARD 
is
begin

    if (gl.bd() = date '2017-09-29') then
        for j in (select t.interest_account,
                         t.tt,
                         t.new_ref,
                         t.tax_amount,
                         fost(a.acc, gl.bd) acc_ost
                    from bars.tmp_dpt_tax_documents t,
                         accounts a,
                         bars.oper o
                   where o.ref = t.new_ref
                     and o.vdat = date '2017-09-29'
                     and o.sos = 3
                     and o.kf = sys_context('bars_context', 'user_mfo')
                     and a.nls = t.interest_account
                     and a.kv = t.kv
                     and a.kf = sys_context('bars_context', 'user_mfo')
                   order by t.interest_account) loop
          begin
            savepoint sp1;

            if j.acc_ost >= j.tax_amount then

              gl.pay(2, j.new_ref, gl.bd);

              bars_audit.info('make_int solution ref for pay : ' || j.new_ref||' '||gl.bd);

            end if;

          exception
            when others then
              rollback to sp1;

             bars_audit.info('make_int solution ref for pay LOOP Error: ' ||j.new_ref|| sqlerrm);

          end;
        end loop;

        commit;
    end if;
 exception
        when others then
           dbms_output.put_line('make_int solution ref for pay Error: ' ||sqlerrm );
end dpt_gl_pay_forvard;
/
show err;

PROMPT *** Create  grants  DPT_GL_PAY_FORVARD ***
grant EXECUTE                                                                on DPT_GL_PAY_FORVARD to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_GL_PAY_FORVARD to DPT_ADMIN;
grant EXECUTE                                                                on DPT_GL_PAY_FORVARD to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_GL_PAY_FORVARD.sql =========**
PROMPT ===================================================================================== 
