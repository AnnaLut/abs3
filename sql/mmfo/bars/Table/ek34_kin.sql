

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK34_KIN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK34_KIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK34_KIN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK34_KIN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK34_KIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK34_KIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK34_KIN 
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




PROMPT *** ALTER_POLICIES to EK34_KIN ***
 exec bpa.alter_policies('EK34_KIN');


COMMENT ON TABLE BARS.EK34_KIN IS '';
COMMENT ON COLUMN BARS.EK34_KIN.NBS IS '';
COMMENT ON COLUMN BARS.EK34_KIN.NAME IS '';
COMMENT ON COLUMN BARS.EK34_KIN.PAP IS '';



PROMPT *** Create  grants  EK34_KIN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK34_KIN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK34_KIN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK34_KIN        to EK34_KIN;
grant FLASHBACK,SELECT                                                       on EK34_KIN        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK34_KIN.sql =========*** End *** ====
PROMPT ===================================================================================== 
