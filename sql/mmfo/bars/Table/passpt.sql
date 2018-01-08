

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PASSPT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PASSPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PASSPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PASSPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PASSPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PASSPT 
   (	PASSPT NUMBER(*,0), 
	NAME VARCHAR2(200), 
	RESID NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PASSPT ***
 exec bpa.alter_policies('PASSPT');


COMMENT ON TABLE BARS.PASSPT IS 'Типи документів';
COMMENT ON COLUMN BARS.PASSPT.PASSPT IS 'Код документа';
COMMENT ON COLUMN BARS.PASSPT.NAME IS 'Назва документа';
COMMENT ON COLUMN BARS.PASSPT.RESID IS 'Резидентність';




PROMPT *** Create  constraint SYS_C0011724 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PASSPT ADD PRIMARY KEY (PASSPT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011724 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011724 ON BARS.PASSPT (PASSPT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PASSPT ***
grant SELECT                                                                 on PASSPT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PASSPT          to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PASSPT.sql =========*** End *** ======
PROMPT ===================================================================================== 
