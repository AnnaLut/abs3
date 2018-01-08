

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S190.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S190 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S190'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S190'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S190'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S190 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S190 
   (	S190 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S190 ***
 exec bpa.alter_policies('SP_S190');


COMMENT ON TABLE BARS.SP_S190 IS 'Справочник кодов пролонгации';
COMMENT ON COLUMN BARS.SP_S190.S190 IS 'Код пролонгации';
COMMENT ON COLUMN BARS.SP_S190.TXT IS 'Наименование';




PROMPT *** Create  constraint XPK_SP_S190 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S190 ADD CONSTRAINT XPK_SP_S190 PRIMARY KEY (S190)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SP_S190 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SP_S190 ON BARS.SP_S190 (S190) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SP_S190 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S190         to ABS_ADMIN;
grant SELECT                                                                 on SP_S190         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S190         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S190         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S190         to SP_S190;
grant SELECT                                                                 on SP_S190         to START1;
grant SELECT                                                                 on SP_S190         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S190         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SP_S190         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S190.sql =========*** End *** =====
PROMPT ===================================================================================== 
