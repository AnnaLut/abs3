

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PASSPV.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PASSPV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PASSPV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PASSPV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PASSPV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PASSPV ***
begin 
  execute immediate '
  CREATE TABLE BARS.PASSPV 
   (	PASSP NUMBER(*,0), 
	NAME VARCHAR2(250), 
	REZID NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PASSPV ***
 exec bpa.alter_policies('PASSPV');


COMMENT ON TABLE BARS.PASSPV IS '';
COMMENT ON COLUMN BARS.PASSPV.PASSP IS '';
COMMENT ON COLUMN BARS.PASSPV.NAME IS '';
COMMENT ON COLUMN BARS.PASSPV.REZID IS '';




PROMPT *** Create  index PK_PASSPV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PASSPV ON BARS.PASSPV (PASSP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PASSPV ***
grant SELECT                                                                 on PASSPV          to BARSREADER_ROLE;
grant SELECT                                                                 on PASSPV          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PASSPV          to BARS_DM;
grant SELECT                                                                 on PASSPV          to START1;
grant SELECT                                                                 on PASSPV          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PASSPV.sql =========*** End *** ======
PROMPT ===================================================================================== 
