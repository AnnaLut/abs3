

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEY2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEY2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEY2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MONEY2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEY2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEY2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEY2 
   (	ID NUMBER(*,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	TXT VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEY2 ***
 exec bpa.alter_policies('MONEY2');


COMMENT ON TABLE BARS.MONEY2 IS 'Котловi рах для обiлiку Закордонних переказiв ФО';
COMMENT ON COLUMN BARS.MONEY2.ID IS 'Код напряму';
COMMENT ON COLUMN BARS.MONEY2.NBS IS 'Бал.рах';
COMMENT ON COLUMN BARS.MONEY2.OB22 IS 'Об22';
COMMENT ON COLUMN BARS.MONEY2.TXT IS 'Призначення';




PROMPT *** Create  constraint PK_MONEY2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEY2 ADD CONSTRAINT PK_MONEY2 PRIMARY KEY (ID, NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MONEY2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MONEY2 ON BARS.MONEY2 (ID, NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEY2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEY2          to ABS_ADMIN;
grant SELECT                                                                 on MONEY2          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MONEY2          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEY2          to BARS_DM;
grant SELECT                                                                 on MONEY2          to START1;
grant SELECT                                                                 on MONEY2          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEY2.sql =========*** End *** ======
PROMPT ===================================================================================== 
