update SOCIAL_AGENCY
   set DATE_OFF = null
 where DETAILS like 'Duplicate of social agency #%'
   and DATE_OFF Is Not Null;

commit;
