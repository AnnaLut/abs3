

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_IMM_QDOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_IMM_QDOCS ***

  CREATE OR REPLACE PROCEDURE BARS.P_IMM_QDOCS (p_rec arc_rrp.rec%type, p_ref out decimal, p_msg out varchar2)
is
l_rec arc_rrp%rowtype;
l_ref arc_rrp.ref%type;
l_otm tzapros.otm%type;
l_dat tzapros.dat%type;
begin
--вичитуємо дані СЕП
 begin
  select a.* into l_rec from arc_rrp a where a.rec=p_rec for update;
  exception when no_data_found then p_msg:='Не знайдено запис з REC#'||to_char(p_rec);
  return;
  end;

  begin
  select t.otm, t.dat into l_otm, l_dat from tzapros t where t.rec=p_rec for update;
  exception when no_data_found then p_msg:='Не знайдено запис в TZAPROS з REC#'||to_char(p_rec);
  return;
  end;

  if l_otm!=3 and l_dat is null then
  --оплата
      begin
              savepoint sp_before;

                update tzapros s
                  set s.otm=3,
                  s.dat=gl.bdate
                  where s.rec=p_rec;


              gl.ref(l_ref);
              gl.in_doc3(ref_ => l_ref,
                         tt_ => 'PS2',
                         vob_ => 6,
                         nd_ => substr(l_ref,1,10),
                         pdat_ => sysdate,
                         vdat_ => gl.bdate,
                         dk_ => 1,
                         kv_ => l_rec.kv,
                         s_ => l_rec.s,
                         kv2_ => l_rec.kv,
                         s2_ => l_rec.s,
                         sk_ => null,
                         data_ => gl.bdate,
                         datp_ => gl.bdate,
                         nam_a_ => l_rec.nam_b,
                         nlsa_ => l_rec.nlsb,
                         mfoa_ => l_rec.mfob,
                         nam_b_ => l_rec.nam_a,
                         nlsb_ => l_rec.nlsa,
                         mfob_ => l_rec.mfoa,
                         nazn_ => substr('На Вашу вимогу/'||l_rec.nam_b||'/'||l_rec.nazn,1,160),
                         d_rec_ => null,
                         id_a_ => l_rec.id_b,
                         id_b_ => l_rec.id_a,
                         id_o_ => null,
                         sign_ => null,
                         sos_ => 1,
                         prty_ => 0,
                         uid_ => user_id);

                     paytt(flg_ => null,
                           ref_ => l_ref,
                           datv_ => gl.bdate,
                           tt_ => 'PS2',
                           dk0_ => 1,
                           kva_ =>  l_rec.kv,
                           nls1_ => l_rec.nlsb,
                           sa_ => l_rec.s,
                           kvb_ =>  l_rec.kv,
                           nls2_ => l_rec.nlsa,
                           sb_ => l_rec.s);

                  p_ref:=l_ref;
                  p_msg:=null;

               exception when others then
                 p_ref:=0;
                 p_msg:='Помилка:'||SQLERRM;
                 rollback to sp_before;
                 return;
      end;
  else
         p_ref:=0;
         p_msg:='Запис вже був оброблений '||to_char(l_dat, 'dd.mm.yyyy');
        return;
  end if;
  end p_imm_qdocs;
/
show err;

PROMPT *** Create  grants  P_IMM_QDOCS ***
grant EXECUTE                                                                on P_IMM_QDOCS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_IMM_QDOCS.sql =========*** End *
PROMPT ===================================================================================== 
