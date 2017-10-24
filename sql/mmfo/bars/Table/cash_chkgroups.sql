

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_CHKGROUPS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_CHKGROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_CHKGROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_CHKGROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_CHKGROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_CHKGROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_CHKGROUPS 
   (	CHK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_CHKGROUPS ***
 exec bpa.alter_policies('CASH_CHKGROUPS');


COMMENT ON TABLE BARS.CASH_CHKGROUPS IS 'Группы контроля, которые суть - виза кассира или кассира хранилица(сховище)';
COMMENT ON COLUMN BARS.CASH_CHKGROUPS.CHK IS '';




PROMPT *** Create  constraint XFK_CASHCHKGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_CHKGROUPS ADD CONSTRAINT XFK_CASHCHKGROUPS FOREIGN KEY (CHK)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_CASHCHKGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_CASHCHKGROUPS ON BARS.CASH_CHKGROUPS (CHK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_CHKGROUPS ***
grant SELECT                                                                 on CASH_CHKGROUPS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_CHKGROUPS  to BARS_DM;
grant SELECT                                                                 on CASH_CHKGROUPS  to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_CHKGROUPS.sql =========*** End **
PROMPT ===================================================================================== 
