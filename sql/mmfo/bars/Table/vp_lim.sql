

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VP_LIM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VP_LIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VP_LIM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VP_LIM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VP_LIM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VP_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.VP_LIM 
   (	ACC NUMBER(*,0), 
	FDAT DATE, 
	OST_LONG NUMBER, 
	OST_SHORT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VP_LIM ***
 exec bpa.alter_policies('VP_LIM');


COMMENT ON TABLE BARS.VP_LIM IS 'Лимиты на вал.позиции';
COMMENT ON COLUMN BARS.VP_LIM.ACC IS 'Сч. вал поз';
COMMENT ON COLUMN BARS.VP_LIM.FDAT IS 'Дата нач действия';
COMMENT ON COLUMN BARS.VP_LIM.OST_LONG IS 'Лимит на длинную (кредит.ост)';
COMMENT ON COLUMN BARS.VP_LIM.OST_SHORT IS 'Лимит на короткую (дебет.ост)';




PROMPT *** Create  constraint PK_VPLIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIM ADD CONSTRAINT PK_VPLIM PRIMARY KEY (ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VPLIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VPLIM ON BARS.VP_LIM (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VP_LIM ***
grant SELECT                                                                 on VP_LIM          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VP_LIM          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VP_LIM          to SALGL;
grant SELECT                                                                 on VP_LIM          to UPLD;



PROMPT *** Create SYNONYM  to VP_LIM ***

  CREATE OR REPLACE PUBLIC SYNONYM VP_LIM FOR BARS.VP_LIM;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VP_LIM.sql =========*** End *** ======
PROMPT ===================================================================================== 
