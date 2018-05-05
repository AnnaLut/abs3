create or replace function EBK_GET_CUST_SUBGRP_F
( p_group_id       in number   default 1,    /* БПК,Кредиты,Депозиты,,, */
  p_prc_quality_id in number   default null, /* Подгруппы на первой стр.,null значит Все*/
  p_nmk            in varchar2 default null,
  p_rnk            in number   default null,
  p_okpo           in varchar2 default null,
  p_ser            in varchar2 default null,
  p_numdoc         in varchar2 default null,
  p_quality_group  in varchar2 default null, /* Card, Default*/
  p_percent        in number   default null, /* Процент Качества*/
  p_attr_qty       in number   default null, /* Кол-во атрибутов для правки*/
  p_branch         in varchar2 default null,
  p_rn_from        in number   default 1,
  p_rn_to          in number   default 1
) return t_cust_subgrp_ebk pipelined
as
begin
  for cur in ( select cast (r.rnk as number(38)) as rnk,
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
                                and rownum = 1) as varchar2(60)
                          ) as last_user_upd,
                      r.branch
                 from ( select er.rnk,
                               er.group_id,
                               nvl(p_prc_quality_id,ebk_wforms_utl.get_cust_subgrp (er.group_id,er.quality)) as id_prc_quality,
                               er.okpo,
                               er.nmk,
                               er.quality,
                               cast( (select ser || ' ' || numdoc from person where rnk = er.rnk) as varchar2(31)
                                   )as document,
                               cast( (select to_char(bday,'dd.mm.yyyy') from person where rnk = er.rnk) as varchar2(10)
                                   ) as birth_day,
                               cast( (select count(a.name)
                                        from EBKC_REQ_UPDCARD_ATTR a -- tmp_ebk_req_updcard_attr
                                       where a.KF        = er.KF
                                         and a.RNK       = er.RNK
                                         and a.CUST_TYPE = er.CUST_TYPE
                                         and (a.recommendvalue is not null or a.descr is not null) ) as number
                                   ) as attr_qty,
                               cast( (select max(date_updated)
                                        from ebk_card_qlt_log
                                       where rnk = er.rnk) as date
                                   ) as last_card_upd,
                               er.branch
                          from ( select a1.*
                                   from ( select a.*
                                               , rownum r__n
                                            from ( select  er.*, c.nmk, c.okpo, c.branch
                                                     from EBKC_REQ_UPDATECARD er
                                                     join CUSTOMER c
                                                       on ( c.kf = er.kf and c.rnk = er.rnk )
                                                    where ( p_rnk is null or p_rnk = c.rnk )
                                                      and c.DATE_OFF is null
                                                      and er.group_id = p_group_id
                                                      and exists (select 1
                                                                    from ebk_qualityattr_gourps g
                                                                   where kf = er.kf
                                                                     and rnk = er.rnk
                                                                     and g.name = NVL(p_quality_group, 'card')
                                                                     and g.quality <= nvl(p_percent, 1000))
                                                      and (p_nmk    is null or c.nmk like p_nmk   )
                                                      and (p_okpo   is null or c.okpo   = p_okpo  )
                                                      and (p_branch is null or c.branch = p_branch)
                                                      and (p_ser||p_numdoc is null or exists ( select 1
                                                                                                from person
                                                                                               where (ser =    p_ser       or p_ser    is null)
                                                                                                 and (numdoc = p_numdoc    or p_numdoc is null)
                                                                                                 and rnk = c.rnk )
                                                           )
                                                      and (p_prc_quality_id is null or ebk_wforms_utl.get_cust_subgrp (er.group_id,er.quality) = p_prc_quality_id)
                                                      and (p_attr_qty is null or
                                                           p_attr_qty = ( select count (a.name)
                                                                            from EBKC_REQ_UPDCARD_ATTR a -- tmp_ebk_req_updcard_attr
                                                                           where a.KF        = er.KF
                                                                             and a.RNK       = er.RNK
                                                                             and a.CUST_TYPE = er.CUST_TYPE
                                                                             and a.CUST_TYPE = 'I'
                                                                             and (a.recommendvalue is not null or a.descr is not null)
                                                                        )
                                                          )
                                                    order by er.rnk
                                                 ) a
                                        ) a1
                                  where a1.r__n between p_rn_from and p_rn_to
                               ) er
                      ) r
  ) loop
    pipe row(r_cust_subgrp_ebk(cur.rnk, cur.group_id, cur.id_prc_quality, cur.okpo, cur.nmk, cur.quality, cur.document, cur.birth_day, cur.attr_qty, cur.last_card_upd, cur.last_user_upd, cur.branch));
  end loop;

  return;

end EBK_GET_CUST_SUBGRP_F;
/

show err;

grant EXECUTE on EBK_GET_CUST_SUBGRP_F to BARS_ACCESS_DEFROLE;
