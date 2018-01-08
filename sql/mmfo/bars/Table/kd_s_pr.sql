

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KD_S_PR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KD_S_PR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KD_S_PR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KD_S_PR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KD_S_PR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KD_S_PR ***
begin 
  execute immediate '
  CREATE TABLE BARS.KD_S_PR 
   (	S_PR NUMBER(*,0), 
	NAME VARCHAR2(35), 
	NLS VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KD_S_PR ***
 exec bpa.alter_policies('KD_S_PR');


COMMENT ON TABLE BARS.KD_S_PR IS '';
COMMENT ON COLUMN BARS.KD_S_PR.S_PR IS '';
COMMENT ON COLUMN BARS.KD_S_PR.NAME IS '';
COMMENT ON COLUMN BARS.KD_S_PR.NLS IS '';



PROMPT *** Create  grants  KD_S_PR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KD_S_PR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KD_S_PR         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KD_S_PR         to KD_888;
grant FLASHBACK,SELECT                                                       on KD_S_PR         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KD_S_PR.sql =========*** End *** =====
PROMPT ===================================================================================== 
