

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_GRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_GRP ***

begin 
    bpa.alter_policy_info(p_table_name    => 'STO_GRP', p_policy_group  => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null);
    bpa.alter_policy_info(p_table_name    => 'STO_GRP', p_policy_group  => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
    bpa.alter_policies('STO_GRP');
end;
/

PROMPT *** Create  table STO_GRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_GRP 
   (  IDG NUMBER(*,0), 
  NAME VARCHAR2(100), 
  OTM CHAR(1), 
  STMP DATE DEFAULT sysdate, 
  TOBO VARCHAR2(12),
  KF VARCHAR2(6) default sys_context(''bars_context'', ''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_GRP ***
 exec bpa.alter_policies('STO_GRP');


COMMENT ON TABLE BARS.STO_GRP IS '������ ���������� ��������';
COMMENT ON COLUMN BARS.STO_GRP.IDG IS '��� �������.������';
COMMENT ON COLUMN BARS.STO_GRP.NAME IS '������������ �������.������';
COMMENT ON COLUMN BARS.STO_GRP.OTM IS '';
COMMENT ON COLUMN BARS.STO_GRP.STMP IS '';
COMMENT ON COLUMN BARS.STO_GRP.TOBO IS '��� ��������';


PROMPT *** Create  constraint CC_STOGRP_IDG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_GRP MODIFY (IDG CONSTRAINT CC_STOGRP_IDG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOGRP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_GRP MODIFY (NAME CONSTRAINT CC_STOGRP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** DROP   constraint PK_STOGRP ***
begin
 execute immediate '
   ALTER TABLE BARS.STO_GRP DROP CONSTRAINT PK_STOGRP
   ';
exception when others then 
  if  sqlcode=-02443 then null; else raise; end if;
end ;
/

PROMPT *** DROP  index PK_STOGRP ***
begin
 execute immediate '
    DROP INDEX PK_STOGRP
   ';
exception when others then 
  if  sqlcode=-02443 or sqlcode=-01418 then null; else raise; end if;
end ;
/


PROMPT *** Create  constraint PK_STOGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_GRP ADD CONSTRAINT PK_STOGRP PRIMARY KEY (KF,IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/




PROMPT *** Create  grants  STO_GRP ***
grant SELECT                                                                 on STO_GRP         to BARSREADER_ROLE;
grant SELECT                                                                 on STO_GRP         to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_GRP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_GRP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_GRP         to STO;
grant SELECT                                                                 on STO_GRP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_GRP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STO_GRP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_GRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
