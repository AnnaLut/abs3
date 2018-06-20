PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_ADL_DOC_RPT_DTL.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view V_NBUR_DM_ADL_DOC_RPT_DTL ***

create or replace view V_NBUR_DM_ADL_DOC_RPT_DTL 
as
  select /*+ PARALLEL( 16 ) */
         dtl.REPORT_DATE, dtl.KF, dtl.REF
         , D1#70, D2#70, D3#70, D4#70, D5#70, D6#70, D7#70, D8#70, D9#70
         , DA#70, DB#70, DD#70, D1#E2, D6#E2, D7#E2, D8#E2, D1#E9, D1#C9, D6#C9
         , DE#C9, D1#D3, D1#F1, D1#27, D1#39, D1#44, D1#73, D2#73
         , D020,  BM__C, KURS,  D1#2D, KOD_B, KOD_G, KOD_N, TRF_R, TRF_D
         , DOC_T, DOC_A, DOC_S, DOC_N, DOC_D, REZID, NATIO, OKPO,  POKPO, OOKPO
  from   NBUR_DM_ADL_DOC_RPT_DTL_ARCH dtl
  where ( dtl.REPORT_DATE, dtl.KF, dtl.VERSION_ID ) in ( 
                                                          select REPORT_DATE, KF, max(VERSION_ID)
                                                          from   NBUR_LST_OBJECTS
                                                          where  OBJECT_ID in (
                                                                                    select id
                                                                                    from   nbur_ref_objects 
                                                                                    where  object_name = 'NBUR_DM_ADL_DOC_RPT_DTL'
                                                                                  )
                                                                 and VLD = 0
                                                               group by REPORT_DATE, KF 
                                                     );

comment on table V_NBUR_DM_ADL_DOC_RPT_DTL is 'Додаткові звітні параметри документів';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.report_date is 'Звітна дата';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.kf is 'Код філіалу (МФО)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.ref is 'ідентифікатор документа';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d2#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d3#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d4#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d5#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d6#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d7#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d8#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d9#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.da#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.db#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.dd#70 is 'Дод. параметр для файлу #70';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#e2 is 'Дод. параметр для файлу #E2';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d6#e2 is 'Дод. параметр для файлу #E2';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d7#e2 is 'Дод. параметр для файлу #E2';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d8#e2 is 'Дод. параметр для файлу #E2';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#c9 is 'Дод. параметр для файлу #C9';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d6#c9 is 'Дод. параметр для файлу #C9';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.de#c9 is 'Дод. параметр для файлу #C9';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#d3 is 'Дод. параметр для файлу #D3';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#27 is 'Дод. параметр D#27 (показник для файлу #27)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#39 is 'Дод. параметр D#39 (показник для файлу #39)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#44 is 'Дод. параметр D#44 (показник для файлу #44)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#73 is 'Дод. параметр D#73 (показник для файлу #73)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d2#73 is 'Дод. параметр 73%  (показник для файлу #73)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d020 is 'Параметр розподілу суми оборотів';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.bm__c is 'Дод. параметр (по банківських металах)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.kurs is 'Курс купівлі-продажу валюти';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#2d is 'Код мети переказу для (#2D)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.kod_b is 'Код БАНКУ (1-ПБ)                                 [BOPBANK.REGNUM]';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.kod_g is 'Код країни Платника/Отримувача (TAG="KOD_G","n") [BOPCOUNT.KODC]';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.kod_n is 'Код призначення платежу (1-ПБ) (TAG="KOD_N","N") [BOPCODE.TRANSCODE]';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#e9 is 'Код країни отримувача/відправника (KL_K040.K040)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.d1#f1 is 'Дод. параметр (показник для файлу #F1)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.trf_r is 'Референс документу відправки переказу';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.trf_d is 'Дата документу відправки переказу';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.doc_t is 'Тип документу';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.doc_a is 'Орган, який видав документ (issuing authority)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.doc_s is 'Серiя документу';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.doc_n is 'Номер документу';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.doc_d is 'Дата видачі документу';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.rezid is 'резидент/нерезидент (K030)';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.natio is 'Громадянство';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.okpo is 'Ідентифікаційний код';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.pokpo is 'Код платника';
comment on column V_NBUR_DM_ADL_DOC_RPT_DTL.ookpo is 'Код отримувача';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_ADL_DOC_RPT_DTL.sql =========*** End *** =
PROMPT ===================================================================================== 