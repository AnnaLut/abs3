UPDATE w4_nbs_ob22 
SET OB_2203I =  'C6',
  OB_2203OVDI = 'C7',
  OB_2208I = 'L9',
  OB_2208OVDI = 'M0',
  OB_3570OVDI = '54',
  OB_9129I = '38',
  OB_3570I = '53'
WHERE OB_OVR IS NOT NULL;
/
commit;
/