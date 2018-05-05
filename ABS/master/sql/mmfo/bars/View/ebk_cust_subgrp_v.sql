create or replace force view EBK_CUST_SUBGRP_V
( RNK
, GROUP_ID
, ID_PRC_QUALITY
, OKPO
, NMK
, QUALITY
, DOCUMENT
, BIRTH_DAY
, ATTR_QTY
, LAST_CARD_UPD
, LAST_USER_UPD
, BRANCH
) AS
select r.rnk,
       r.group_id,
       r.id_prc_quality,
       r.okpo,
       r.nmk,
       r.quality,
       r.document,
       r.birth_day,
       r.attr_qty,
       r.last_card_upd,
       ( select s.fio
           from staff$base s
              , ebk_card_qlt_log l
          where l.rnk = r.rnk
            and l.date_updated = r.last_card_upd
            and s.id = l.user_id
            and rownum=1
       )  as last_user_upd,
       r.branch
  from ( select teru.rnk,
                teru.group_id,
                EBK_WFORMS_UTL.GET_CUST_SUBGRP( teru.group_id,teru.quality) as id_prc_quality,
                c.okpo,
                c.nmk,
                teru.quality,
                (select ser ||' '||numdoc from person where rnk = teru.rnk) as document,
                (select to_char(bday,'dd.mm.yyyy')  from person where rnk = teru.rnk ) as birth_day,
                (select count(name) 
                   from EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr
                  where kf        = teru.KF
                    and rnk       = teru.RNK
                    and CUST_TYPE = teru.CUST_TYPE
                    and quality <>'C'
                ) as attr_qty,
                (select max(date_updated) from ebk_card_qlt_log where rnk = teru.rnk) as last_card_upd,
                c.branch
          from EBKC_REQ_UPDATECARD teru
          join CUSTOMER c
            on ( c.KF = teru.KF and c.RNK = teru.RNK )
         where teru.CUST_TYPE = 'I'
           and c.DATE_OFF is null
       ) r;

show errors;

grant SELECT on EBK_CUST_SUBGRP_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_CUST_SUBGRP_V to BARSREADER_ROLE;
