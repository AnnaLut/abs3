

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_CAP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_CAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_CAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_CAP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_CAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_CAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_CAP 
   (	NBS CHAR(4), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_CAP ***
 exec bpa.alter_policies('INT_CAP');


COMMENT ON TABLE BARS.INT_CAP IS 'Балансовi для Зарахування % за залишки';
COMMENT ON COLUMN BARS.INT_CAP.NBS IS 'Бал.рах.';
COMMENT ON COLUMN BARS.INT_CAP.OB22 IS 'Код ОБ22';




PROMPT *** Create  constraint PK_INTCAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_CAP ADD CONSTRAINT PK_INTCAP PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTCAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTCAP ON BARS.INT_CAP (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_CAP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_CAP         to ABS_ADMIN;
grant DELETE,INSERT,SELECT                                                   on INT_CAP         to BARS010;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_CAP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_CAP         to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on INT_CAP         to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_CAP.sql =========*** End *** =====
PROMPT ===================================================================================== 
