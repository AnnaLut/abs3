

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_QUEUE_UPDATECARD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_QUEUE_UPDATECARD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_QUEUE_UPDATECARD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_QUEUE_UPDATECARD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_QUEUE_UPDATECARD ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_QUEUE_UPDATECARD 
   (	RNK NUMBER(38,0), 
	STATUS NUMBER(1,0) DEFAULT 0, 
	INSERT_DATE DATE DEFAULT trunc(sysdate), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_QUEUE_UPDATECARD ***
 exec bpa.alter_policies('EBK_QUEUE_UPDATECARD');


COMMENT ON TABLE BARS.EBK_QUEUE_UPDATECARD IS 'Черга клієнтів для формування пакету оновлень';
COMMENT ON COLUMN BARS.EBK_QUEUE_UPDATECARD.RNK IS '';
COMMENT ON COLUMN BARS.EBK_QUEUE_UPDATECARD.STATUS IS '';
COMMENT ON COLUMN BARS.EBK_QUEUE_UPDATECARD.INSERT_DATE IS '';
COMMENT ON COLUMN BARS.EBK_QUEUE_UPDATECARD.BRANCH IS '';




PROMPT *** Create  index INDX_EBK_UPD_CARD ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_EBK_UPD_CARD ON BARS.EBK_QUEUE_UPDATECARD (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_QUEUE_UPDATECARD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_QUEUE_UPDATECARD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_QUEUE_UPDATECARD.sql =========*** 
PROMPT ===================================================================================== 
