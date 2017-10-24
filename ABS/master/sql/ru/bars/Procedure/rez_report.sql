

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_REPORT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_REPORT ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_REPORT (sFdat varchar2, p_user_id number default null) IS
tmpVar NUMBER;

BEGIN
rez.p_unload_data;
delete from REZERV_REPORT;


insert into REZERV_REPORT
(BRANCH   ,  BR_NAME ,
  S1,  S2,  S3,  S4,  S5,  S6,  S7,  S8,  S9,  S10,  S11,  S12,  S13,  S14,  S15,  S16,  S17,  S18,  S19,  S20,
  S21,  S22,  S23,  S24,  S25,  S26,  S27,  S28,  S29,  S30,  S31,  S32,  S33,  S34,  S35,  S36,  S37,  S38,  S39,
  S40,  S41,  S42,  S43,  S44,  S45,  S46,  S47,  S48,  S49,  S50,  S51,  S52, s54,s55)
select s1.branch "¬≥дд≥ленн€",
       nvl(s1.br_name,'¬—№ќ√ќ') "Ќазва",

       sum(s1.f_1_980 - s2.f_1_980) "в_ф_станд_грн",
       sum(s2.f_1_980_m) "пр_ф_станд_грн",
       sum(s1.f_1_980_9 - s2.f_1_980_9) "в_ф_станд_грн_зоб",
       sum(s2.f_1_980_9_m) "пр_ф_станд_грн_зоб",
       sum(s1.f_1_840 - s2.f_1_840) "в_ф_станд_дол",
       sum(s2.f_1_840_m) "пр_ф_станд_дол",
       sum(s1.f_1_840_9 - s2.f_1_840_9) "в_ф_станд_дол_зоб",
       sum(s2.f_1_840_9_m) "пр_ф_станд_дол_зоб",
       sum(s1.f_1_978 - s2.f_1_978) "в_ф_станд_Ївр",
       sum(s2.f_1_978_m) "пр_ф_станд_Ївр",
       sum(s1.f_1_978_9 - s2.f_1_978_9) "в_ф_станд_Ївр_зоб",
       sum(s2.f_1_978_9_m) "пр_ф_станд_Ївр_зоб",


       sum(s1.f_2_980 - s2.f_2_980) "в_ф_нест_грн",
       sum(s2.f_2_980_m) "пр_ф_нест_грн",
       sum(s1.f_2_980_i - s2.f_2_980_i) "в_ф_нест_грн",
       sum(s2.f_2_980_m_i) "пр_ф_нест_грн",
       sum(s1.f_2_980_9 - s2.f_2_980_9) "в_ф_нест_грн_зоб",
       sum(s2.f_2_980_9_m) "пр_ф_нест_грн_зоб",
       sum(s1.f_2_840 - s2.f_2_840) "в_ф_нест_дол",
       sum(s2.f_2_840_m ) "пр_ф_нест_дол",
       sum(s1.f_2_840_i - s2.f_2_840_i) "в_ф_нест_дол",
       sum(s2.f_2_840_m_i ) "пр_ф_нест_дол",
       sum(s1.f_2_840_9 - s2.f_2_840_9) "в_ф_нест_дол_зоб",
       sum(s2.f_2_840_9_m) "пр_ф_нест_дол_зоб",
       sum(s1.f_2_978 - s2.f_2_978) "в_ф_нест_Ївр",
       sum(s2.f_2_978_m) "пр_ф_нест_Ївр",
       sum(s1.f_2_978_i - s2.f_2_978_i) "в_ф_нест_Ївр",
       sum(s2.f_2_978_m_i) "пр_ф_нест_Ївр",
       sum(s1.f_2_978_9 - s2.f_2_978_9) "в_ф_нест_Ївр_зоб",
       sum(s2.f_2_978_9_m) "пр_ф_нест_Ївр_зоб",


       sum(s1.j_1_980 - s2.j_1_980 ) "в_ю_станд_грн",
       sum(s2.j_1_980_m) "пр_ю_станд_грн",
       sum(s1.j_1_980_9 - s2.j_1_980_9) "в_ю_станд_грн_зоб",
       sum(s2.j_1_980_9_m) "пр_ю_станд_грн_зоб",
       sum(s1.j_1_840 - s2.j_1_840) "в_ю_станд_дол",
       sum(s2.j_1_840_m) "пр_ю_станд_дол",
       sum(s1.j_1_840_9 - s2.j_1_840_9) "в_ю_станд_дол_зоб",
       sum(s2.j_1_840_9_m) "пр_ю_станд_дол_зоб",
       sum(s1.j_1_978 - s2.j_1_978) "в_ю_станд_Ївр",
       sum(s2.j_1_978_m) "пр_ю_станд_Ївр",
       sum(s1.j_1_978_9 - s2.j_1_978_9) "в_ю_станд_Ївр_зоб",
       sum(s2.j_1_978_9_m) "пр_ю_станд_Ївр_зоб",


       sum(s1.j_2_980 - s2.j_2_980) "в_ю_нест_грн",
       sum(s2.j_2_980_m) "пр_ю_нест_грн",
       sum(s1.j_2_980_9 - s2.j_2_980_9) "в_ю_нест_грн_зоб",
       sum(s2.j_2_980_9_m) "пр_ю_нест_грн_зоб",
       sum(s1.j_2_840 - s2.j_2_840) "в_ю_нест_дол",
       sum(s2.j_2_840_m) "пр_ю_нест_дол",
       sum(s1.j_2_840_9 - s2.j_2_840_9) "в_ю_нест_дол_зоб",
       sum(s2.j_2_840_9_m) "пр_ю_нест_дол_зоб",
       sum(s1.j_2_978 - s2.j_2_978) "в_ю_нест_Ївр",
       sum(s2.j_2_978_m) "пр_ю_нест_Ївр",
       sum(s1.j_2_978_9 - s2.j_2_978_9) "в_ю_нест_Ївр_зоб",
       sum(s2.j_2_978_9_m) "пр_ю_нест_Ївр_зоб"

from(
select
           b.branch,
           b.name br_name,
           sum(decode(custtype||nbs||t.s080||t.kv,'311980',t.sm,0)) f_1_980,
           sum(decode(custtype||nbs||t.s080||t.kv,'391980',t.sm,0)) f_1_980_9,
           sum(decode(custtype||nbs||t.s080||t.kv,'311840',t.sm,0)) f_1_840,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'311840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_1_840_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'391840',t.sm,0)) f_1_840_9,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'391840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_1_840_eqv9,
           sum(decode(custtype||nbs||t.s080||t.kv,'311978',t.sm,0)) f_1_978,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'311978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_1_978_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'391978',t.sm,0)) f_1_978_9,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'391978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_1_978_eqv9,

           sum(decode(custtype||nbs||t.s080||t.kv||t.ip,'3129800',t.sm,0)) f_2_980,
           sum(decode(custtype||nbs||t.s080||t.kv,'392980',t.sm,0)) f_2_980_9,
           sum(decode(custtype||nbs||t.s080||t.kv||t.ip,'3128400',t.sm,0)) f_2_840,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'312840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_2_840_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'392840',t.sm,0)) f_2_840_9,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'392840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_2_840_eqv9,
           sum(decode(custtype||nbs||t.s080||t.kv||t.ip,'3129780',t.sm,0)) f_2_978,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'312978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_2_978_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'392978',t.sm,0)) f_2_978_9,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'392978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) f_2_978_eqv9,

           sum(decode(custtype||nbs||t.s080||t.kv||t.ip,'3129801',t.sm,0)) f_2_980_i,
           sum(decode(custtype||nbs||t.s080||t.kv||t.ip,'3128401',t.sm,0)) f_2_840_i,
           sum(decode(custtype||nbs||t.s080||t.kv||t.ip,'3129781',t.sm,0)) f_2_978_i,

           sum(decode(custtype||nbs||t.s080||t.kv,'211980',t.sm,0)) j_1_980,
           sum(decode(custtype||nbs||t.s080||t.kv,'291980',t.sm,0)) j_1_980_9,
           sum(decode(custtype||nbs||t.s080||t.kv,'211840',t.sm,0)) j_1_840,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'211840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_1_840_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'291840',t.sm,0)) j_1_840_9,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'291840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_1_840_eqv9,
           sum(decode(custtype||nbs||t.s080||t.kv,'211978',t.sm,0)) j_1_978,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'211978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_1_978_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'291978',t.sm,0)) j_1_978_9,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'291978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_1_978_eqv9,

           sum(decode(custtype||nbs||t.s080||t.kv,'212980',t.sm,0)) j_2_980,
           sum(decode(custtype||nbs||t.s080||t.kv,'292980',t.sm,0)) j_2_980_9,
           sum(decode(custtype||nbs||t.s080||t.kv,'212840',t.sm,0)) j_2_840,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'212840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_2_840_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'292840',t.sm,0)) j_2_840_9,
           gl.p_icurval ('840', sum(decode(custtype||nbs||t.s080||t.kv,'292840',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_2_840_eqv9,
           sum(decode(custtype||nbs||t.s080||t.kv,'212978',t.sm,0)) j_2_978,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'212978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_2_978_eqv,
           sum(decode(custtype||nbs||t.s080||t.kv,'292978',t.sm,0)) j_2_978_9,
           gl.p_icurval ('978', sum(decode(custtype||nbs||t.s080||t.kv,'292978',t.sm,0)), to_date(sFdat,'dd.mm.yyyy')) j_2_978_eqv9
           ,sum(t.sm) sm_all
    from
    (
        select r.tobo branch,  decode(r.s080,1,1,2) s080, r.kv, NVL(SUM(NVL(r.sz1, r.sz)), 0)/100 sm
               ,decode(substr(r.nls,1,1),9,9,1) nbs, custtype
               ,decode(decode(s080,1,1,2)||r.kv,'2980', decode(substr(r.nls,1,4),'2233',1,'2237',1,0),0) ip
        from tmp_rez_risk r
        where dat = to_date(sFdat,'dd.mm.yyyy') and  id = nvl(p_user_id,user_id)
              and r.CUSTTYPE in (2,3) and r.s080 <> 9
        group by r.tobo , r.s080, r.kv,decode(substr(r.nls,1,1),9,9,1),custtype,decode(decode(s080,1,1,2)||r.kv,'2980', decode(substr(r.nls,1,4),'2233',1,'2237',1,0),0)
    ) t,
    branch b
    where rtrim(substr(replace(t.branch||'/','//','/000000/'),1,instr(replace(t.branch||'/','//','/000000/'),'/',1,3)-1),'/')||'/' = b.branch
    group by -- t.branch,
           b.branch ,
           b.name
) s1,
(select a.branch, b.name br_name,
       sum(decode(a.kv||a.nbs||s.ob22,'980240101',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_1_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_1_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240101',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_1_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_1_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240101',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_1_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_1_978_9,

       sum(decode(a.kv||a.nbs||s.ob22,'980240003',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,'980240006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240003',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,'840240006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240003',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,'978240006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_978_9,

       sum(decode(a.kv||a.nbs||s.ob22,'980240009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,
                                      '980240010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_980_i,
       sum(decode(a.kv||a.nbs||s.ob22,'840240009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,
                                      '840240010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_840_i,
       sum(decode(a.kv||a.nbs||s.ob22,'978240009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,
                                      '978240010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) f_2_978_i,

       sum(decode(a.kv||a.nbs||s.ob22,'980240102',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_1_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_1_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240102',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_1_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_1_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240102',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_1_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_1_978_9,

       sum(decode(a.kv||a.nbs||s.ob22,'980240004',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,'980240007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_2_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_2_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240004',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,'840240007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_2_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_2_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240004',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,'978240007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_2_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy'))/100,0)) j_2_978_9

       ,
       sum(decode(a.kv||a.nbs||s.ob22,'980240101',m.sm,0)) f_1_980_m,
       sum(decode(a.kv||a.nbs||s.ob22,'980369009',m.sm,0)) f_1_980_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840240101',m.sm,0)) f_1_840_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840369009',m.sm,0)) f_1_840_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978240101',m.sm,0)) f_1_978_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978369009',m.sm,0)) f_1_978_9_m,

       sum(decode(a.kv||a.nbs||s.ob22,'980240003',m.sm,'980240006',m.sm,0)) f_2_980_m,
       sum(decode(a.kv||a.nbs||s.ob22,'980369006',m.sm,0)) f_2_980_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840240003',m.sm,'840240006',m.sm,0)) f_2_840_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840369006',m.sm,0)) f_2_840_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978240003',m.sm,'978240006',m.sm,0)) f_2_978_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978369006',m.sm,0)) f_2_978_9_m,

       sum(decode(a.kv||a.nbs||s.ob22,'980240009',m.sm,'980240010',m.sm,0)) f_2_980_m_i,
       sum(decode(a.kv||a.nbs||s.ob22,'840240009',m.sm,'840240010',m.sm,0)) f_2_840_m_i,
       sum(decode(a.kv||a.nbs||s.ob22,'978240009',m.sm,'978240010',m.sm,0)) f_2_978_m_i,

       sum(decode(a.kv||a.nbs||s.ob22,'980240102',m.sm,0)) j_1_980_m,
       sum(decode(a.kv||a.nbs||s.ob22,'980369010',m.sm,0)) j_1_980_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840240102',m.sm,0)) j_1_840_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840369010',m.sm,0)) j_1_840_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978240102',m.sm,0)) j_1_978_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978369010',m.sm,0)) j_1_978_9_m,

       sum(decode(a.kv||a.nbs||s.ob22,'980240004',m.sm,'980240007',m.sm,0)) j_2_980_m,
       sum(decode(a.kv||a.nbs||s.ob22,'980369007',m.sm,0)) j_2_980_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840240004',m.sm,'840240007',m.sm,0)) j_2_840_m,
       sum(decode(a.kv||a.nbs||s.ob22,'840369007',m.sm,0)) j_2_840_9_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978240004',m.sm,'978240007',m.sm,0)) j_2_978_m,
       sum(decode(a.kv||a.nbs||s.ob22,'978369007',m.sm,0)) j_2_978_9_m


from accounts a
     join specparam_int s on a.acc = s.acc
     left join branch b on a.branch = b.branch
     left join
     ( select sum(decode(d.dk,0,(-1)*d.s/100,1, d.s/100, (-1)*d.s/100)) sm, d.nlsa, d.kv
       from rez_doc_maket d
       where  d.dk <> -1 and d.USERID = user_id
       group by  d.nlsa, d.kv
     )m    on a.nls = m.nlsa and a.kv = m.kv
where a.nbs in ('2400','2401','3690')
      and nvl(a.dazs, to_date('01014999','ddmmyyyy')) > to_date(sFdat,'dd.mm.yyyy')
group by a.branch, b.name
) s2
where s1.branch = s2.branch
group by grouping sets
((s1.branch, s1.br_name),
 ()
)
order by s1.branch
;

commit;
rez.p_unload_data;

END rez_report;
/
show err;

PROMPT *** Create  grants  REZ_REPORT ***
grant EXECUTE                                                                on REZ_REPORT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_REPORT      to RCC_DEAL;
grant EXECUTE                                                                on REZ_REPORT      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_REPORT.sql =========*** End **
PROMPT ===================================================================================== 
