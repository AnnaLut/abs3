

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_OB_INITIATOR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_OB_INITIATOR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_OB_INITIATOR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_OB_INITIATOR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_OB_INITIATOR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_OB_INITIATOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_OB_INITIATOR 
   (	CODE VARCHAR2(2), 
	TXT VARCHAR2(70), 
	FD_3540 VARCHAR2(15), 
	FD_3640 VARCHAR2(15), 
	FX_3540 VARCHAR2(15), 
	FX_3640 VARCHAR2(15), 
	FX_3800 VARCHAR2(15), 
	FX_6204 VARCHAR2(15), 
	FX_DATP DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_OB_INITIATOR ***
 exec bpa.alter_policies('CP_OB_INITIATOR');


COMMENT ON TABLE BARS.CP_OB_INITIATOR IS '_н_ц_атор операц_й з ЦП';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.CODE IS 'Код _н_ц_атора';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.TXT IS 'Назва';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FD_3540 IS '';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FD_3640 IS '';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FX_3540 IS '';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FX_3640 IS '';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FX_3800 IS 'Рах-к 3800';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FX_6204 IS '';
COMMENT ON COLUMN BARS.CP_OB_INITIATOR.FX_DATP IS 'Дата операц_ї';




PROMPT *** Create  constraint PK_CPOBINITIATOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_OB_INITIATOR ADD CONSTRAINT PK_CPOBINITIATOR PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009640 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_OB_INITIATOR MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPOBINITIATOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPOBINITIATOR ON BARS.CP_OB_INITIATOR (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_OB_INITIATOR ***
grant SELECT                                                                 on CP_OB_INITIATOR to BARSREADER_ROLE;
grant SELECT                                                                 on CP_OB_INITIATOR to BARSUPL;
grant FLASHBACK,SELECT                                                       on CP_OB_INITIATOR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_OB_INITIATOR to BARS_DM;
grant SELECT                                                                 on CP_OB_INITIATOR to UPLD;
grant FLASHBACK,SELECT                                                       on CP_OB_INITIATOR to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_OB_INITIATOR.sql =========*** End *
PROMPT ===================================================================================== 
