

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK18_VA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK18_VA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK18_VA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK18_VA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK18_VA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK18_VA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK18_VA 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK18_VA ***
 exec bpa.alter_policies('EK18_VA');


COMMENT ON TABLE BARS.EK18_VA IS '';
COMMENT ON COLUMN BARS.EK18_VA.NBS IS '';
COMMENT ON COLUMN BARS.EK18_VA.NAME IS '';
COMMENT ON COLUMN BARS.EK18_VA.PAP IS '';



PROMPT *** Create  grants  EK18_VA ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK18_VA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK18_VA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK18_VA         to EK18_VA;
grant FLASHBACK,SELECT                                                       on EK18_VA         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK18_VA.sql =========*** End *** =====
PROMPT ===================================================================================== 
