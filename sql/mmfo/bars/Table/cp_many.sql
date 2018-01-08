

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_MANY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_MANY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_MANY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_MANY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_MANY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_MANY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_MANY 
   (	REF NUMBER(*,0), 
	FDAT DATE, 
	SS1 NUMBER, 
	SDP NUMBER, 
	SN2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_MANY ***
 exec bpa.alter_policies('CP_MANY');


COMMENT ON TABLE BARS.CP_MANY IS '_стор_я зм_н грошових поток_в по договорам ЦП';
COMMENT ON COLUMN BARS.CP_MANY.REF IS 'Реф. договору';
COMMENT ON COLUMN BARS.CP_MANY.FDAT IS 'Дата потоку';
COMMENT ON COLUMN BARS.CP_MANY.SS1 IS 'Сума ном_налу';
COMMENT ON COLUMN BARS.CP_MANY.SDP IS 'Сума Диск/Прем';
COMMENT ON COLUMN BARS.CP_MANY.SN2 IS 'Сума купона';




PROMPT *** Create  constraint XPK_CP_MANY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY ADD CONSTRAINT XPK_CP_MANY PRIMARY KEY (REF, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_MANY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_MANY ON BARS.CP_MANY (REF, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_MANY ***
grant SELECT                                                                 on CP_MANY         to BARSREADER_ROLE;
grant SELECT                                                                 on CP_MANY         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_MANY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_MANY         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_MANY         to START1;
grant SELECT                                                                 on CP_MANY         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_MANY.sql =========*** End *** =====
PROMPT ===================================================================================== 
