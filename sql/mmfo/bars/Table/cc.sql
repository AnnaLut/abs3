

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC 
   (	N_CC VARCHAR2(90), 
	K_CC CHAR(2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC ***
 exec bpa.alter_policies('CC');


COMMENT ON TABLE BARS.CC IS '';
COMMENT ON COLUMN BARS.CC.N_CC IS '';
COMMENT ON COLUMN BARS.CC.K_CC IS '';



PROMPT *** Create  grants  CC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC              to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC              to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC.sql =========*** End *** ==========
PROMPT ===================================================================================== 
