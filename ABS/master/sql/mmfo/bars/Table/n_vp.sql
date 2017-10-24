

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/N_VP.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to N_VP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''N_VP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''N_VP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''N_VP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table N_VP ***
begin 
  execute immediate '
  CREATE TABLE BARS.N_VP 
   (	N_VP NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to N_VP ***
 exec bpa.alter_policies('N_VP');


COMMENT ON TABLE BARS.N_VP IS '';
COMMENT ON COLUMN BARS.N_VP.N_VP IS '';
COMMENT ON COLUMN BARS.N_VP.NAME IS '';



PROMPT *** Create  grants  N_VP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on N_VP            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N_VP            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on N_VP            to N_VP;
grant FLASHBACK,SELECT                                                       on N_VP            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/N_VP.sql =========*** End *** ========
PROMPT ===================================================================================== 
