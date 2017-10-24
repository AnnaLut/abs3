
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ebk_get_cust_subgrp_f.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EBK_GET_CUST_SUBGRP_F (p_group_id in number default 1, /*БПК,Кредиты,Депозиты,,, */
                                                       p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                                                       p_nmk in varchar2 default null,
                                                       p_rnk in number default null,
                                                       p_okpo in varchar2 default null,
                                                       p_ser in varchar2 default null,
                                                       p_numdoc in varchar2 default null,
                                                       p_quality_group in varchar2 default null, /*Card, Default*/
                                                       p_percent  in number default null,  /*Процент Качества*/
                                                       p_attr_qty in number default null, /*Кол-во атрибутов для правки*/
                                                       p_branch   in varchar2 default null,
                                                       p_rn_from  in number default 1,
                                                       p_rn_to    in number default 1) return t_cust_subgrp_ebk pipelined as
begin
  for cur in ( select cast (r.rnk as number (38)) as rnk,
                      cast (r.group_id as number(1)) as group_id,
                      cast (r.id_prc_quality as number) id_prc_quality,
                      cast (r.okpo as varchar2(14)) as okpo,
                      cast(r.nmk as varchar2(70)) as nmk,
                      cast(r.quality as number(6,2)) as quality,
                      cast(r.document as varchar2(31)) as document,
                      cast(r.birth_day as varchar2(10))as birth_day,
                      cast(r.attr_qty as number ) as  attr_qty,
                      cast(r.last_card_upd as date)as last_card_upd,
                      cast( (select s.fio
                               from staff$base s, ebk_card_qlt_log l
                              where l.rnk = r.rnk
                                and l.date_updated = r.last_card_upd
                                and s.id = l.user_id
                                and rownum = 1) as varchar2(60)) as last_user_upd,
                      r.branch
              from (select teru.rnk,
                           teru.group_id,
                           nvl(p_prc_quality_id,ebk_wforms_utl.get_cust_subgrp (teru.group_id,
                                                  teru.quality)) as id_prc_quality,
                           teru.okpo,
                           teru.nmk,
                           teru.quality,
                          cast( (select ser || ' ' || numdoc
                              from person
                             where rnk = teru.rnk) as varchar2(31))as document,
                           cast((select to_char (bday, 'dd.mm.yyyy')
                              from person
                             where rnk = teru.rnk) as varchar2(10)) as birth_day,
                         cast( (select count (a.name)
                             from tmp_ebk_req_updcard_attr    a
                            where a.kf = teru.kf and a.rnk = teru.rnk
                              --24.09.2015 Irina Ivanova
                              --and quality <> 'C'
                              and (a.recommendvalue is not null or a.descr is not null)
                              ) as number) as attr_qty,
                         cast( (select max (date_updated)
                             from ebk_card_qlt_log
                            where rnk = teru.rnk) as date )
                            as last_card_upd,
                         teru.branch
             from (select a1.* from
                             (select  a.*, rownum r__n
                                 from ( select  teru.*, c.nmk, c.okpo, c.branch
                                          from tmp_ebk_req_updatecard teru, customer c, (select gl.kf as kf from dual) ss_kf
                                         where (p_rnk is null or p_rnk = c.rnk)
                                           and teru.kf = ss_kf.kf
                                           and c.rnk = teru.rnk
                                           and c.date_off is null
                                           and group_id = p_group_id
                                           --24.09.2015 Irina.Ivanova
                                           --and ebk_wforms_utl.show_card_accord_quality(ss_kf.kf, teru.rnk, p_quality_group, p_percent) = 1
                                           and exists (select 1
                                                         from ebk_qualityattr_gourps g
                                                        where kf = teru.kf
                                                          and rnk = teru.rnk
                                                          and g.name = NVL(p_quality_group, 'card')
                                                          and g.quality <= nvl(p_percent, 1000))
                                           and (p_nmk is null or c.nmk like p_nmk)
                                           and (p_okpo is null or c.okpo = p_okpo)
                                           and (p_branch is null or c.branch = p_branch)
                                           and (p_ser||p_numdoc is null or exists    (select 1
                                                                                       from person
                                                                                       where (ser =    p_ser       or p_ser    is null)
                                                                                         and (numdoc = p_numdoc    or p_numdoc is null)
                                                                                         and rnk = c.rnk))
                                           and (p_prc_quality_id is null or ebk_wforms_utl.get_cust_subgrp (teru.group_id,teru.quality) = p_prc_quality_id)
                                           and (p_attr_qty  is null or   (select count (a.name) from tmp_ebk_req_updcard_attr a
                                                                            where a.kf = teru.kf and a.rnk = teru.rnk
                                                                            --24.09.2015 Irina Ivanova
                                                                            --and quality <> 'C'
                                                                            and (a.recommendvalue is not null or a.descr is not null)
                                                                            ) = p_attr_qty)

                                           order by teru.rnk ) a
                                          ) a1
                               where a1.r__n between p_rn_from and p_rn_to) teru) r

  ) loop
    pipe row(r_cust_subgrp_ebk(cur.rnk, cur.group_id, cur.id_prc_quality, cur.okpo, cur.nmk, cur.quality, cur.document, cur.birth_day, cur.attr_qty, cur.last_card_upd, cur.last_user_upd, cur.branch));
  end loop;

  return;
end ebk_get_cust_subgrp_f;
/
 show err;
 
PROMPT *** Create  grants  EBK_GET_CUST_SUBGRP_F ***
grant EXECUTE                                                                on EBK_GET_CUST_SUBGRP_F to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ebk_get_cust_subgrp_f.sql =========
 PROMPT ===================================================================================== 
 