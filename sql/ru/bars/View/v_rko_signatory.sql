CREATE OR REPLACE FORCE VIEW BARS.V_RKO_SIGNATORY
(
   ID,
   FULL_NM_NOM,
   FULL_NM_GEN,
   SHORT_NM_NOM,
   POSITION_PRSN_NOM,
   DIVISION_PRSN_GEN,
   POSITION_PRSN_GEN,
   DOC_NM_GEN,
   NOTARY_NM_GEN,
   NOTARY_TP_GEN,
   ATTORNEY_DT,
   ATTORNEY_NUM,
   NOTARIAL_DISTRICT_GEN,
   ACTIVE_F,
   BRANCH,
   KF
)
AS
     SELECT ID,
            FULL_NM_NOM,
            FULL_NM_GEN,
            SHORT_NM_NOM,
            POSITION_PRSN_NOM,
            DIVISION_PRSN_GEN,
            POSITION_PRSN_GEN,
            DOC_NM_GEN,
            NOTARY_NM_GEN,
            NOTARY_TP_GEN,
            ATTORNEY_DT,
            ATTORNEY_NUM,
            NOTARIAL_DISTRICT_GEN,
            ACTIVE_F,
            BRANCH,
			KF
       FROM RKO_SIGNATORY
      WHERE    (    LENGTH (SYS_CONTEXT ('bars_context', 'user_branch')) = 8
                AND BRANCH LIKE
                       SYS_CONTEXT ('bars_context', 'user_branch_mask'))
            OR (    LENGTH (SYS_CONTEXT ('bars_context', 'user_branch')) > 8
                AND BRANCH IN (SYS_CONTEXT ('bars_context', 'user_branch'),
                               SUBSTR (
                                  SYS_CONTEXT ('bars_context', 'user_branch'),
                                  1,
                                  8)))
   ORDER BY branch, full_nm_nom;


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_RKO_SIGNATORY TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_RKO_SIGNATORY TO START1;


comment on table bars.v_rko_signatory is 'Довідник підписантва РКО';
comment on column bars.v_rko_signatory.FULL_NM_NOM is 'ПІБ уповноваженої особи від Банку повністю (НВ)';
comment on column bars.v_rko_signatory.FULL_NM_GEN is 'ПІБ уповноваженої особи від Банку повністю (РВ)';
comment on column bars.v_rko_signatory.SHORT_NM_NOM is 'ПІБ уповноваженої особи від Банку скорочено (НВ)';
comment on column bars.v_rko_signatory.POSITION_PRSN_NOM is 'Посада уповноваженої особи від Банку (НВ)';
comment on column bars.v_rko_signatory.DIVISION_PRSN_GEN is 'Підрозділ уповноваженої особи від Банку (РВ)';
comment on column bars.v_rko_signatory.POSITION_PRSN_GEN is 'Посада уповноваженої особи від Банку (РВ)';
comment on column bars.v_rko_signatory.DOC_NM_GEN is 'Назва документу, на підставі якого діє уповноважена особа від Банку (РВ)';
comment on column bars.v_rko_signatory.NOTARY_NM_GEN is 'ПІБ нотаріуса, який посвідчив довіреність уповноваженої особи від Банку (РВ)';
comment on column bars.v_rko_signatory.NOTARY_TP_GEN is 'Вид нотаріуса (приватний / державний) (РВ)';
comment on column bars.v_rko_signatory.ATTORNEY_DT is 'Дата довіреності';
comment on column bars.v_rko_signatory.ATTORNEY_NUM is '№ довіреності';
comment on column bars.v_rko_signatory.NOTARIAL_DISTRICT_GEN is 'Нотаріальний округ (РВ)';
comment on column bars.v_rko_signatory.ACTIVE_F is 'Використовувати для друку 0-Ні,1-Так';   
comment on column bars.v_rko_signatory.branch is 'Код відділення';  
    

