/* Formatted on 03/08/2018 14:36:28 (QP5 v5.267.14150.38573) */
PROMPT View V_CL_SWIFT_DOCUMENTS;
--
-- V_CL_SWIFT_DOCUMENTS  (View)
--

CREATE OR REPLACE FORCE VIEW BARS.V_CL_SWIFT_DOCUMENTS
(
   REF,
   DATE_START_SDO,
   TIME_START_SDO,
   USERNAME_START_SDO,
   FIRST_NAME_BANK_START_SDO,
   CODE_BANK_START_SDO,
   NAME_BANK_START_SDO,
   ND,
   DATD,
   KV,
   S,
   SUMPR,
   NLSA,
   NAM_A,
   ADR,
   PAYER_BANK_NAME,
   ADDRESS_PAYER_BANK,
   NAME_BANK_MEDIATOR,
   BIC_MEDIATOR,
   ADDRESS_BANK_MEDIATOR,
   ACC_BANK_BENEFICAR,
   NAME_BANK_BENEFICAR,
   BIC_BANK_BENEFICAR,
   ADDRESS_BANK_BENEFICAR,
   ACC_BENEFICAR,
   NAME_BENEFICAR,
   ADDRESS_BENEFICAR,
   REMIT_INFO,
   DETAIL_CHARGE,
   CODE_PAYER_BANK,
   OKPO_PAYER,
   CODE_OPER,
   CODE_COUNTRY,
   SIGNATURE1,
   SIGNATURE2,
   DATE_VAL_KONT,
   TIME_VAL_KONT,
   USERNAME_VAL_KONT,
   FIRST_NAME_BANK_VAL_KONT,
   CODE_BANK_VAL_KONT,
   NAME_BANK_VAL_KONT,
   DATE_COMPLETE,
   TIME_COMPLETE,
   USERNAME_COMPLETE,
   FIRST_NAME_BANK_COMPLETE,
   CODE_BANK_COMPLETE,
   NAME_BANK_COMPLETE
)
AS
   SELECT o.REF,
          (SELECT TO_CHAR (ov.dat, 'dd.mm.yyyy')
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 25)
             date_start_sdo,
          (SELECT TO_CHAR (ov.dat, 'hh24.mi.ss')
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 25)
             time_start_sdo,
          (SELECT ov.username
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 25)
             username_start_sdo,
          'AT "Ощадбанк"' first_name_bank_start_sdo,
          (SELECT ov.kf
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 25)
             code_bank_start_sdo,
          (SELECT br.name
             FROM bars.branch br
            WHERE br.branch =    '/'
                              || (SELECT ov.kf
                                    FROM oper_visa ov
                                   WHERE ov.REF = o.REF AND ov.groupid = 25)
                              || '/')
             name_bank_start_sdo,
          o.nd,
          bars.f_month_lit (o.datd) datd,
          o.kv,
          REPLACE (
             TRIM (
                TO_CHAR (
                   o.s / 100,
                   '99999999999999999999999999999999999999999999999999.99')),
             '.',
             ',')
             s,
          CASE
             WHEN o.kv = 978
             THEN
                REPLACE (
                   REPLACE (bars.f_sumpr (o.s, o.kv, 'M'), 'EUR', 'євро'),
                   'цнт',
                   'євроцентів')
             WHEN o.kv = 840
             THEN
                REPLACE (
                   REPLACE (bars.f_sumpr (o.s, o.kv, 'M'),
                            'USD',
                            'доларів США'),
                   'цнт',
                   'центів')
             WHEN o.kv = 643
             THEN
                REPLACE (
                   REPLACE (bars.f_sumpr (o.s, o.kv, 'M'),
                            'RUB',
                            'рублів'),
                   'коп',
                   'копійок')
          END
             sumpr,
          o.nlsa,
          (SELECT c.nmkk
             FROM bars.customer c, accounts a
            WHERE a.rnk = c.rnk AND a.nls = o.nlsa AND a.kv = o.kv)
             nam_a,
          (SELECT    ca.zip
                  || ', '
                  || (SELECT name
                        FROM country c
                       WHERE c.country = ca.country)
                  || ', '
                  ||ca.locality
                  || ', '
                  || ca.address
             FROM bars.customer_address ca, accounts a
            WHERE     a.rnk = ca.rnk
                  AND ca.type_id = 1
                  AND a.nls = o.nlsa
                  AND a.kv = o.kv)
             adr,
          (SELECT bb.nb
             FROM bars.banks$base bb
            WHERE bb.mfo = o.mfoa)
             payer_bank_name,
          (SELECT 'Україна, ' || bav.attribute_value
             FROM bars.branch_attribute_value bav
            WHERE     bav.attribute_code = 'ADDRESS'
                  AND bav.branch_code = '/' || o.kf || '/')
             address_payer_bank,
          (SELECT sb.name
             FROM bars.sw_banks sb
            WHERE sb.bic = (SELECT ow.VALUE
                              FROM bars.operw ow
                             WHERE ow.REF = o.REF AND ow.tag = '56A'))
             name_bank_mediator,
          (SELECT ow.VALUE
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '56A')
             bic_mediator,
          (SELECT sb.office || ', ' || sb.country
             FROM bars.sw_banks sb
            WHERE sb.bic = (SELECT ow.VALUE
                              FROM bars.operw ow
                             WHERE ow.REF = o.REF AND ow.tag = '56A'))
             address_bank_mediator,
          (SELECT CASE SUBSTR (ow.VALUE, 1, 1)
                     WHEN '/'
                     THEN
                        SUBSTR (ow.VALUE, 2, INSTR (ow.VALUE, CHR (10)) - 1)
                     ELSE
                        NULL
                  END
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '57A')
             acc_bank_beneficar,
          (SELECT sb.name
             FROM bars.sw_banks sb
            WHERE sb.bic =
                     (SELECT CASE SUBSTR (ow.VALUE, 1, 1)
                                WHEN '/'
                                THEN
                                    SUBSTR (trim(ow.VALUE), -11)
                                ELSE
                                   trim(SUBSTR (ow.VALUE, 1, 11))
                             END
                        FROM bars.operw ow
                       WHERE ow.REF = o.REF AND ow.tag = '57A'))
             name_bank_beneficar,
          (SELECT CASE SUBSTR (ow.VALUE, 1, 1)
                     WHEN '/'
                     THEN
                           SUBSTR (trim(ow.VALUE),-11)
                     ELSE
                        trim(SUBSTR (ow.VALUE, 1, 11))
                  END
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '57A')
             bic_bank_beneficar,
          (SELECT sb.office || ', ' || sb.country
             FROM bars.sw_banks sb
            WHERE sb.bic =
                       (SELECT CASE SUBSTR (ow.VALUE, 1, 1)
                                WHEN '/'
                                THEN
                                   SUBSTR (trim(ow.VALUE),-11)
                                ELSE
                                   trim(SUBSTR (ow.VALUE, 1, 11))
                             END
                        FROM bars.operw ow
                       WHERE ow.REF = o.REF AND ow.tag = '57A'))
             address_bank_beneficar,
          (SELECT SUBSTR (ow.VALUE,
                          2)
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '59')
             acc_beneficar,
          (SELECT SUBSTR (ow.VALUE,
                            INSTR (ow.VALUE,
                                   '/',
                                   1,
                                   2)
                          + 1,
                            INSTR (ow.VALUE,
                                   '/',
                                   1,
                                   3)
                          - (INSTR (ow.VALUE,
                                   '/',
                                   1,
                                   2) + 1))
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '59')
             name_beneficar,
          (SELECT SUBSTR (ow.VALUE,
                            INSTR (ow.VALUE,
                                   '/',
                                   1,
                                   3)
                          + 1)
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '59')
             address_beneficar,
          (SELECT replace(replace(ow.VALUE,chr(10),''), chr(13), '')
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '70')
             remit_info,
          (SELECT ow.VALUE
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = '71A')
             detail_charge,
          o.mfoa code_payer_bank,
          (SELECT c.okpo
             FROM bars.customer c, bars.accounts a
            WHERE a.rnk = c.rnk AND a.nls = o.nlsa AND a.kv = o.kv)
             okpo_payer,
          (SELECT ow.VALUE
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = 'N')
             code_oper,
          (SELECT ow.VALUE
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = 'n')
             code_country,
          (SELECT SUBSTR (ow.VALUE, 1, INSTR (ow.VALUE, ',') - 1)
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = 'CLV01')
             signature1,
          (SELECT SUBSTR (ow.VALUE, 1, INSTR (ow.VALUE, ',') - 1)
             FROM bars.operw ow
            WHERE ow.REF = o.REF AND ow.tag = 'CLV02')
             signature2,
          (SELECT TO_CHAR (ov.dat, 'dd.mm.yyyy')
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 7)
             date_val_kont,
          (SELECT TO_CHAR (ov.dat, 'hh24.mi.ss')
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 7)
             time_val_kont,
          (SELECT ov.username
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 7)
             username_val_kont,
          'AT "Ощадбанк"' first_name_bank_val_kont,
          (SELECT ov.kf
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 7)
             code_bank_val_kont,
          (SELECT br.name
             FROM bars.branch br
            WHERE br.branch =    '/'
                              || (SELECT ov.kf
                                    FROM oper_visa ov
                                   WHERE ov.REF = o.REF AND ov.groupid = 7)
                              || '/')
             name_bank_val_kont,
          (SELECT TO_CHAR (ov.dat, 'dd.mm.yyyy')
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 11)
             date_complete,
          (SELECT TO_CHAR (ov.dat, 'hh24.mi.ss')
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 11)
             time_complete,
          (SELECT ov.username
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 11)
             username_complete,
          'AT "Ощадбанк"' first_name_bank_complete,
          (SELECT ov.kf
             FROM bars.oper_visa ov
            WHERE ov.REF = o.REF AND ov.groupid = 11)
             code_bank_complete,
          (SELECT br.name
             FROM bars.branch br
            WHERE br.branch =    '/'
                              || (SELECT ov.kf
                                    FROM oper_visa ov
                                   WHERE ov.REF = o.REF AND ov.groupid = 11)
                              || '/')
             name_bank_complete
     FROM bars.tmp_cl_payment tcp, bars.oper o
    WHERE tcp.REF = o.REF AND tcp.TYPE = 2;
/


Prompt Grants on VIEW V_CL_SWIFT_DOCUMENTS TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_CL_SWIFT_DOCUMENTS TO BARS_ACCESS_DEFROLE
/
