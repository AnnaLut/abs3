

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_EMIW.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_EMIW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_EMIW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_EMIW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_EMIW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_EMIW ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_EMIW 
   (	RNK NUMBER, 
	TAG VARCHAR2(5), 
	VALUE VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_EMIW ***
 exec bpa.alter_policies('CP_EMIW');


COMMENT ON TABLE BARS.CP_EMIW IS 'Доп.реквизиты эмитента ЦБ';
COMMENT ON COLUMN BARS.CP_EMIW.RNK IS 'РНК клиента-эмитента';
COMMENT ON COLUMN BARS.CP_EMIW.TAG IS 'ТЭГ -мнем.код доп.реквизита';
COMMENT ON COLUMN BARS.CP_EMIW.VALUE IS 'Значение доп.реквизита';




PROMPT *** Create  constraint XPK_CPEMIW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_EMIW ADD CONSTRAINT XPK_CPEMIW PRIMARY KEY (RNK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CPEMIW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPEMIW ON BARS.CP_EMIW (RNK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_EMIW ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_EMIW         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_EMIW         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_EMIW.sql =========*** End *** =====
PROMPT ===================================================================================== 
