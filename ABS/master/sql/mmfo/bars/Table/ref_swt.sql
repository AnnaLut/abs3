

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_SWT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_SWT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REF_SWT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REF_SWT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REF_SWT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_SWT ***
begin 
  execute immediate '
  CREATE TABLE BARS.REF_SWT 
   (	MFOA VARCHAR2(12), 
	MFOB VARCHAR2(12), 
	REF VARCHAR2(16), 
	REC NUMBER, 
	BIS NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_SWT ***
 exec bpa.alter_policies('REF_SWT');


COMMENT ON TABLE BARS.REF_SWT IS '';
COMMENT ON COLUMN BARS.REF_SWT.MFOA IS '';
COMMENT ON COLUMN BARS.REF_SWT.MFOB IS '';
COMMENT ON COLUMN BARS.REF_SWT.REF IS '';
COMMENT ON COLUMN BARS.REF_SWT.REC IS '';
COMMENT ON COLUMN BARS.REF_SWT.BIS IS '';



PROMPT *** Create  grants  REF_SWT ***
grant SELECT                                                                 on REF_SWT         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_SWT         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_SWT         to START1;
grant SELECT                                                                 on REF_SWT         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_SWT.sql =========*** End *** =====
PROMPT ===================================================================================== 
