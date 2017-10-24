exec bpa.alter_policy_info( 'CC_DEAL_PROBL', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'CC_DEAL_PROBL', 'FILIAL', null, null, null, null );

 begin
        execute immediate '
        CREATE TABLE BARS.CC_DEAL_PROBL
        (
          ND            NUMBER(38),
          KF            VARCHAR2(6 BYTE),
          BRANCH        VARCHAR2(30 BYTE),
          OKPO          VARCHAR2(14 BYTE),
          NMK           VARCHAR2(70 BYTE),
          CC_ID         VARCHAR2(50 BYTE),
          SDATE         DATE,
          WDATE         DATE,
          PROD          VARCHAR2(100 BYTE),
          KV            NUMBER(3),
          ST_NOM_NG     NUMBER(24,2),
          ST_EQV_NG     NUMBER(24,2),
          SP_NOM_NG     NUMBER(24,2),
          SP_EQV_NG     NUMBER(24,2),
          ST_NOM_OD     NUMBER(24,2),
          ST_EQV_OD     NUMBER(24,2),
          SP_NOM_OD     NUMBER(24,2),
          SP_EQV_OD     NUMBER(24,2),
          KAT_J         INTEGER,
          DAT_MAX_ZB    DATE,
          DAT_SP_NOBAL  DATE,
          DAT_P_KK      DATE,
          POG_SS_NOM    NUMBER(24,2),
          POG_SS_EQV    NUMBER(24,2),
          POG_SN_NOM    NUMBER(24,2),
          POG_SN_EQV    NUMBER(24,2)
        )
        TABLESPACE BRSDYND
        RESULT_CACHE (MODE DEFAULT)
        PCTUSED    0
        PCTFREE    10
        INITRANS   1
        MAXTRANS   255
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MAXSIZE          UNLIMITED
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                    FLASH_CACHE      DEFAULT
                    CELL_FLASH_CACHE DEFAULT
                   )
        LOGGING 
        NOCOMPRESS 
        NOCACHE
        NOPARALLEL
        MONITORING';
 exception when others then if (sqlcode = -00955) then null; end if; 
            
 end;
 /

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.CC_DEAL_PROBL TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.CC_DEAL_PROBL TO RCC_DEAL;

update operlist set funcname = '/barsroot/ndi/referencebook/GetRefBookData/?tableName=CC_DEAL_PROBL'||chr(38)||'accessCode=1'||chr(38)||'sPar=[PROC=>P_CCK_PROBL(:Par0,11)][PAR=>:Par0(SEM= На дату ,TYPE=D)][EXEC=>BEFORE]'
where funcname like '/barsroot/ndi/referencebook/GetRefBookData/?tableName=TMP_CC_DEAL_PROBL'||chr(38)||'accessCode=1'||chr(38)||'sPar=[PROC=>P_CCK_PROBL(:Par0,11)][PAR=>:Par0(SEM= На дату ,TYPE=D)][EXEC=>BEFORE]';

commit;

UPDATE meta_tables set TABNAME = 'CC_DEAL_PROBL' where TABNAME = 'TMP_CC_DEAL_PROBL';

commit;
