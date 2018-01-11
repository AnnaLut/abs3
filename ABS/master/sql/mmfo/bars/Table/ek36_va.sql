

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK36_VA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK36_VA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK36_VA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK36_VA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK36_VA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK36_VA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK36_VA 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK36_VA ***
 exec bpa.alter_policies('EK36_VA');


COMMENT ON TABLE BARS.EK36_VA IS '';
COMMENT ON COLUMN BARS.EK36_VA.NBS IS '';
COMMENT ON COLUMN BARS.EK36_VA.NAME IS '';
COMMENT ON COLUMN BARS.EK36_VA.PAP IS '';



PROMPT *** Create  grants  EK36_VA ***
grant SELECT                                                                 on EK36_VA         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK36_VA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK36_VA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK36_VA         to EK36_VA;
grant SELECT                                                                 on EK36_VA         to UPLD;
grant FLASHBACK,SELECT                                                       on EK36_VA         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK36_VA.sql =========*** End *** =====
PROMPT ===================================================================================== 
