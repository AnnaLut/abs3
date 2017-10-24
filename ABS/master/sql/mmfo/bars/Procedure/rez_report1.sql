

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_REPORT1.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_REPORT1 ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_REPORT1 (sFdat varchar2, p_user_id number default null) IS
tmpVar NUMBER;

BEGIN
delete from REZERV_REPORT;

rez.p_unload_data;
insert into REZERV_REPORT
(BRANCH   ,  BR_NAME ,
  S1,  S2,  S3,  S4,  S5,  S6,  S7,  S8,  S9,  S10,  S11,  S12,  S13,  S14,  S15,  S16,  S17,  S18,  S19,  S20,
  S21,  S22,  S23,  S24,  S25,  S26,  S27,  S28,  S29,  S30,  S31,  S32,  S33,  S34,  S35,  S36,  S37,  S38,  S39,
  S40,  S41,  S42,  S43,  S44,  S45,  S46,  S47,  S48,  S49,  S50,  S51,  S52, s54, s55)
/*select s1.branch "¬≥дд≥ленн€",
       substr(s1.br_name,4) "Ќазва",
       sum(s1.f_1_980) "p_ф_станд_грн",
       sum(s1.f_1_980_9) "P_ф_станд_грн_зоб",
       sum(s1.f_1_840) "p_ф_станд_дол",
       sum(s1.f_1_840_9) "p_ф_станд_дол_зоб",
       sum(s1.f_1_978) "p_ф_станд_Ївр",
       sum(s1.f_1_978_9) "p_ф_станд_Ївр_зоб",
       sum(s1.f_2_980) "p_ф_нест_грн",
       sum(s1.f_2_980_i) "p_ф_нест_грн_ипот",
       sum(s1.f_2_980_9) "p_ф_нест_грн_зоб",
       sum(s1.f_2_840) "p_ф_нест_дол",
       sum(s1.f_2_840_9) "p_ф_нест_дол_зоб",
       sum(s1.f_2_978) "p_ф_нест_Ївр",
       sum(s1.f_2_978_9) "p_ф_нест_Ївр_зоб",


       sum(s1.j_1_980) "p_ю_станд_грн",
       sum(s1.j_1_980_9) "p_ю_станд_грн_зоб",
       sum(s1.j_1_840) "p_ю_станд_дол",
       sum(s1.j_1_840_9) "p_ю_станд_дол_зоб",
       sum(s1.j_1_978) "p_ю_станд_Ївр",
       sum(s1.j_1_978_9) "p_ю_станд_Ївр_зоб",
       sum(s1.j_2_980) "p_ю_нест_грн",
       sum(s1.j_2_980_9) "p_ю_нест_грн_зоб",
       sum(s1.j_2_840) "p_ю_нест_дол",
       sum(s1.j_2_840_9) "p_ю_нест_дол_зоб",
       sum(s1.j_2_978) "p_ю_нест_Ївр",
       sum(s1.j_2_978_9) "p_ю_нест_Ївр_зоб",


       sum(s2.f_1_980) "ф_ф_станд_грн",
       sum(s2.f_1_980_9) "ф_ф_станд_грн_зоб",
       sum(s2.f_1_840) "ф_ф_станд_дол",
       sum(s2.f_1_840_9) "ф_ф_станд_дол_зоб",
       sum(s2.f_1_978) "ф_ф_станд_Ївр",
       sum(s2.f_1_978_9) "ф_ф_станд_Ївр_зоб",
       sum(s2.f_2_980) "ф_ф_нест_грн",
       sum(s2.f_2_980_i) "ф_ф_нест_грн_ипот",
       sum(s2.f_2_980_9) "ф_ф_нест_грн_зоб",
       sum(s2.f_2_840) "ф_ф_нест_дол",
       sum(s2.f_2_840_9) "ф_ф_нест_дол_зоб",
       sum(s2.f_2_978) "ф_ф_нест_Ївр",
       sum(s2.f_2_978_9) "ф_ф_нест_Ївр_зоб",

       sum(s2.j_1_980) "ф_ю_станд_грн",
       sum(s2.j_1_980_9) "ф_ю_станд_грн_зоб",
       sum(s2.j_1_840) "ф_ю_станд_дол",
       sum(s2.j_1_840_9) "ф_ю_станд_дол_зоб",
       sum(s2.j_1_978) "ф_ю_станд_Ївр",
       sum(s2.j_1_978_9) "ф_ю_станд_Ївр_зоб",
       sum(s2.j_2_980) "ф_ю_нест_грн",
       sum(s2.j_2_980_9) "ф_ю_нест_грн_зоб",
       sum(s2.j_2_840) "ф_ю_нест_дол",
       sum(s2.j_2_840_9) "ф_ю_нест_дол_зоб",
       sum(s2.j_2_978) "ф_ю_нест_Ївр",
       sum(s2.j_2_978_9) "ф_ю_нест_Ївр_зоб",

       sum( (s1.f_1_980) + (s1.f_1_980_9) +(s1.f_1_840_eqv) +(s1.f_1_840_eqv9) + (s1.f_1_978_eqv) + (s1.f_1_978_eqv9) + (s1.f_2_980) +
            (s1.f_2_980_i) +(s1.f_2_980_9) + (s1.f_2_840_eqv) +(s1.f_2_840_eqv9) +(s1.f_2_978_eqv) + (s1.f_2_978_eqv9)
       ) "p_¬—№ќ√ќ_физ_ос",

       sum(s1.j_1_980+s1.j_1_980_9+s1.j_1_840_eqv+s1.j_1_840_eqv9+s1.j_1_978_eqv+s1.j_1_978_eqv9+
           s1.j_2_980+s1.j_2_980_9+s1.j_2_840_eqv+s1.j_2_840_eqv9+s1.j_2_978_eqv+s1.j_2_978_eqv9
       ) "p_¬—№ќ√ќ_юр_ос",

        sum(s2.f_1_980+s2.f_1_980_9+ gl.p_icurval ('840', s2.f_1_840, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('840', s2.f_1_840_9, to_date(sFdat,'dd.mm.yyyy')) + gl.p_icurval ('978', s2.f_1_978, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('978', s2.f_1_978_9, to_date(sFdat,'dd.mm.yyyy')) +s2.f_2_980+s2.f_2_980_9 +gl.p_icurval ('840', s2.f_2_840, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('840', s2.f_2_840_9, to_date(sFdat,'dd.mm.yyyy')) + gl.p_icurval ('978', s2.f_2_978, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('978', s2.f_2_978_9, to_date(sFdat,'dd.mm.yyyy')+s1.f_2_980_i)

       ) "ф_¬—№ќ√ќ_физ_ос",

       sum(s2.j_1_980+s2.j_1_980_9+ gl.p_icurval ('840', s2.j_1_840, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('840', s2.j_1_840_9, to_date(sFdat,'dd.mm.yyyy')) + gl.p_icurval ('978', s2.j_1_978, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('978', s2.j_1_978_9, to_date(sFdat,'dd.mm.yyyy')) +s2.j_2_980+s2.j_2_980_9 +
             gl.p_icurval ('840', s2.j_2_840, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('840', s2.j_2_840_9, to_date(sFdat,'dd.mm.yyyy')) + gl.p_icurval ('978', s2.j_2_978, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('978', s2.j_2_978_9, to_date(sFdat,'dd.mm.yyyy'))

       ) "ф_¬—№ќ√ќ_юр_ос"*/
select s1.branch "¬≥дд≥ленн€",
       substr(s1.br_name,4) "Ќазва",
        (s1.f_1_980)/100 "p_ф_станд_грн",
       (s1.f_1_980_9)/100 "P_ф_станд_грн_зоб",
       (s1.f_1_840)/100 "p_ф_станд_дол",
       (s1.f_1_840_9)/100 "p_ф_станд_дол_зоб",
       (s1.f_1_978)/100 "p_ф_станд_Ївр",
       (s1.f_1_978_9)/100 "p_ф_станд_Ївр_зоб",
       (s1.f_2_980)/100 "p_ф_нест_грн",
       (s1.f_2_980_i)/100 "p_ф_нест_грн_ипот",
       (s1.f_2_980_9)/100 "p_ф_нест_грн_зоб",
       (s1.f_2_840)/100 "p_ф_нест_дол",
       (s1.f_2_840_9)/100 "p_ф_нест_дол_зоб",
       (s1.f_2_978)/100 "p_ф_нест_Ївр",
       (s1.f_2_978_9)/100 "p_ф_нест_Ївр_зоб",


       (s1.j_1_980)/100 "p_ю_станд_грн",
       (s1.j_1_980_9)/100 "p_ю_станд_грн_зоб",
       (s1.j_1_840)/100 "p_ю_станд_дол",
       (s1.j_1_840_9)/100 "p_ю_станд_дол_зоб",
       (s1.j_1_978)/100 "p_ю_станд_Ївр",
       (s1.j_1_978_9)/100 "p_ю_станд_Ївр_зоб",
       (s1.j_2_980)/100 "p_ю_нест_грн",
       (s1.j_2_980_9)/100 "p_ю_нест_грн_зоб",
       (s1.j_2_840)/100 "p_ю_нест_дол",
       (s1.j_2_840_9)/100 "p_ю_нест_дол_зоб",
       (s1.j_2_978)/100 "p_ю_нест_Ївр",
       (s1.j_2_978_9)/100 "p_ю_нест_Ївр_зоб",


       (s2.f_1_980)/100 "ф_ф_станд_грн",
       (s2.f_1_980_9)/100 "ф_ф_станд_грн_зоб",
       (s2.f_1_840)/100 "ф_ф_станд_дол",
       (s2.f_1_840_9)/100 "ф_ф_станд_дол_зоб",
       (s2.f_1_978)/100 "ф_ф_станд_Ївр",
       (s2.f_1_978_9)/100 "ф_ф_станд_Ївр_зоб",
       (s2.f_2_980)/100 "ф_ф_нест_грн",
       (s2.f_2_980_i)/100 "ф_ф_нест_грн_ипот",
       (s2.f_2_980_9)/100 "ф_ф_нест_грн_зоб",
       (s2.f_2_840)/100 "ф_ф_нест_дол",
       (s2.f_2_840_9)/100 "ф_ф_нест_дол_зоб",
       (s2.f_2_978)/100 "ф_ф_нест_Ївр",
       (s2.f_2_978_9)/100 "ф_ф_нест_Ївр_зоб",

       (s2.j_1_980)/100 "ф_ю_станд_грн",
       (s2.j_1_980_9)/100 "ф_ю_станд_грн_зоб",
       (s2.j_1_840)/100 "ф_ю_станд_дол",
       (s2.j_1_840_9)/100 "ф_ю_станд_дол_зоб",
       (s2.j_1_978)/100 "ф_ю_станд_Ївр",
       (s2.j_1_978_9)/100 "ф_ю_станд_Ївр_зоб",
       (s2.j_2_980)/100 "ф_ю_нест_грн",
       (s2.j_2_980_9)/100 "ф_ю_нест_грн_зоб",
       (s2.j_2_840)/100 "ф_ю_нест_дол",
       (s2.j_2_840_9)/100 "ф_ю_нест_дол_зоб",
       (s2.j_2_978)/100 "ф_ю_нест_Ївр",
       (s2.j_2_978_9)/100 "ф_ю_нест_Ївр_зоб",

       ( (s1.f_1_980) + (s1.f_1_980_9) +(s1.f_1_840_eqv) +(s1.f_1_840_eqv9) + (s1.f_1_978_eqv) + (s1.f_1_978_eqv9) + (s1.f_2_980) +
            (s1.f_2_980_i) +(s1.f_2_980_9) + (s1.f_2_840_eqv) +(s1.f_2_840_eqv9) +(s1.f_2_978_eqv) + (s1.f_2_978_eqv9)
       )/100 "p_¬—№ќ√ќ_физ_ос",

       (s1.j_1_980+s1.j_1_980_9+s1.j_1_840_eqv+s1.j_1_840_eqv9+s1.j_1_978_eqv+s1.j_1_978_eqv9+
           s1.j_2_980+s1.j_2_980_9+s1.j_2_840_eqv+s1.j_2_840_eqv9+s1.j_2_978_eqv+s1.j_2_978_eqv9
       )/100 "p_¬—№ќ√ќ_юр_ос",

        (s2.f_1_980+s2.f_1_980_9+
          gl.p_icurval ('840', s2.f_1_840, to_date(sFdat,'dd.mm.yyyy')) +
          gl.p_icurval ('840', s2.f_1_840_9, to_date(sFdat,'dd.mm.yyyy')) +
          gl.p_icurval ('978', s2.f_1_978, to_date(sFdat,'dd.mm.yyyy')) +
          gl.p_icurval ('978', s2.f_1_978_9, to_date(sFdat,'dd.mm.yyyy')) +
          s2.f_2_980+s2.f_2_980_i+s2.f_2_980_9 +
          gl.p_icurval ('840', s2.f_2_840, to_date(sFdat,'dd.mm.yyyy')) +
          gl.p_icurval ('840', s2.f_2_840_9, to_date(sFdat,'dd.mm.yyyy')) +
          gl.p_icurval ('978', s2.f_2_978, to_date(sFdat,'dd.mm.yyyy')) +
          gl.p_icurval ('978', s2.f_2_978_9, to_date(sFdat,'dd.mm.yyyy'))

       )/100 "ф_¬—№ќ√ќ_физ_ос",

       (s2.j_1_980+s2.j_1_980_9+ gl.p_icurval ('840', s2.j_1_840, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('840', s2.j_1_840_9, to_date(sFdat,'dd.mm.yyyy')) + gl.p_icurval ('978', s2.j_1_978, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('978', s2.j_1_978_9, to_date(sFdat,'dd.mm.yyyy')) +s2.j_2_980+s2.j_2_980_9 +
             gl.p_icurval ('840', s2.j_2_840, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('840', s2.j_2_840_9, to_date(sFdat,'dd.mm.yyyy')) + gl.p_icurval ('978', s2.j_2_978, to_date(sFdat,'dd.mm.yyyy')) +
             gl.p_icurval ('978', s2.j_2_978_9, to_date(sFdat,'dd.mm.yyyy'))

       )/100 "ф_¬—№ќ√ќ_юр_ос"


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
        select r.tobo branch,  decode(r.s080,1,1,2) s080, r.kv, NVL(SUM(NVL(r.sz1, r.sz)), 0) sm
               ,decode(substr(r.nls,1,1),9,9,1) nbs, custtype
               ,decode(decode(s080,1,1,2)||r.kv,'2980', decode(substr(r.nls,1,4),'2233',1,'2237',1,0),0) ip
        from tmp_rez_risk r
        where dat = to_date(sFdat,'dd.mm.yyyy') and  id = nvl(p_user_id, user_id)
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
       sum(decode(a.kv||a.nbs||s.ob22,'980240101',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_1_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_1_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240101',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_1_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_1_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240101',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_1_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_1_978_9,

       sum(decode(a.kv||a.nbs||s.ob22,'980240003',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),'980240006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240003',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),'840240006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240003',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),'978240006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369006',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_978_9,

       sum(decode(a.kv||a.nbs||s.ob22,'980240009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),
                                      '980240010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_980_i,
       sum(decode(a.kv||a.nbs||s.ob22,'840240009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),
                                      '840240010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_840_i,
       sum(decode(a.kv||a.nbs||s.ob22,'978240009',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),
                                      '978240010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) f_2_978_i,

       sum(decode(a.kv||a.nbs||s.ob22,'980240102',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_1_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_1_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240102',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_1_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_1_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240102',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_1_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369010',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_1_978_9,

       sum(decode(a.kv||a.nbs||s.ob22,'980240004',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),'980240007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_2_980,
       sum(decode(a.kv||a.nbs||s.ob22,'980369007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_2_980_9,
       sum(decode(a.kv||a.nbs||s.ob22,'840240004',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),'840240007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_2_840,
       sum(decode(a.kv||a.nbs||s.ob22,'840369007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_2_840_9,
       sum(decode(a.kv||a.nbs||s.ob22,'978240004',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),'978240007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_2_978,
       sum(decode(a.kv||a.nbs||s.ob22,'978369007',rez.ostc96(a.acc, to_date(sFdat,'dd.mm.yyyy')),0)) j_2_978_9
from accounts a, specparam_int s, branch b
where a.nbs in ('2400','2401','3690')
      and nvl(a.dazs, to_date('01014999','ddmmyyyy')) > to_date(sFdat,'dd.mm.yyyy')
      and a.acc = s.acc
      and a.branch = b.branch(+)
group by a.branch, b.name
) s2
where s1.branch = s2.branch
--group by s1.branch, s1.br_name
order by s1.branch
;


commit;
rez.p_unload_data;

END rez_report1;
 
/
show err;

PROMPT *** Create  grants  REZ_REPORT1 ***
grant EXECUTE                                                                on REZ_REPORT1     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_REPORT1     to RCC_DEAL;
grant EXECUTE                                                                on REZ_REPORT1     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_REPORT1.sql =========*** End *
PROMPT ===================================================================================== 
