

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CONFIRM_ACC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CONFIRM_ACC ***

  CREATE OR REPLACE PROCEDURE BARS.CONFIRM_ACC (p_acc     in number,
                      p_confirm in number) is

  l_row w4_acc_instant%rowtype;
  l_nd  w4_acc.nd%type;
  l_rnk customer.rnk%type;
  l_cardcode w4_acc.card_code%type;
  type t_product is record ( product_grp  w4_product_groups.code%type,
                             product_code w4_product.code%type,
                             card_code    w4_card.code%type,
                             sub_code     w4_card.sub_code%type,
                             kv           w4_product.kv%type,
                             nbs          w4_product.nbs%type,
                             ob22         w4_product.ob22%type,
                             tip          w4_product.tip%type,
                             custtype     w4_product_groups.client_type%type,
                             schemeid     w4_product_groups.scheme_id%type,
                             rate         cm_product.percent_osn%type,
                             flag_instant w4_subproduct.flag_instant%type,
                             date_instant w4_subproduct.date_instant%type,
                             flag_kk      w4_subproduct.flag_kk%type );
  l_product t_product;
  l_term number;
  ora_lock exception;
  pragma exception_init(ora_lock, -54);
procedure iget_product (
  p_cardcode  in     w4_product.code%type,
  p_term      in out number,
  p_product      out t_product )
is
  l_prod_max_term cm_product.mm_max%type;
  l_term_min      w4_tips.term_min%type;
  l_term_max      w4_tips.term_min%type;
begin

  begin
     select b.grp_code, b.code, c.code, c.sub_code,
            b.kv, b.nbs, b.ob22, b.tip,
            s.flag_instant, s.date_instant, s.flag_kk,
            a.client_type, a.scheme_id, m.percent_osn,
            m.mm_max, t.term_min, t.term_max
       into p_product.product_grp, p_product.product_code,
            p_product.card_code, p_product.sub_code,
            p_product.kv, p_product.nbs, p_product.ob22, p_product.tip,
            p_product.flag_instant, p_product.date_instant, p_product.flag_kk,
            p_product.custtype, p_product.schemeid, p_product.rate,
            l_prod_max_term, l_term_min, l_term_max
       from w4_product_groups a, w4_product b, w4_card c, w4_subproduct s, w4_tips t, cm_product m
      where c.code = p_cardcode
        and c.sub_code = s.code
        and c.product_code = b.code
        and b.grp_code = a.code
        and b.tip = t.tip
        and c.product_code = m.product_code(+);
  exception when no_data_found then
     -- Не найден продукт p_cardcode
     bars_error.raise_nerror('BPK', 'CARDCODE_NOT_FOUND', p_cardcode);
  end;

  -- проверка срока
  if p_term is not null then
     if p_term < l_term_min or p_term > l_term_max or p_term > nvl(l_prod_max_term, l_term_max) then
        -- Указанный срок действия карты не соответствует типу карты или продукта
        bars_error.raise_nerror('BPK', 'TERM_ERROR');
     end if;
  else
     p_term := l_prod_max_term;
  end if;

end iget_product;  
begin

      l_row := null;
      begin
        select *
          into l_row
          from w4_acc_instant t
         where t.acc = p_acc
           for update nowait;
      exception
        when ora_lock then
          raise_application_error(-20000,
                                  'Рахунок ACC: ' || p_acc ||
                                  ' заблоковано іншим користувачем ' ||
                                  sqlerrm);
      end;

      select w.nd, w.card_code into l_nd, l_cardcode from w4_acc w where w.acc_pk = p_acc;

      -- Відхилення підтвердження
      if p_confirm = 0 then
        l_rnk := getglobaloption('OUR_RNK');
        if l_rnk is null then
          bars_error.raise_nerror('BPK', 'PAR_RNK_NOT_FOUND');
        end if;
        delete from cm_client_que t where t.id = l_row.reqid;
        delete from bpk_parameters b where b.nd = l_nd;
        delete from w4_acc w where w.nd = l_nd;
        delete from w4_acc_instant wa where wa.acc = p_acc;

        update accounts t set t.rnk = l_rnk where t.acc = p_acc;
        --Підтвердження
      elsif p_confirm = 1 then
        iget_product(l_cardcode, l_term, l_product);
            -- привязываем счет к клиенту
        update accounts
           set nbs = l_product.nbs,
               tip = l_product.tip,
               daos = decode(dapp,null,bankdate, daos),
               dazs = null
         where acc = p_acc;

        -- доступ к счету
        p_after_open_acc(p_acc);

        -- удаляем счет из справочника счетов Instant после привязки
        update w4_acc_instant
           set state  = 2
         where acc = p_acc;

      end if;
      insert into w4_conf_acc_stat
        (acc, state)
      values
        (p_acc, p_confirm);
end;
/
show err;

PROMPT *** Create  grants  CONFIRM_ACC ***
grant EXECUTE                                                                on CONFIRM_ACC     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CONFIRM_ACC.sql =========*** End *
PROMPT ===================================================================================== 
