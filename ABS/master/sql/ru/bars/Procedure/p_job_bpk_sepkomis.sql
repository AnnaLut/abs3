

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_BPK_SEPKOMIS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_BPK_SEPKOMIS ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_BPK_SEPKOMIS 
is
  i       number;
  l_tt    char(3) := 'PK0';
  l_dk    number := 1;
  l_tt_nlsm  tts.nlsm%type;
  l_tt_nlsk  tts.nlsk%type;
  l_tt_kvk   tts.kvk%type;
  l_tt_s     tts.s%type;
  l_tt_nazn  tts.nazn%type;
  l_nlsk  varchar2(14);
  l_nmsk  varchar2(38);
  l_kvk   number;
  l_sum   number;
  l_sum2  number;
  l_ref   number;
  rat_o   number;
  rat_b   number;
  rat_s   number;
  l_sos   number := 1;

  g_mfo   varchar2(6);
  l_bankdate date;

  function formula (
     p_formula varchar2,
     p_nls     varchar2,
     p_kv      number,
     p_s       number ) return varchar2
  is
     l_formula varchar2(2000);
     l_value   varchar2(500);
     l_mfoa    varchar2(14);
  begin
     if substr(p_formula, 1, 2) = '#(' then
        l_formula := substr(p_formula,3,length(p_formula)-3);
     else
        l_formula := p_formula;
     end if;
     begin
        l_formula := replace(l_formula, '#(NLSA)', '''' || p_nls || '''');
        l_formula := replace(l_formula, '#(KVA)',  to_char(p_kv));
        l_formula := replace(l_formula, '#(S)',    to_char(p_s));
        execute immediate
          'select ' || l_formula || ' from dual' into l_value;
     exception when others then
        raise_application_error(-(20203), '\9351 - Cannot get account nom via ' || p_formula || ' ' || sqlerrm, true);
     end;
     return l_value;
  end;

begin

  select nvl(nlsm,nlsa), nvl(nlsk,nlsb),
         nvl(kvk,980), s, nvl(nazn,name)
    into l_tt_nlsm, l_tt_nlsk, l_tt_kvk, l_tt_s, l_tt_nazn
    from tts where tt = l_tt;

  select getglobaloption('GLB-MFO') into g_mfo from dual;
  bc.subst_mfo(g_mfo);

  l_bankdate := gl.bdate;

  for z in ( select ref from pkk_sepkomis )
  loop
     for x in ( select * from oper where ref = z.ref and sos = 5 )
     loop

        -- снятие комиссии (только с физ. лиц)
        if substr(x.nlsb, 1, 4) = '2625' then

           -- если пополнение от Сбербанка, комиссию не берем
           select count(*) into i from banks where mfo = x.mfoa and mfou = '300465';

           if i = 0 then

              l_nlsk := formula(l_tt_nlsk, x.nlsb, x.kv2, x.s2);
              l_sum  := to_number(formula(l_tt_s, x.nlsb, x.kv2, x.s2));
              l_kvk  := l_tt_kvk;

              if l_sum > 0 and l_nlsk is not null then

                 -- наименование счета комиссии
                 select substr(a.nms,1,38) into l_nmsk
                   from accounts a
                  where a.nls = l_nlsk
                    and a.kv  = l_kvk;

                 -- сумма в валюте комиссии
                 if x.kv <> l_kvk then
                    GetXRate(rat_o, rat_b, rat_s, x.kv, l_kvk, l_bankdate);
                    l_sum2 := l_sum * rat_o;
                 else
                    l_sum2 := l_sum;
                 end if;

                 gl.ref(l_ref);

                 insert into oper (ref, tt, vob, nd, dk, pdat, vdat, datd,
                    nam_a, nlsa, mfoa, id_a,
                    nam_b, nlsb, mfob, id_b, kv, s, kv2, s2, nazn, userid)
                 values (l_ref, l_tt, 6, l_ref, l_dk, sysdate, l_bankdate, l_bankdate,
                    x.nam_b, x.nlsb, x.mfob, x.id_b,
                    l_nmsk, l_nlsk, gl.amfo, f_ourokpo,
                    x.kv2, l_sum, l_kvk, l_sum2, substr(l_tt_nazn,1,160), user_id);

                 gl.dyntt2 (l_sos, 0, 0, l_ref, l_bankdate, l_bankdate, l_tt, l_dk,
                    x.kv2, x.mfob, x.nlsb, x.s2,
                    l_kvk, f_ourmfo, l_nlsk, l_sum2, 0, 0);

                 gl.pay2(2, l_ref, l_bankdate);

              end if;

           end if;

        end if;

        -- удаление документа из очереди
        delete from pkk_sepkomis where ref = x.ref;

        commit;

     end loop;
  end loop;

  bc.set_context;

exception
  when no_data_found then
     bc.set_context;
     rollback;
  when others then
     bars_audit.info('job_bpk. err: ' || sqlerrm);
     bc.set_context;
     rollback;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_BPK_SEPKOMIS.sql =========**
PROMPT ===================================================================================== 
