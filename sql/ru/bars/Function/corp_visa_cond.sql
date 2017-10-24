
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/corp_visa_cond.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CORP_VISA_COND (
    ref   in oper.ref%type,
    pdat    in oper.pdat%type,
    kv      in oper.kv%type,
    s       in oper.s%type,
    mfoa    in oper.mfoa%type,
    nlsa    in oper.nlsa%type,
    id_a    in oper.id_a%type,
    mfob    in oper.mfob%type,
    nlsb    in oper.nlsb%type,
    id_b    in oper.id_b%type
    ) return integer is
--
-- is_poshta_acc - возвращает 0/1 - флаг принадлежности счета филиалам Укрпочты
--
function is_poshta_acc(p_nls in accounts.nls%type, p_kv in accounts.kv%type) return integer is
    l_num   integer;
begin
    select 1 into l_num from accounts a, naek_customer_map m
    where a.rnk=m.rnk and m.ecode='POSA' and a.nls=p_nls and a.kv=p_kv;
    return 1;
exception when no_data_found then
    return 0;
end is_poshta_acc;
----
-- is_corp_acc - возвращает 0/1 - флаг принадлежности счета корпоративным клиентам
--
function is_corp_acc(p_nls in accounts.nls%type, p_kv in accounts.kv%type) return integer is
    l_num   integer;
begin
    select 1 into l_num from accounts a, naek_customer_map m
    where a.rnk=m.rnk and a.nls=p_nls and a.kv=p_kv;
    return 1;
exception when no_data_found then
    return 0;
end is_corp_acc;
--
begin
    case
    -- Ровенская атомная
    when    mfoa='333368'
        and nlsa in ('260423011737','260413021737','260023181737','260073018229')
    --and mfob not like '8%'
        and s>=5000000
        and id_b not in ('22555448','23304211','26063268','09333306','09333401','13983837',
                         '22579615','02760494','25930421','23303174','22565760','22588620')
        and sysdate<=to_date(to_char(trunc(pdat),'DD/MM/YYYY')||' 17:30', 'DD/MM/YYYY HH24:MI')
        then
        return 1;
    when    mfoa='333368'
        and is_poshta_acc(nlsa, kv)=1
        then
        return 1;
    when    mfoa='351823'
        and is_corp_acc(nlsa, kv)=1
        and substr(nlsa,1,4) in ('2600', '2604')
        then
        return 1;
    else
        return 0;
    end case;
end corp_visa_cond;
/
 show err;
 
PROMPT *** Create  grants  CORP_VISA_COND ***
grant EXECUTE                                                                on CORP_VISA_COND  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/corp_visa_cond.sql =========*** End
 PROMPT ===================================================================================== 
 