

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ZAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ZAL ***


BEGIN 
        execute immediate  
          'begin  
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
   (	ID NUMBER(38,0), 
	REF NUMBER(*,0), 
	KOLZ NUMBER(*,0), 
	DATZ DATE
   ) SEGMENT CREATION DEFERRED 
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
COMMENT ON COLUMN BARS.CP_ZAL.ID IS 'Код ЦП (ID)';
COMMENT ON COLUMN BARS.CP_ZAL.REF IS 'Реф-с угоди куп_вл_ пакета';
COMMENT ON COLUMN BARS.CP_ZAL.KOLZ IS 'К_льк_сть в застав_ (пакет або доля пакета )';
COMMENT ON COLUMN BARS.CP_ZAL.DATZ IS 'Дата включення в заставу';




PROMPT *** Create  constraint XPK_CPZAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL ADD CONSTRAINT XPK_CPZAL PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685955 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ZAL MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
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



PROMPT *** Create  grants  CP_ZAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ZAL          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ZAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
