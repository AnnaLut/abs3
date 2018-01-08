

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REKLAMA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REKLAMA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REKLAMA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REKLAMA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REKLAMA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REKLAMA ***
begin 
  execute immediate '
  CREATE TABLE BARS.REKLAMA 
   (	TT CHAR(3), 
	TEXT VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REKLAMA ***
 exec bpa.alter_policies('REKLAMA');


COMMENT ON TABLE BARS.REKLAMA IS '';
COMMENT ON COLUMN BARS.REKLAMA.TT IS '';
COMMENT ON COLUMN BARS.REKLAMA.TEXT IS '';




PROMPT *** Create  constraint PK_REKLAMA ***
begin   
 execute immediate '
  ALTER TABLE BARS.REKLAMA ADD CONSTRAINT PK_REKLAMA PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REKLAMA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REKLAMA ON BARS.REKLAMA (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REKLAMA ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REKLAMA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REKLAMA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REKLAMA         to START1;
grant FLASHBACK,SELECT                                                       on REKLAMA         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REKLAMA.sql =========*** End *** =====
PROMPT ===================================================================================== 
