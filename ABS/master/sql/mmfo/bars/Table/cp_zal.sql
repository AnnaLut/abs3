

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ZAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ZAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ZAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ZAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ZAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ZAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ZAL 
   (	REF NUMBER, 
	ID NUMBER, 
	KOLZ NUMBER(*,0), 
	DATZ DATE, 
	RNK NUMBER, 
	ID_CP_ZAL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ZAL ***
 exec bpa.alter_policies('CP_ZAL');


COMMENT ON TABLE BARS.CP_ZAL IS '';
COMMENT ON COLUMN BARS.CP_ZAL.REF IS 'Реф-с угоди куп_вл_ пакета';
COMMENT ON COLUMN BARS.CP_ZAL.ID IS 'Код ЦП (ID)';
COMMENT ON COLUMN BARS.CP_ZAL.KOLZ IS 'К_льк_сть в застав_ (пакет або доля пакета )';
COMMENT ON COLUMN BARS.CP_ZAL.DATZ IS 'Дата включення в заставу';
COMMENT ON COLUMN BARS.CP_ZAL.RNK IS 'Код Контрагента';
COMMENT ON COLUMN BARS.CP_ZAL.ID_CP_ZAL IS 'Код CP_ZAL';




PROMPT *** Create  constraint SYS_C00138693 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL MODIFY (ID_CP_ZAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_U_ID_CP_ZAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IND_U_ID_CP_ZAL ON BARS.CP_ZAL (ID_CP_ZAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CPZAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPZAL ON BARS.CP_ZAL (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_U_CP_ZAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.IND_U_CP_ZAL ON BARS.CP_ZAL (REF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ZAL ***
grant SELECT                                                                 on CP_ZAL          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ZAL          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to START1;
grant SELECT                                                                 on CP_ZAL          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ZAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
