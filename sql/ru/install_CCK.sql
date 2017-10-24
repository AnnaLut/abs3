SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET TRIMSPOOL    ON
SET TIMING       OFF

spool log\install.log

prompt ..........................................
prompt ... loading params
prompt ..........................................

@params.sql

prompt ..........................................
prompt ... dbname     = &&dbname
prompt ... bars_pass  = &&bars_pass
prompt ..........................................

prompt ..........................................
prompt ...
prompt ... Conecting as BARS to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn bars\&&bars_pass@&&dbname
WHENEVER SQLERROR CONTINUE

select to_char(sysdate,'DD\MM\YYYY HH24:MI:SS') "Start at"
  from dual;
  

 
prompt ...bars\T2_SNO.sql
@sql\bars\Table\T2_SNO.sql

prompt ...bars\V_CCK_RF.sql
@sql\bars\view\V_CCK_RF.sql

prompt ...bars\V_INTEREST_CCK.sql
@sql\bars\view\V_INTEREST_CCK.sql

prompt ...bars\V0_SNO.sql
@sql\bars\view\V0_SNO.sql

prompt ...bars\V11_SNO_FL.sql
@sql\bars\view\V11_SNO_FL.sql

prompt ...bars\V12_SNO_FL.sql
@sql\bars\view\V12_SNO_FL.sql

prompt ...bars\V1_SNO.sql
@sql\bars\view\V1_SNO.sql

prompt ...bars\V1_SNO_FL.sql
@sql\bars\view\V1_SNO_FL.sql

prompt ...bars\V3_SNO.sql
@sql\bars\view\V3_SNO.sql

prompt ...bars\VB_SNO.sql
@sql\bars\view\VB_SNO.sql

prompt ...bars\vc_sno.sql
@sql\bars\view\vc_sno.sql

prompt ...bars\V2_SNO.sql
@sql\bars\view\V2_SNO.sql

prompt ...bars\V_ZAL_ND_NEW.sql
@sql\bars\view\V_ZAL_ND_NEW.sql

prompt ...bars\CC_W_TRANSH.sql
@sql\bars\view\CC_W_TRANSH.sql


prompt ...bars\V_ZAL_ND_NOT_NEW.sql
@sql\bars\view\V_ZAL_ND_NOT_NEW.sql

prompt ...bars\V_ZAL_ND_NEW.sql
@sql\bars\view\V_ZAL_ND_NEW.sql

prompt ...bars\V_INTEREST_CCK_ND.sql
@sql\bars\view\V_INTEREST_CCK_ND.sql

prompt ...bars\V_INTEREST_CCK.sql
@sql\bars\view\V_INTEREST_CCK.sql

prompt ...bars\grants.sql
@sql\bars\Grant\grants.sql

prompt ...bars\m_V_CCK_RF.sql
@sql\bars\data\m_V_CCK_RF.sql

prompt ...bars\m_CC_W017.sql
@sql\bars\data\m_CC_W017.sql

prompt ...bars\operlist_insert
@sql\bars\data\operlist_insert

prompt ...bars\update_chklist_tts.sql
@sql\bars\data\update_chklist_tts.sql


prompt ...bars\m_CC_W_LIM.sql
@sql\bars\data\m_CC_W_LIM.sql

prompt ...bars\m_V_CCK_RU.sql
@sql\bars\data\m_V_CCK_RU.sql

prompt ...bars\m_V_INTEREST_CCK.sql
@sql\bars\data\m_V_INTEREST_CCK.sql

prompt ...bars\m_SNO.sql
@sql\bars\data\m_SNO.sql

prompt ...bars\m_V_INTEREST_CCK_ND.sql
@sql\bars\data\m_V_INTEREST_CCK_ND.sql


prompt ...bars\vidd_tip_update.sql
@sql\bars\data\vidd_tip_update.sql

prompt ...bars\CCK.pks
@sql\bars\Header\CCK.pks

prompt ...bars\cck_ui.pks
@sql\bars\Header\cck_ui.pks


prompt ...bars\CCK.pkb
@sql\bars\Package\CCK.pkb

prompt ...bars\cck_ui.pkb
@sql\bars\Package\cck_ui.pkb

prompt ...bars\p_interest_cck1.prc
@sql\bars\Procedure\p_interest_cck1.prc


prompt ...bars\p_set_pawn_acc_list.prc
@sql\bars\Procedure\p_set_pawn_acc_list.prc


prompt ...bars\grants.sql
@sql\bars\Grant\grants.sql

spool off

quit

