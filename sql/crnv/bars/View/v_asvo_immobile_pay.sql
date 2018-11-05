

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ASVO_IMMOBILE_PAY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ASVO_IMMOBILE_PAY ***

CREATE OR REPLACE VIEW V_ASVO_IMMOBILE_PAY AS
SELECT a."TVBV",
            a."KEY",
            a."FIO",
            a."IDCODE",
            a."DOCTYPE",
            a."PASP_S",
            a."PASP_N",
            a."PASP_W",
            a."PASP_D",
            a."BIRTHDAT",
            a."BIRTHPL",
            a."SEX",
            a."POSTIDX",
            a."REGION",
            a."DISTRICT",
            a."CITY",
            a."ADDRESS",
            a."PHONE_H",
            a."PHONE_J",
            a."LANDCOD",
            a."REGDATE",
            a."DEPCODE",
            a."DEPVIDNAME",
            a."ACC_CARD",
            a."DEPNAME",
            a."NLS",
            a."ID",
            a."DATO",
            a."OST",
            a."SUM",
            a."DATN",
            a."ATTR",
            a."MARK",
            a."VER",
            a."KOD_OTD",
            a."BRANCH",
            a."BSD",
            a."OB22DE",
            a."BSN",
            a."OB22IE",
            a."BSD7",
            a."OB22D7",
            a."FL",
            a."DZAGR",
            a."REF",
            a."REFOUT",
            a."REFPAY",
            a."SOURCE",
            a."KV",
            a."ND",
            a."DPTID",
            a."ERRMSG",
            a."COMMENTS",
            a."BATCH_ID",
            f.status,
            decode((select count(*) from asvo_immobile_history where key = a.key),0,'ЭГ','връ') edit,
            to_char(a.dzagr,'dd.mm.yyyy') date_come ,
            (select to_char(max(o.sos_change_time), 'dd.mm.yyyy') date_last
              from oper o, operw op
             where o.ref = op.ref
               and op.tag = 'REF92'
               and op.value = cast(a.key as varchar2(255))) date_last
       FROM asvo_immobile a, asvo_immobile_fl f
      WHERE     a.fl = f.fl
            AND '/' || f_ourmfo || a.branch LIKE
                      SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'),
                              1,
                              15)
                   || '%';

PROMPT *** Create  grants  V_ASVO_IMMOBILE_PAY ***
grant SELECT                                                                 on V_ASVO_IMMOBILE_PAY        to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ASVO_IMMOBILE_PAY.sql =========*** End *** =====
PROMPT ===================================================================================== 
