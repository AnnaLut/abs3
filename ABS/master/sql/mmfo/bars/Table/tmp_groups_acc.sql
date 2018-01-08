

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GROUPS_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GROUPS_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_GROUPS_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_GROUPS_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_GROUPS_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GROUPS_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_GROUPS_ACC 
   (	IDA NUMBER, 
	ACC NUMBER, 
	 CONSTRAINT XPK_TPM_GROUPS_ACC PRIMARY KEY (ACC, IDA) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GROUPS_ACC ***
 exec bpa.alter_policies('TMP_GROUPS_ACC');


COMMENT ON TABLE BARS.TMP_GROUPS_ACC IS '';
COMMENT ON COLUMN BARS.TMP_GROUPS_ACC.IDA IS '';
COMMENT ON COLUMN BARS.TMP_GROUPS_ACC.ACC IS '';




PROMPT *** Create  constraint XPK_TPM_GROUPS_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GROUPS_ACC ADD CONSTRAINT XPK_TPM_GROUPS_ACC PRIMARY KEY (ACC, IDA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TPM_GROUPS_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TPM_GROUPS_ACC ON BARS.TMP_GROUPS_ACC (ACC, IDA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_GROUPS_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_GROUPS_ACC  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_GROUPS_ACC  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GROUPS_ACC.sql =========*** End **
PROMPT ===================================================================================== 
