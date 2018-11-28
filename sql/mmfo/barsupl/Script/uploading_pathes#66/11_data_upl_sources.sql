-- ***************************************************************************
set verify off
--set define on

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_SOURCES');
end;
/

-- ======================================================================================
-- Изменение списка используемых в выгрузке таблиц
-- ======================================================================================

delete
  from barsupl.UPL_SOURCES 
 where upper(OBJECT_NAME) in ('OW_INST_TOTALS_HIST',
                              'OW_INST_SUB_P_HIST',
                              'OW_INST_PORTIONS',
                              'W4_ACC_INST_UPDATE',
                              'OW_INST_STATUS_DICT',
                              'CP_ACCOUNTS_UPDATE',
                              'VIP_FLAGS_ARC',
                              'INT_RATN_ARC',
                              'BRATES',
                              'BR_TYPES',
                              'CC_TRANS_UPDATE',
                              'DAT_NEXT_U',
                              'PRVN_FLOW.SET_ADJ_SHD',
                              'AGG_MONBALS9',
                              'CC_SOURCE',
                              'OW_OIC_ATRANSFERS_HIST',
                              'V_MBDK_PRODUCT',
                              'BANK_MON_UPD',
                              'BR_TIER_EDIT_UPDATE',
                              'CC_ACCP_ARC',
                              'CC_SOB_UPDATE',
                              'CP_DAT_UPDATE',
                              'CP_HIERARCHY_HIST',
                              'CP_REFW_UPDATE',
                              'CUSTBANK_UPDATE',
                              'DPT_VIDD_UPDATE',
                              'DPU_TAB_UPDATE',
                              'SOS_TRACK',
                              'BR_NORMAL_EDIT_UPDATE',
                              'DPT_DEPOSITW_UPDATE',
                              'DPU_DEALW_UPDATE',
                              'FIN_ND_UPDATE',
                              'XOZ_REF_UPDATE');

Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_INST_TOTALS_HIST', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_INST_SUB_P_HIST', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_INST_PORTIONS', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'W4_ACC_INST_UPDATE', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_INST_STATUS_DICT', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CP_ACCOUNTS_UPDATE', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'VIP_FLAGS_ARC', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'INT_RATN_ARC', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'BRATES', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'BR_TYPES', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CC_TRANS_UPDATE', 'TABLE', 'Y', 'Y');

Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DAT_NEXT_U', 'FUNCTION', 'Y', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'PRVN_FLOW.SET_ADJ_SHD', 'PROCEDURE', 'Y', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'AGG_MONBALS9', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CC_SOURCE', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'OW_OIC_ATRANSFERS_HIST', 'TABLE', 'Y', 'Y');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'V_MBDK_PRODUCT', 'VIEW', 'Y', 'N');

Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'BANK_MON_UPD', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'BR_TIER_EDIT_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CC_ACCP_ARC', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CC_SOB_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CP_DAT_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CP_HIERARCHY_HIST', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CP_REFW_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'CUSTBANK_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DPT_VIDD_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DPU_TAB_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'SOS_TRACK', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'BR_NORMAL_EDIT_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DPT_DEPOSITW_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'DPU_DEALW_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'FIN_ND_UPDATE', 'TABLE', 'N', 'N');
Insert into BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME, OBJECT_TYPE, USED_IN_UPOAD, CHECKED) Values ('BARS', 'XOZ_REF_UPDATE', 'TABLE', 'N', 'N');