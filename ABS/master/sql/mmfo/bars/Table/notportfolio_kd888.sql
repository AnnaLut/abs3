

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTPORTFOLIO_KD888.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTPORTFOLIO_KD888 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTPORTFOLIO_KD888'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTPORTFOLIO_KD888 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTPORTFOLIO_KD888 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTPORTFOLIO_KD888 ***
 exec bpa.alter_policies('NOTPORTFOLIO_KD888');


COMMENT ON TABLE BARS.NOTPORTFOLIO_KD888 IS '';
COMMENT ON COLUMN BARS.NOTPORTFOLIO_KD888.NBS IS '';



PROMPT *** Create  grants  NOTPORTFOLIO_KD888 ***
grant SELECT                                                                 on NOTPORTFOLIO_KD888 to BARSREADER_ROLE;
grant SELECT                                                                 on NOTPORTFOLIO_KD888 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTPORTFOLIO_KD888.sql =========*** En
PROMPT ===================================================================================== 
