

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PLKR.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PLKR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PLKR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PLKR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PLKR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PLKR ***
begin 
  execute immediate '
  CREATE TABLE BARS.PLKR 
   (	ACC NUMBER, 
	PK1 NUMBER, 
	PKP NUMBER(20,4), 
	RK1 NUMBER, 
	RKR NUMBER(20,4), 
	PS1 NUMBER, 
	PSP NUMBER(20,4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PLKR ***
 exec bpa.alter_policies('PLKR');


COMMENT ON TABLE BARS.PLKR IS '';
COMMENT ON COLUMN BARS.PLKR.ACC IS '';
COMMENT ON COLUMN BARS.PLKR.PK1 IS '';
COMMENT ON COLUMN BARS.PLKR.PKP IS '';
COMMENT ON COLUMN BARS.PLKR.RK1 IS '';
COMMENT ON COLUMN BARS.PLKR.RKR IS '';
COMMENT ON COLUMN BARS.PLKR.PS1 IS '';
COMMENT ON COLUMN BARS.PLKR.PSP IS '';



PROMPT *** Create  grants  PLKR ***
grant SELECT                                                                 on PLKR            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PLKR            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PLKR            to START1;
grant SELECT                                                                 on PLKR            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PLKR.sql =========*** End *** ========
PROMPT ===================================================================================== 
