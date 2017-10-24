

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/N_GR.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to N_GR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''N_GR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''N_GR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''N_GR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table N_GR ***
begin 
  execute immediate '
  CREATE TABLE BARS.N_GR 
   (	N_GR NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to N_GR ***
 exec bpa.alter_policies('N_GR');


COMMENT ON TABLE BARS.N_GR IS '';
COMMENT ON COLUMN BARS.N_GR.N_GR IS '';
COMMENT ON COLUMN BARS.N_GR.NAME IS '';



PROMPT *** Create  grants  N_GR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on N_GR            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N_GR            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on N_GR            to N_GR;
grant FLASHBACK,SELECT                                                       on N_GR            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/N_GR.sql =========*** End *** ========
PROMPT ===================================================================================== 
