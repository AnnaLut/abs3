

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_JOURNAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_JOURNAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_JOURNAL ("BRANCH", "BRANCH_NAME", "JOURNAL_NUM", "NUM", "NUM_TXT", "CREATE_DATE", "MODIFY_DATE", "DELETE_DATE", "CONTR_ID", "CONTR_NUM", "CONTR_DATE", "RNK", "OKPO", "NMK", "BENEF_ID", "BENEF_NAME", "COUNTRY_ID", "COUNTRY_NAME", "CONTROL_DATE", "CONCLUSION", "COMMENTS", "DIRECT", "DOC_KIND", "DOC_TYPE", "DOC_TYPE_NAME", "BOUND_ID", "DOC_ID", "VAL_DATE", "KV_P", "S_P", "S_P_DIG", "ALLOW_DATE", "KV_V", "S_V", "S_V_DIG", "VMD_NUM", "FILE_DATE", "FILE_NAME", "STR_LEVEL", "DEL_JOURNAL", "COMISS", "LINK_DATE", "ZSQ_VP", "ZQ_VT") AS 
  select BRANCH,BRANCH_NAME,JOURNAL_NUM,NUM,NUM_TXT,CREATE_DATE,MODIFY_DATE,DELETE_DATE,CONTR_ID,CONTR_NUM,CONTR_DATE,RNK,OKPO,NMK,BENEF_ID,BENEF_NAME,COUNTRY_ID,COUNTRY_NAME,CONTROL_DATE,CONCLUSION,COMMENTS,DIRECT,DOC_KIND,DOC_TYPE,DOC_TYPE_NAME,BOUND_ID,DOC_ID,VAL_DATE,KV_P,S_P,S_P_DIG,ALLOW_DATE,KV_V,S_V,S_V_DIG,VMD_NUM,FILE_DATE,FILE_NAME,STR_LEVEL,DEL_JOUTRNAL,COMISS,LINK_DATE,ZSQ_VP,ZQ_VT from
    (select b.branch, bra.name as branch_name, b.journal_num, b.journal_id as num,
            decode(l.payment_id,-1,nvl2(b.delete_date,'X',null)||to_char(b.journal_id,'B999999999'),nvl2(l.delete_date,'x',null)) as num_txt,
            /*decode(l.payment_id, -1, b.create_date, l.create_date nvl2(l.vmd_id, br.create_date , bf.create_date)) as create_date,*/
            b.create_date, b.modify_date,  decode(l.payment_id, -1, b.delete_date, l.delete_date) as delete_date,
            b.contr_id, decode(l.payment_id, -1, b.contr_num, null) as contr_num, decode(l.payment_id, -1, b.contr_date, null) as contr_date,
            b.rnk, decode(l.payment_id, -1, a.okpo, null) as okpo, decode(l.payment_id, -1, a.nmk, null) as nmk, b.benef_id,
            decode(l.payment_id, -1, n.benef_name, null) as benef_name, n.country_id, decode(l.payment_id, -1, cu.name, null) as country_name,
            decode(l.payment_id,-1, to_char(cim_mgr.get_control_date(0,b.type_id, b.bound_id),'dd.mm.yy'), '' ) as control_date,
            decode(l.payment_id,-1,
              (select concatstr('№'||cc.out_num||' від '||to_char(cc.out_date,'dd.mm.yy')) from cim_conclusion cc, cim_conclusion_link cl
                where cc.id=cl.cnc_id and cl.delete_date is null and decode(b.type_id, 0, cl.payment_id, cl.fantom_id)=b.bound_id)
              , '') as conclusion,
            decode(l.payment_id,-1, b.comments, l.comments) as comments,
            decode(decode(l.payment_id, -1, b.direct, decode(b.direct, 0, 1, 1, 0)), 0, 'Вхідний', 1,'Вихідний') as direct,
            decode(l.payment_id, -1, 0, 1) as doc_kind, decode(l.payment_id, -1, b.type_id, nvl2(l.vmd_id, 0, f.act_type)) as doc_type,
            decode(l.payment_id, -1, b.type_name,
              (select max(name) from cim_act_types where type_id=nvl2(l.vmd_id, 0, f.act_type))) as doc_type_name,
            b.bound_id, decode(l.payment_id, -1, b.bound_id, nvl(l.vmd_id, l.act_id)) as doc_id,
            decode(l.payment_id, -1, b.val_date, null) as val_date,
            decode(l.payment_id, -1, to_char(b.kv_p,'999'), '') as kv_p,
            decode(l.payment_id, -1, to_char(b.s_p+b.comiss,'fm999G999G999G990D00','nls_numeric_characters='', '''), '') as s_p,
            decode(l.payment_id, -1, b.s_p+b.comiss, null) as s_p_dig,
            decode(l.payment_id, -1, to_date(null), nvl2(l.vmd_id, r.allow_dat , f.allow_date)) as allow_date,
            decode(l.payment_id, -1, '', to_char(nvl2(l.vmd_id, r.kv , f.kv ),'999')) as kv_v,
            decode(l.payment_id, -1,'',
              to_char(round(nvl2(l.vmd_id, l.s*br.s_vt/br.s_vk, l.s*bf.s_vt/bf.s_vk )/100,2),'fm999G999G999G990D00','nls_numeric_characters='', ''')) as s_v,
            decode(l.payment_id, -1, to_number(null), round(nvl2(l.vmd_id, l.s*br.s_vt/br.s_vk, l.s*bf.s_vt/bf.s_vk )/100,2)) as s_v_dig,
            decode(l.payment_id, -1, '', nvl2(l.vmd_id, r.num , f.num)) as vmd_num,
            decode(l.payment_id, -1, '', nvl2(l.vmd_id, to_char(r.f_date, 'dd.mm.yy'), to_char(f.file_date, 'dd.mm.yy'))) as file_date,
            decode(l.payment_id, -1, '', nvl2(l.vmd_id, r.f_name, f.file_name)) as file_name, decode(l.payment_id, -1, -1, l.id) as str_level,
            nvl2(decode(l.payment_id, -1, b.delete_date, l.delete_date), 1, 0) as del_joutrnal,
            decode(l.payment_id, -1, decode( b.comiss, 0, null, to_char(b.comiss,'fm999G999G999G990D00','nls_numeric_characters='', ''')), null) as comiss,
            l.create_date as link_date,
            decode(l.payment_id, -1, gl.p_icurval(b.kv_p, decode(b.s_cv/100, 0, 0, round((b.s_p+ decode(b.direct, 0, b.comiss, -b.comiss))*(b.s_cv/100-b.s_pd)/(b.s_cv/100),2))/*zs_vp*/ * 100, nvl(b.date_max_bound_doc,b.val_date)) / 100, null) as zsq_vp,
            null as zq_vt-- для імпортних МД не відображається 
       from (select b.bound_id, b.branch, b.journal_num, b.journal_id, b.create_date, b.modify_date, b.delete_date, b.contr_id, c.contr_type,
                    decode(b.contr_id, 0, cc.c_num, c.num) as contr_num, to_char(decode(b.contr_id, 0, cc.c_date, c.open_date),'dd.mm.yy') as contr_date,
                    decode(b.contr_id, 0, cc.rnk, c.rnk) as rnk, decode(b.contr_id, 0, cc.benef_id, c.benef_id) as benef_id, b.comments,
                    b.direct, 0 as type_id, 'Платіж' as type_name, o.vdat as val_date, o.kv as kv_p, round(b.s/100,2) as s_p, round(b.comiss/100,2) as comiss,
                    b.s_cv,
                    nvl((select sum(s) from cim_link where delete_date is null and payment_id = b.bound_id)/100,0) as s_pd,
                    (select max(nvl2(l.vmd_id,
                                                    (select max(allow_dat) from v_cim_customs_decl where cim_id in (select vmd_id from cim_vmd_bound  where bound_id = l.vmd_id)),
                                                    (select max(allow_date) from cim_acts where act_id in (select act_id  from cim_act_bound where bound_id = l.act_id))))
                     from cim_link l where l.delete_date is null and l.payment_id = b.bound_id) as date_max_bound_doc                   
               from cim_payments_bound b
                    join cim_contracts c on c.contr_id=b.contr_id
                    left outer join cim_bound_data cc on cc.bound_id=b.bound_id
                    join v_cim_oper o on o.ref=b.ref
              where b.uid_del_journal is null and b.contr_id is not null
          union all
             select b.bound_id, b.branch, b.journal_num, b.journal_id, b.create_date, b.modify_date, b.delete_date, b.contr_id, c.contr_type,
                    c.num, to_char(c.open_date,'dd.mm.yy') as contr_date,
                    c.rnk,  c.benef_id, b.comments,
                    b.direct, o.payment_type as type_id, t.type_name, o.val_date, o.kv as kv_p, round(b.s/100,2) as s_p, round(b.comiss/100,2) as comiss,
                    b.s_cv,
                    nvl((select sum(s) from cim_link where delete_date is null and fantom_id = b.bound_id)/100,0) as s_pd,
                    (select max(nvl2(l.vmd_id,
                                                    (select max(allow_dat) from v_cim_customs_decl where cim_id in (select vmd_id from cim_vmd_bound where bound_id = l.vmd_id)),
                                                    (select max(allow_date) from cim_acts where act_id in (select act_id from cim_act_bound where bound_id = l.act_id))))
                     from cim_link l where l.delete_date is null and l.fantom_id = b.bound_id) as date_max_bound_doc                    
               from cim_fantoms_bound b
                    join cim_contracts c on c.contr_id=b.contr_id
                    join cim_fantom_payments o on o.fantom_id=b.fantom_id
                    join cim_payment_types t on t.type_id=o.payment_type
              where b.uid_del_journal is null and b.contr_id is not null
            ) b-- вибираєм первинні стрічки (Платежі/фантоми)
            join customer a on a.rnk=b.rnk
            join cim_beneficiaries n on n.benef_id=b.benef_id
            join country cu on cu.country=n.country_id
            join (select payment_id, fantom_id, vmd_id, act_id, s, delete_date, uid_del_journal, id, comments, create_date
                    from cim_link union all select -1, null, null, null, null, null, null, null, null, null from dual) l
              on (l.uid_del_journal is null and decode(b.type_id,0,l.payment_id,l.fantom_id)=b.bound_id and b.contr_type=1) or l.payment_id=-1
            left outer join cim_vmd_bound br on br.bound_id=l.vmd_id and l.vmd_id is not null
            left outer join v_cim_customs_decl r on r.cim_id=br.vmd_id and l.vmd_id is not null
            left outer join cim_act_bound bf on bf.bound_id=l.act_id and l.act_id is not null
            left outer join cim_acts f on f.act_id=bf.act_id and l.act_id is not null
            join branch bra on bra.branch=b.branch
  union all
     select b.branch, bra.name, b.journal_num, b.journal_id as num,
            decode(l.vmd_id, -1, nvl2(b.delete_date,'X',null)||to_char(b.journal_id,'B999999999'),nvl2(l.delete_date,'x',null)) as num_txt,
            /*decode(l.vmd_id, -1, b.create_date, l.create_date nvl2(l.payment_id, br.create_date, bf.create_date)) as create_date,*/
            b.create_date, b.modify_date, decode(l.vmd_id, -1, b.delete_date, l.delete_date) as delete_date,
            b.contr_id, decode(l.vmd_id, -1, b.contr_num, null) as contr_num, decode(l.vmd_id, -1, b.contr_date, null) as contr_date,
            b.rnk, decode(l.vmd_id, -1, a.okpo, null) as okpo, decode(l.vmd_id, -1, a.nmk, null) as nmk, b.benef_id,
            decode(l.vmd_id, -1, n.benef_name, null) as benef_name, n.country_id, decode(l.vmd_id, -1, cu.name, null) as country_name,
            decode(l.vmd_id, -1, to_char(cim_mgr.get_control_date(1,b.type_id, b.bound_id),'dd.mm.yy'), '' ) as control_date,
            decode(l.vmd_id, -1,
              (select concatstr('№'||cc.out_num||' від '||to_char(cc.out_date,'dd.mm.yy')) from cim_conclusion cc, cim_conclusion_link cl
                where cc.id=cl.cnc_id and cl.delete_date is null and decode(b.type_id, 0, cl.vmd_id, cl.act_id)=b.bound_id)
              , '') as conclusion,
            decode(l.vmd_id,-1, b.comments, l.comments) as comments,
            decode(decode(l.vmd_id, -1, b.direct, decode(b.direct, 0, 1, 1, 0)), 0, 'Вхідний', 1,'Вихідний') as direct,
            decode(l.vmd_id, -1, 1, 0) as doc_kind, decode(l.vmd_id, -1, b.type_id, nvl2(l.payment_id, 0, bfo.payment_type)) as doc_type,
            decode(l.vmd_id, -1, b.type_name,
              (select max(type_name) from cim_payment_types where type_id=nvl2(l.payment_id, 0, bfo.payment_type))) as doc_type_name,
            b.bound_id, decode(l.vmd_id, -1, b.bound_id, nvl(l.payment_id, l.fantom_id)) as doc_id,
            decode(l.vmd_id, -1, to_date(null), nvl2(l.payment_id, bro.vdat, bfo.val_date)) as val_date,
            decode(l.vmd_id, -1, '', to_char(nvl2(l.payment_id, bro.kv , bfo.kv ),'999')) kv_p,
            decode(l.vmd_id, -1, '', to_char(round(nvl2(l.payment_id, (br.s+br.comiss)*l.s/br.s_cv, (bf.s+bf.comiss)*l.s/bf.s_cv )/100 ,2),
                                               'fm999G999G999G990D00','nls_numeric_characters='', ''')) as s_p,
            decode(l.vmd_id, -1, to_number(null), round(nvl2(l.payment_id, (br.s+br.comiss)*l.s/br.s_cv, (bf.s+bf.comiss)*l.s/bf.s_cv )/100 ,2)) as s_p_dig,
            decode(l.vmd_id, -1, b.allow_date, '') as allov_date,
            decode(l.vmd_id, -1, to_char(b.kv_v,'999'), '') as kv_v,
            decode(l.vmd_id, -1, to_char(b.s_v,'fm999G999G999G990D00','nls_numeric_characters='', '''), '') as s_v,
            decode(l.vmd_id, -1, b.s_v, null) as s_v_dig,
            decode(l.vmd_id, -1, b.num) as vmd_num,
            decode(l.vmd_id, -1, b.f_date, '') as file_date, decode(l.vmd_id, -1, b.f_name, '') as file_name,
            decode(l.vmd_id, -1, -1, l.id) as str_level, nvl2(decode(l.vmd_id, -1, b.delete_date, l.delete_date), 1, 0),
            decode(l.vmd_id, -1, null, decode( nvl2(l.payment_id, br.comiss, bf.comiss), 0, null,
                     to_char(round(nvl2(l.payment_id, br.comiss*l.s/br.s_cv, bf.comiss*l.s/bf.s_cv)/100 ,2),
                        'fm999G999G999G990D00','nls_numeric_characters='', '''))) as comiss,
            l.create_date as link_date,
            null as zsq_vp, -- для експортних по платежам не відображається 
            decode(l.vmd_id, -1, gl.p_icurval(b.kv_v, round(b.s_v*(1-b.s/b.s_vk),2)/*z_vt*/ * 100, nvl(b.date_max_bound_doc,b.allow_date)) / 100, null) as zq_vt
       from (select b.bound_id, b.branch, b.journal_num, b.journal_id, b.create_date, b.modify_date, b.delete_date, b.contr_id,
                    decode(b.contr_id, 0, d.c_num, c.num) as contr_num, to_char(decode(b.contr_id, 0, d.c_date, c.open_date),'dd.mm.yy') as contr_date,
                    decode(b.contr_id, 0, d.rnk, c.rnk) as rnk, decode(b.contr_id, 0, d.benef_id, c.benef_id) as benef_id,
                    b.comments, b.direct, 0 as type_id, 'МД' as type_name, o.allow_dat as allow_date,
                    o.kv as kv_v, round(b.s_vt/100,2) as s_v, o.num, to_char(o.f_date, 'dd.mm.yy') as f_date, o.f_name,
                    round((select nvl(sum(s),0) from cim_link where delete_date is null and vmd_id=b.bound_id)/100,2) as s,
                    round(b.s_vk/100,2) as s_vk,
                    (select max(nvl2(l.payment_id,
                                  (select max(vdat) from oper where ref=(select max(ref)from cim_payments_bound where bound_id=l.payment_id)),
                                  (select max(val_date) from cim_fantom_payments where fantom_id=(select max(fantom_id) from cim_fantoms_bound where bound_id=l.fantom_id))))
                  from cim_link l where l.delete_date is null and l.vmd_id=b.bound_id) as date_max_bound_doc                   
               from cim_vmd_bound b
                    join cim_contracts c on c.contr_id=b.contr_id
                    left outer join cim_vmd_bound_data d on d.bound_id=b.bound_id
                    join v_cim_customs_decl o on o.cim_id=b.vmd_id
              where b.uid_del_journal is null and b.contr_id is not null
            union all
             select b.bound_id, b.branch, b.journal_num, b.journal_id, b.create_date, b.modify_date, b.delete_date, b.contr_id,
                    c.num, to_char(c.open_date,'dd.mm.yy'),
                    c.rnk, c.benef_id,
                    b.comments, b.direct, o.act_type, t.name as type_name, o.allow_date,
                    o.kv, round(b.s_vt/100,2), o.num, to_char(o.file_date, 'dd.mm.yy'), o.file_name,
                    round((select nvl(sum(s),0) from cim_link where delete_date is null and act_id=b.bound_id)/100,2) as s,
                    round(b.s_vk/100,2) as s_vk,
                    (select max(nvl2(l.payment_id,
                                 (select max(vdat) from oper where ref=(select max(ref)from cim_payments_bound where bound_id=l.payment_id)),
                                 (select max(val_date) from cim_fantom_payments where fantom_id=(select max(fantom_id) from cim_fantoms_bound where bound_id=l.fantom_id))))
                      from cim_link l where l.delete_date is null and l.act_id=b.bound_id
                   ) as date_max_bound_doc                    
               from cim_act_bound b
                    join cim_contracts c on c.contr_id=b.contr_id
                    join cim_acts o on o.act_id=b.act_id
                    join cim_act_types t on t.type_id=o.act_type
              where b.uid_del_journal is null and b.contr_id is not null
            ) b -- вибираєм первинні стрічки (МД/Акти)
            join customer a on a.rnk=b.rnk
            join cim_beneficiaries n on n.benef_id=b.benef_id
            join country cu on cu.country=n.country_id
            join (select payment_id, fantom_id, vmd_id, act_id, s, delete_date, uid_del_journal, id, comments, create_date
                    from cim_link union all select null, null, -1, null, null, null, null, null, null, null from dual) l
              on l.uid_del_journal is null and decode(b.type_id,0,l.vmd_id,l.act_id)=b.bound_id or l.vmd_id=-1
            left outer join cim_payments_bound br on br.bound_id=l.payment_id and l.payment_id is not null
            left outer join v_cim_oper bro on  bro.ref=br.ref and l.payment_id is not null
            left outer join cim_fantoms_bound bf on bf.bound_id=l.fantom_id and l.fantom_id is not null
            left outer join cim_fantom_payments bfo on  bfo.fantom_id=bf.fantom_id and l.fantom_id is not null
            join branch bra on bra.branch=b.branch
  )
  order by journal_num, branch, num, bound_id, okpo, val_date, allow_date
;

comment on table V_CIM_JOURNAL is 'ЖУРНАЛ v 1.00.02';
comment on column V_CIM_JOURNAL.BRANCH is 'Код установи';
comment on column V_CIM_JOURNAL.BRANCH_NAME is 'Назва установи';
comment on column V_CIM_JOURNAL.JOURNAL_NUM is 'Номер журналу';
comment on column V_CIM_JOURNAL.NUM is 'Номер запису';
comment on column V_CIM_JOURNAL.NUM_TXT is 'Номер запису (текст)';
comment on column V_CIM_JOURNAL.CREATE_DATE is 'Дата реєстрації';
comment on column V_CIM_JOURNAL.MODIFY_DATE is 'Дата модифікації';
comment on column V_CIM_JOURNAL.DELETE_DATE is 'Дата видалення';
comment on column V_CIM_JOURNAL.CONTR_ID is 'Id контракту';
comment on column V_CIM_JOURNAL.CONTR_NUM is 'Номер контракту';
comment on column V_CIM_JOURNAL.CONTR_DATE is 'Дата контракту';
comment on column V_CIM_JOURNAL.RNK is 'РНК клієнта (резидента)';
comment on column V_CIM_JOURNAL.OKPO is 'ОКПО клієнта';
comment on column V_CIM_JOURNAL.NMK is 'Назва клієнта';
comment on column V_CIM_JOURNAL.BENEF_ID is 'id нерезидента';
comment on column V_CIM_JOURNAL.BENEF_NAME is 'Назва нерезидента';
comment on column V_CIM_JOURNAL.COUNTRY_ID is 'id країни';
comment on column V_CIM_JOURNAL.COUNTRY_NAME is 'Назва країни';
comment on column V_CIM_JOURNAL.CONTROL_DATE is 'Контрольний строк';
comment on column V_CIM_JOURNAL.CONCLUSION is 'Висновки';
comment on column V_CIM_JOURNAL.COMMENTS is 'Примітка';
comment on column V_CIM_JOURNAL.DIRECT is 'Напрям';
comment on column V_CIM_JOURNAL.DOC_KIND is '0 - платіж, 1 - ВМД';
comment on column V_CIM_JOURNAL.DOC_TYPE is 'id типу';
comment on column V_CIM_JOURNAL.DOC_TYPE_NAME is 'Назва типу';
comment on column V_CIM_JOURNAL.BOUND_ID is 'Id прив''язки (первинної стрічки)';
comment on column V_CIM_JOURNAL.DOC_ID is 'Id документа (вторинної стрічки)';
comment on column V_CIM_JOURNAL.VAL_DATE is 'Дата валютування';
comment on column V_CIM_JOURNAL.KV_P is 'Код валюти платежу';
comment on column V_CIM_JOURNAL.S_P is 'Сума платежу у валюті';
comment on column V_CIM_JOURNAL.ALLOW_DATE is 'Дата дозволу';
comment on column V_CIM_JOURNAL.KV_V is 'Код валюти ВМД';
comment on column V_CIM_JOURNAL.S_V is 'Сума  ВМД у валюті ';
comment on column V_CIM_JOURNAL.VMD_NUM is 'Номер ВМД';
comment on column V_CIM_JOURNAL.FILE_DATE is 'Дата файлу реєстру';
comment on column V_CIM_JOURNAL.FILE_NAME is 'Ім`я файлу (номер) реєстру';
comment on column V_CIM_JOURNAL.STR_LEVEL is 'Рівень (-1 - вторинна, інакше -первинна)';
comment on column V_CIM_JOURNAL.DEL_JOURNAL is 'Можливість видалення з журналу';
comment on column V_CIM_JOURNAL.COMISS is 'Сума комісії';
comment on column V_CIM_JOURNAL.LINK_DATE is 'Дата прив`язки';
comment on column V_CIM_JOURNAL.ZSQ_VP is 'Грн.екв.останньої події незавершеного розрахунку';
comment on column V_CIM_JOURNAL.ZQ_VT is 'Грн.екв.останньої події незавершеного розрахунку';

PROMPT *** Create  grants  V_CIM_JOURNAL ***
grant SELECT                                                                 on V_CIM_JOURNAL   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_JOURNAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_JOURNAL   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_JOURNAL.sql =========*** End *** 
PROMPT ===================================================================================== 
