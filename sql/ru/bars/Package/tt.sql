
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/tt.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TT as

FUNCTION ver RETURN varchar2;

function bpk_get_sep_sum (
  p_kod  number,
  p_kv   number,
  p_nls  varchar2,
  p_s    number
) return number;

function bpk_get_sep_nls6 (
  p_nls  varchar2,
  p_kv   number ) return varchar2;


end;
/
CREATE OR REPLACE PACKAGE BODY BARS.TT 
IS

G_VERSION  CONSTANT VARCHAR2(64)  := 'version 0.04 08/07/2010';

--OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC==OSC--
function bpk_get_sep_sum (
  p_kod  number,
  p_kv   number,
  p_nls  varchar2,
  p_s    number
) return number
is
  l_mfo varchar2(6);
  l_s number;
  i   number;
begin
  -- с ЮЛ комиссию не берем
  if substr(p_nls, 1, 4) = '2605' then
     l_s := 0;
  else
     begin
        l_mfo := SEP.G_mfoA;
        select 1 into i from banks where mfo = l_mfo and mfou = '300465';
        -- если пополнение от Сбербанка, комиссию не берем
        l_s := 0;
     exception when no_data_found then
        l_s := f_tarif(p_kod, p_kv, p_nls, p_s);
     end;
  end if;
  return l_s;
end bpk_get_sep_sum;

function bpk_get_sep_nls6 (
  p_nls  varchar2,
  p_kv   number ) return varchar2
is
  l_ob22    varchar2(2);
  l_branch  accounts.tobo%type;
begin

  -- тип платежной системы
  begin
     select decode(iif_s(t.card_type,1,'MC','MC','VISA'), 'VISA', '61', '19'),
            a.tobo
       into l_ob22, l_branch
       from accounts a, obpc_acct t
      where a.nls = p_nls
        and a.kv  = p_kv
        and a.acc = t.acc
        and rownum = 1;
  exception when no_data_found then
     l_ob22   := '19';
     l_branch := null;
  end;

  return nbs_ob22_null('6110', l_ob22, l_branch);

end bpk_get_sep_nls6;


FUNCTION ver RETURN varchar2 IS
BEGIN
  return 'Package TT version: '||G_VERSION||'.';
END;

END tt;
/
 show err;
 
PROMPT *** Create  grants  TT ***
grant EXECUTE                                                                on TT              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TT              to START1;
grant EXECUTE                                                                on TT              to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/tt.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 